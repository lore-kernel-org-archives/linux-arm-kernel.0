From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 17 Jun 2016 18:24:03 +0530
Subject: [v2 PATCH 2/4] phy: Add USB Type-C PHY driver for rk3399
In-Reply-To: <1465810789-22303-3-git-send-email-zyw@rock-chips.com>
References: <1465810789-22303-1-git-send-email-zyw@rock-chips.com>
 <1465810789-22303-3-git-send-email-zyw@rock-chips.com>
Message-ID: <5763F2EB.7040100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 13 June 2016 03:09 PM, Chris Zhong wrote:
> Add a PHY provider driver for the rk3399 SoC Type-c PHY. The USB
> Type-C PHY is designed to support the USB3 and DP applications. The
> PHY basically has two main components: USB3 and DisplyPort. USB3
> operates in SuperSpeed mode and the DP can operate at RBR, HBR and
> HBR2 data rates.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - select RESET_CONTROLLER
> - alphabetic order
> - modify some spelling mistakes
> - make mode cleaner
> - use bool for enable/disable
> - check all of the return value
> - return a better err number
> - use more readx_poll_timeout()
> - clk_disable_unprepare(tcphy->clk_ref);
> - remove unuse functions, rockchip_typec_phy_power_on/off
> - remove unnecessary typecast from void *
> - use dts node to distinguish between phys.
> 
> Changes in v1:
> - update the licence note
> - init core clock to 50MHz
> - use extcon API
> - remove unused global
> - add some comments for magic num
> - change usleep_range(1000, 2000) tousleep_range(1000, 1050)
> - remove __func__ from dev_err
> - return err number when get clk failed
> - remove ADDR_ADJ define
> - use devm_clk_get(&pdev->dev, "tcpdcore")
> 
>  drivers/phy/Kconfig                    |   8 +
>  drivers/phy/Makefile                   |   1 +
>  drivers/phy/phy-rockchip-typec.c       | 952 +++++++++++++++++++++++++++++++++
>  include/linux/phy/phy-rockchip-typec.h |  20 +
>  4 files changed, 981 insertions(+)
>  create mode 100644 drivers/phy/phy-rockchip-typec.c
>  create mode 100644 include/linux/phy/phy-rockchip-typec.h
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 26566db..ec87b3a 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -351,6 +351,14 @@ config PHY_ROCKCHIP_DP
>  	help
>  	  Enable this to support the Rockchip Display Port PHY.
>  
> +config PHY_ROCKCHIP_TYPEC
> +	tristate "Rockchip TYPEC PHY Driver"
> +	depends on ARCH_ROCKCHIP && OF
> +	select GENERIC_PHY
> +	select RESET_CONTROLLER
> +	help
> +	  Enable this to support the Rockchip USB TYPEC PHY.
> +
>  config PHY_ST_SPEAR1310_MIPHY
>  	tristate "ST SPEAR1310-MIPHY driver"
>  	select GENERIC_PHY
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 24596a9..91fa413 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)	+= phy-qcom-apq8064-sata.o
>  obj-$(CONFIG_PHY_ROCKCHIP_USB) += phy-rockchip-usb.o
>  obj-$(CONFIG_PHY_ROCKCHIP_EMMC) += phy-rockchip-emmc.o
>  obj-$(CONFIG_PHY_ROCKCHIP_DP)		+= phy-rockchip-dp.o
> +obj-$(CONFIG_PHY_ROCKCHIP_TYPEC) += phy-rockchip-typec.o
>  obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
>  obj-$(CONFIG_PHY_ST_SPEAR1310_MIPHY)	+= phy-spear1310-miphy.o
>  obj-$(CONFIG_PHY_ST_SPEAR1340_MIPHY)	+= phy-spear1340-miphy.o
> diff --git a/drivers/phy/phy-rockchip-typec.c b/drivers/phy/phy-rockchip-typec.c
> new file mode 100644
> index 0000000..230e074
> --- /dev/null
> +++ b/drivers/phy/phy-rockchip-typec.c

