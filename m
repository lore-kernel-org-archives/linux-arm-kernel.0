From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Thu, 18 Oct 2018 22:39:43 +0200
Subject: [PATCH v5 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
In-Reply-To: <1539839345-14021-3-git-send-email-jianxin.pan@amlogic.com>
References: <1539839345-14021-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839345-14021-3-git-send-email-jianxin.pan@amlogic.com>
Message-ID: <20181018223943.145e5497@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Oct 2018 13:09:05 +0800
Jianxin Pan <jianxin.pan@amlogic.com> wrote:

> +static int meson_nfc_calc_set_timing(struct meson_nfc *nfc,
> +				     const struct nand_sdr_timings *timings)
> +{
> +	struct nand_timing *timing = &nfc->timing;
> +	int div, bt_min, bt_max, bus_timing;
> +	int ret;
> +
> +	div = DIV_ROUND_UP((timings->tRC_min / 1000), NFC_CLK_CYCLE);
> +	ret = clk_set_rate(nfc->device_clk, 1000000000 / div);
> +	if (ret) {
> +		dev_err(nfc->dev, "failed to set nand clock rate\n");
> +		return ret;
> +	}
> +
> +	timing->twb = DIV_ROUND_UP(PSEC_TO_NSEC(timings->tWB_max),
> +				   div * NFC_CLK_CYCLE);
> +	timing->tadl = DIV_ROUND_UP(PSEC_TO_NSEC(timings->tADL_min),
> +				    div * NFC_CLK_CYCLE);
> +	timing->twhr = DIV_ROUND_UP(PSEC_TO_NSEC(timings->tWHR_min),
> +				    div * NFC_CLK_CYCLE);
> +
> +	bt_min = (timings->tREA_max + NFC_DEFAULT_DELAY) / div;
> +	bt_max = (NFC_DEFAULT_DELAY + timings->tRHOH_min
> +			+ timings->tRC_min / 2) / div;
> +
> +	bt_min = DIV_ROUND_UP(bt_min, 1000);
> +	bt_max = DIV_ROUND_UP(bt_max, 1000);
> +
> +	if (bt_max < bt_min)
> +		return -EINVAL;
> +
> +	bus_timing = (bt_min + bt_max) / 2 + 1;
> +
> +	writel((1 << 21), nfc->reg_base + NFC_REG_CFG);
> +	writel((NFC_CLK_CYCLE - 1) | (bus_timing << 5),
> +	       nfc->reg_base + NFC_REG_CFG);
> +
> +	writel((1 << 31), nfc->reg_base + NFC_REG_CMD);
> +
> +	return 0;
> +}
> +
> +static int
> +meson_nfc_setup_data_interface(struct nand_chip *nand, int csline,
> +			       const struct nand_data_interface *conf)
> +{
> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
> +	const struct nand_sdr_timings *timings;
> +
> +	timings = nand_get_sdr_timings(conf);
> +	if (IS_ERR(timings))
> +		return -ENOTSUPP;
> +
> +	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
> +		return 0;

Hm, before saying you supporting the requested timing, you should make
sure they are actually supported. I'd recommend splitting this in 2
steps:

1/ calc timings
2/ store the timings in the chip priv struct so that they can be
applied next time ->select_chip() is called.

> +
> +	meson_nfc_calc_set_timing(nfc, timings);

You should not set the timing from ->setup_data_interface(), just
calculate them, make sure they are supported and store the state in the
private chip struct. Applying those timings should be done in
->select_chip(), so that you can support 2 chips with different timings.

> +	return 0;
> +}
