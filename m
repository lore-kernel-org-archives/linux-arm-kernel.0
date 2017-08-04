From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri, 4 Aug 2017 05:10:50 +0000
Subject: [PATCH v2 9/9] EDAC: Add driver for the Marvell Armada XP SDRAM
 and L2 cache ECC
References: <20170802123922.11498-1-jlu@pengutronix.de>
 <20170802123922.11498-10-jlu@pengutronix.de>
Message-ID: <aabb0e61976f4fa1801051d8c84deea7@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One comment

On 03/08/17 00:39, Jan Luebbe wrote:
> +struct armada_xp_mc_edac_drvdata {
> +	void __iomem *base;
> +
> +	unsigned int width; /* width in bytes */
> +	bool cs_addr_sel[SDRAM_NUM_CS]; /* bank interleaving */
> +
> +	char msg[128];
> +};
> +

...

> +static int armada_xp_mc_edac_read_config(struct mem_ctl_info *mci)
> +{
> +	struct armada_xp_mc_edac_drvdata *drvdata = mci->pvt_info;
> +	struct dimm_info *dimm;
> +	unsigned int i, cs_struct, cs_size;
> +	uint32_t config, addr_ctrl, rank_ctrl;
> +
> +	config = readl(drvdata->base + SDRAM_CONFIG_REG);
> +	if (!(config & SDRAM_CONFIG_ECC_MASK))
> +		dev_warn(mci->pdev, "SDRAM ECC is not enabled");
> +
> +	if (mci->tot_dimms != SDRAM_NUM_CS) {
> +		dev_err(mci->pdev, "Invaild number of DIMMs");
> +		return -EINVAL;
> +	}
> +
> +	if (config & SDRAM_CONFIG_BUS_WIDTH_MASK)
> +		drvdata->width = 4; /* 64 bit */
> +	else
> +		drvdata->width = 2; /* 32 bit */
> +

Should this be 8 and 4 instead of 4 and 2? The uses of this value are 
all consistent so there is no error but the numbers don't match the 
comment in struct armada_xp_mc_edac_drvdata.