<snip>

> +static const struct phy_ops rockchip_tcphy_ops = {
> +	.owner          = THIS_MODULE,

no ops?
> +};
> +
> +static int tcphy_pd_event(struct notifier_block *nb,
> +			  unsigned long event, void *priv)
> +{
> +	struct rockchip_typec_phy *tcphy;
> +	struct extcon_dev *edev = priv;
> +	int value = edev->state;
> +	int mode;
> +	u8 is_plugged, dfp;
> +
> +	tcphy = container_of(nb, struct rockchip_typec_phy, event_nb);
> +
> +	is_plugged = GET_PLUGGED(value);
> +	tcphy->flip = GET_FLIP(value);
> +	dfp = GET_DFP(value);
> +	tcphy->map = GET_PIN_MAP(value);
> +
> +	if (is_plugged) {
> +		if (!dfp)
> +			mode = MODE_UFP_USB;
> +		else if (tcphy->map & (PIN_MAP_B | PIN_MAP_D | PIN_MAP_F))
> +			mode = MODE_DFP_USB | MODE_DFP_DP;
> +		else if (tcphy->map & (PIN_MAP_A | PIN_MAP_C | PIN_MAP_E))
> +			mode = MODE_DFP_DP;
> +		else
> +			mode = MODE_DFP_USB;
> +	} else {
> +		mode = MODE_DISCONNECT;
> +	}
> +
> +	if (tcphy->mode != mode) {
> +		tcphy->mode = mode;
> +		schedule_delayed_work_on(0, &tcphy->event_wq, 0);
> +	}
> +
> +	return 0;
> +}
> +
> +static void tcphy_event_wq(struct work_struct *work)
> +{
> +	struct rockchip_typec_phy *tcphy;
> +	int ret;
> +
> +	tcphy = container_of(work, struct rockchip_typec_phy, event_wq.work);
> +
> +	if (tcphy->mode == MODE_DISCONNECT) {
> +		tcphy_phy_deinit(tcphy);
> +		/* remove hpd sign for DP */
> +		if (tcphy->hpd_status) {
> +			regmap_write(tcphy->grf_regs, GRF_SOC_CON26,
> +				     DPTX_HPD_SEL_MASK | DPTX_HPD_DEL);
> +			tcphy->hpd_status = 0;
> +		}
> +	} else {
> +		ret = tcphy_phy_init(tcphy);
> +		if (ret)
> +			return;
> +
> +		if (tcphy->mode & (MODE_UFP_USB | MODE_DFP_USB))
> +			tcphy_usb3_init(tcphy);
> +
> +		if (tcphy->mode & MODE_DFP_DP) {
> +			ret = tcphy_dp_init(tcphy);
> +
> +			/* set hpd sign for DP, if DP phy is ready */
> +			if (!ret) {
> +				regmap_write(tcphy->grf_regs, GRF_SOC_CON26,
> +					     DPTX_HPD_SEL_MASK | DPTX_HPD_SEL);
> +				tcphy->hpd_status = 1;
> +			}
> +		}
> +	}
> +}
> +
> +static int tcphy_get_param(struct device *dev,
> +			   struct usb3phy_reg *reg,
> +			   const char *name)
> +{
> +	int ret, buffer[3];
> +
> +	ret = of_property_read_u32_array(dev->of_node, name, buffer, 3);
> +	if (ret) {
> +		dev_err(dev, "Can not parse %s\n", name);
> +		return ret;
> +	}
> +
> +	reg->offset = buffer[0];
> +	reg->enable_bit = buffer[1];
> +	reg->write_enable = buffer[2];
> +	return 0;
> +}
> +
> +static int tcphy_parse_dt(struct rockchip_typec_phy *tcphy,
> +			  struct device *dev)
> +{
> +	struct rockchip_usb3phy_port_cfg *cfg = &tcphy->port_cfgs;
> +	int ret;
> +
> +	ret = tcphy_get_param(dev, &cfg->typec_conn_dir,
> +			      "rockchip,typec_conn_dir");
> +	if (ret)
> +		return ret;
> +
> +	ret = tcphy_get_param(dev, &cfg->usb3tousb2_en,
> +			      "rockchip,usb3tousb2_en");
> +	if (ret)
> +		return ret;
> +
> +	ret = tcphy_get_param(dev, &cfg->external_psm,
> +			      "rockchip,external_psm");
> +	if (ret)
> +		return ret;
> +
> +	ret = tcphy_get_param(dev, &cfg->pipe_status,
> +			      "rockchip,pipe_status");
> +	if (ret)
> +		return ret;
> +
> +	ret = tcphy_get_param(dev, &cfg->uphy_dp_sel,
> +			      "rockchip,uphy_dp_sel");
> +	if (ret)
> +		return ret;
> +
> +	tcphy->grf_regs = syscon_regmap_lookup_by_phandle(dev->of_node,
> +							  "rockchip,grf");
> +	if (IS_ERR(tcphy->grf_regs)) {
> +		dev_err(dev, "could not find grf dt node\n");
> +		return PTR_ERR(tcphy->grf_regs);
> +	}
> +
> +	tcphy->clk_core = devm_clk_get(dev, "tcpdcore");
> +	if (IS_ERR(tcphy->clk_core)) {
> +		dev_err(dev, "could not get uphy core clock\n");
> +		return PTR_ERR(tcphy->clk_core);
> +	}
> +
> +	tcphy->clk_ref = devm_clk_get(dev, "tcpdphy_ref");
> +	if (IS_ERR(tcphy->clk_ref)) {
> +		dev_err(dev, "could not get uphy ref clock\n");
> +		return PTR_ERR(tcphy->clk_ref);
> +	}
> +
> +	tcphy->phy_rst = devm_reset_control_get(dev, "tcphy");
> +	if (IS_ERR(tcphy->phy_rst)) {
> +		dev_err(dev, "no phy_rst reset control found\n");
> +		return PTR_ERR(tcphy->phy_rst);
> +	}
> +
> +	tcphy->pipe_rst = devm_reset_control_get(dev, "tcphy_pipe");
> +	if (IS_ERR(tcphy->pipe_rst)) {
> +		dev_err(dev, "no pipe_rst reset control found\n");
> +		return PTR_ERR(tcphy->pipe_rst);
> +	}
> +
> +	tcphy->uphy_rst = devm_reset_control_get(dev, "uphy_tcphy");
> +	if (IS_ERR(tcphy->uphy_rst)) {
> +		dev_err(dev, "no uphy_rst reset control found\n");
> +		return PTR_ERR(tcphy->uphy_rst);
> +	}
> +
> +	return 0;
> +}
> +
> +static int rockchip_typec_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rockchip_typec_phy *tcphy;
> +	struct resource *res;
> +	struct phy_provider *phy_provider;
> +	int ret;
> +
> +	tcphy = devm_kzalloc(dev, sizeof(*tcphy), GFP_KERNEL);
> +	if (!tcphy)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	tcphy->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(tcphy->base)) {
> +		dev_err(dev, "failed to remap phy regs\n");
> +		return PTR_ERR(tcphy->base);
> +	}
> +
> +	tcphy_parse_dt(tcphy, dev);
> +
> +	tcphy->dev = dev;
> +	platform_set_drvdata(pdev, tcphy);
> +
> +	tcphy->mode = MODE_DISCONNECT;
> +
> +	tcphy->phy = devm_phy_create(dev, NULL, &rockchip_tcphy_ops);


your phy_ops doesn't have any ops populated. Is there a reason to use the phy
framework?

Thanks
Kishon
