From: balbi@kernel.org (Felipe Balbi)
Date: Tue, 24 Oct 2017 11:25:04 +0300
Subject: [RFC 2/3] USB: dwc3: Modify dwc3 code for support usb of Hikey960
In-Reply-To: <20171024060610.10712-3-chenyu56@huawei.com>
References: <20171024060610.10712-1-chenyu56@huawei.com>
 <20171024060610.10712-3-chenyu56@huawei.com>
Message-ID: <87a80hgdgf.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Yu Chen <chenyu56@huawei.com> writes:
> The usb controller of Kirin960 is DesignWare Cores SuperSpeed USB 3.0 Controller.
> The patch modifies dwc3 for support Kirin960 and adds codes for a USB Hub on board Hikey960.
>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> Signed-off-by: Ning Fan <fanning4@hisilicon.com>
> Signed-off-by: Di Yang <yangdi10@hisilicon.com>
> Signed-off-by: Rui Li <lirui39@hisilicon.com>

you have got to be kidding me if you think I'm gonna take this patch.

> +config USB_DWC3_OTG

we already have this using config USB_DWC3_DUAL_ROLE

> diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
> index f15fabbd1e59..c2c32a5effc7 100644
> --- a/drivers/usb/dwc3/Makefile
> +++ b/drivers/usb/dwc3/Makefile
> @@ -1,6 +1,7 @@
>  # define_trace.h needs to know how to find our header
>  CFLAGS_trace.o				:= -I$(src)
>  
> +ccflags-$(CONFIG_USB_DWC3_OTG)		+= -DDWC3_OTG_FORCE_MODE

NOPE!

> +dwc3-$(CONFIG_USB_DWC3_OTG)		+= dwc3-otg.o

NOPE!

> +obj-$(CONFIG_HISI_HIKEY_GPIO)		+= hisi_hikey_gpio.o

hell no. You should write a real gpio driver.

> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 03474d3575ab..d0105a26867d 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -44,7 +44,7 @@
>  #include "core.h"
>  #include "gadget.h"
>  #include "io.h"
> -
> +#include "dwc3-otg.h"

nak

>  #include "debug.h"
>  
>  #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
> @@ -87,6 +87,8 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
>  			mode = USB_DR_MODE_HOST;
>  		else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
>  			mode = USB_DR_MODE_PERIPHERAL;
> +		else if (IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE))
> +			mode = USB_DR_MODE_OTG;
>  	}

why? Also, if this is really needed, it seems like it should be done as
a separate patch.

>  
>  	if (mode != dwc->dr_mode) {
> @@ -103,7 +105,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
>  static void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
>  static int dwc3_event_buffers_setup(struct dwc3 *dwc);
>  
> -static void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
> +void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)

no way you can expose this.

> @@ -113,6 +115,7 @@ static void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
>  	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>  }
>  
> +#ifndef CONFIG_USB_DWC3_HISI

no ifdefs

>  static void __dwc3_set_mode(struct work_struct *work)
>  {
>  	struct dwc3 *dwc = work_to_dwc(work);
> @@ -177,6 +180,7 @@ static void __dwc3_set_mode(struct work_struct *work)
>  		break;
>  	}
>  }
> +#endif
>  
>  void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
>  {
> @@ -362,6 +366,12 @@ static int dwc3_event_buffers_setup(struct dwc3 *dwc)
>  
>  	evt = dwc->ev_buf;
>  	evt->lpos = 0;
> +	#ifdef CONFIG_USB_DWC3_HISI
> +	evt->count = 0;
> +	evt->flags = 0;
> +	memset(evt->buf, 0, evt->length);
> +	#endif

nope. Totally unnecessary. evt was allocated with kzalloc

> @@ -730,7 +740,13 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
>  	 */
>  	if (dwc->revision < DWC3_REVISION_190A)
>  		reg |= DWC3_GCTL_U2RSTECN;
> -
> +	#ifdef DWC3_OTG_FORCE_MODE

nope

> +	/*
> +	 * if ID status is detected by third module, default device mode.
> +	 */
> +	reg &= ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
> +	reg |= DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_DEVICE);
> +	#endif
>  	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>  }
>  
> @@ -957,6 +973,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  		}
>  		break;
>  	case USB_DR_MODE_OTG:
> +		#ifndef CONFIG_USB_DWC3_HISI

nope

>  		INIT_WORK(&dwc->drd_work, __dwc3_set_mode);
>  		ret = dwc3_drd_init(dwc);
>  		if (ret) {
> @@ -964,6 +981,30 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  				dev_err(dev, "failed to initialize dual-role\n");
>  			return ret;
>  		}
> +		#else

seriously, your platform is really not that important. You DON'T need
special code for you platform. Use the generic code we have. If it works
for Intel, TI, Xilinx, Altera, ST, Qcom and so many others, it works for
you too.

> +		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG);
> +
> +		ret = dwc3_otg_init(dwc);
> +		if (ret) {
> +			dev_err(dev, "failed to initialize otg\n");
> +			return ret;
> +		}
> +
> +		ret = dwc3_host_init(dwc);
> +		if (ret) {
> +			dev_err(dev, "failed to initialize host\n");
> +			dwc3_otg_exit(dwc);
> +			return ret;
> +		}
> +
> +		ret = dwc3_gadget_init(dwc);
> +		if (ret) {
> +			dev_err(dev, "failed to initialize gadget\n");
> +			dwc3_host_exit(dwc);
> +			dwc3_otg_exit(dwc);
> +			return ret;
> +		}
> +		#endif
>  		break;
>  	default:
>  		dev_err(dev, "Unsupported mode of operation %d\n", dwc->dr_mode);
> @@ -984,6 +1025,7 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
>  		break;
>  	case USB_DR_MODE_OTG:
>  		dwc3_drd_exit(dwc);
> +		dwc3_otg_exit(dwc);

nope

>  		break;
>  	default:
>  		/* do nothing */
> @@ -1341,8 +1383,10 @@ static int dwc3_runtime_checks(struct dwc3 *dwc)
>  	switch (dwc->dr_mode) {
>  	case USB_DR_MODE_PERIPHERAL:
>  	case USB_DR_MODE_OTG:
> +#ifndef CONFIG_USB_DWC3_HISI
>  		if (dwc->connected)
>  			return -EBUSY;
> +#endif

nope

> @@ -1367,6 +1411,7 @@ static int dwc3_runtime_suspend(struct device *dev)
>  
>  	device_init_wakeup(dev, true);
>  
> +	pm_runtime_put(dev);

nope

>  	return 0;
>  }
>  
> @@ -1393,7 +1438,7 @@ static int dwc3_runtime_resume(struct device *dev)
>  	}
>  
>  	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_put(dev);
> +	pm_runtime_get(dev);

nope

> @@ -1461,6 +1506,31 @@ static const struct dev_pm_ops dwc3_dev_pm_ops = {
>  			dwc3_runtime_idle)
>  };
>  
> +int dwc3_resume_device(struct dwc3 *dwc)
> +{
> +	int status;
> +
> +	pr_info("[%s] +\n", __func__);
> +	status = dwc3_runtime_resume(dwc->dev);
> +	if (status < 0)
> +		pr_err("dwc3_runtime_resume err, status:%d\n", status);
> +
> +	pr_info("[%s] -\n", __func__);
> +	return status;
> +}
> +
> +void dwc3_suspend_device(struct dwc3 *dwc)
> +{
> +	int status;
> +
> +	pr_info("[%s] +\n", __func__);
> +	status = dwc3_runtime_suspend(dwc->dev);
> +	if (status < 0)
> +		pr_err("dwc3_runtime_suspend err, status:%d\n", status);
> +
> +	pr_info("[%s] -\n", __func__);
> +}
> +

nope. Specially not with pr_*(). That's a sign that you didn't even test
this properly.

>  #ifdef CONFIG_OF
>  static const struct of_device_id of_dwc3_match[] = {
>  	{
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index ea910acb4bb0..3b6dd99daf9a 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -750,6 +750,7 @@ struct dwc3_request {
>  	unsigned		mapped:1;
>  	unsigned		started:1;
>  	unsigned		zero:1;
> +	unsigned		send_zlp:1;

nope. struct usb_request already has this.

> @@ -980,10 +981,17 @@ struct dwc3 {
>  	u8			lpm_nyet_threshold;
>  	u8			hird_threshold;
>  
> +	struct dwc3_otg *dwc_otg;

no

>  	const char		*hsphy_interface;
>  
>  	unsigned		connected:1;
>  	unsigned		delayed_status:1;
> +
> +	/* the delayed status may come before notready interrupt,
> +	 * in this case, don't wait for delayed status
> +	 */
> +	unsigned		status_queued:1;

we ALREADY cope with this situation. Why do you think mass storage
gadget works?

> @@ -1175,7 +1183,7 @@ struct dwc3_gadget_ep_cmd_params {
>  /* prototypes */
>  void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
>  u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
> -
> +void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode);

nope

>  /* check whether we are on the DWC_usb3 core */
>  static inline bool dwc3_is_usb3(struct dwc3 *dwc)
>  {
> @@ -1209,6 +1217,8 @@ int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state);
>  int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
>  		struct dwc3_gadget_ep_cmd_params *params);
>  int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param);
> +int dwc3_conndone_notifier_register(struct notifier_block *nb);
> +int dwc3_conndone_notifier_unregister(struct notifier_block *nb);

no way.

> @@ -1228,6 +1238,10 @@ static inline int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
>  static inline int dwc3_send_gadget_generic_command(struct dwc3 *dwc,
>  		int cmd, u32 param)
>  { return 0; }
> +static inline int dwc3_conndone_notifier_register(struct notifier_block *nb)
> +{ return 0; }
> +static inline int dwc3_conndone_notifier_unregister(struct notifier_block *nb)
> +{ return 0; }

nope

> @@ -1261,6 +1275,9 @@ static inline void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
>  }
>  #endif /* !IS_ENABLED(CONFIG_USB_DWC3_HOST) */
>  
> +int dwc3_resume_device(struct dwc3 *dwc);
> +void dwc3_suspend_device(struct dwc3 *dwc);

and no. I think you see a pattern here.

> diff --git a/drivers/usb/dwc3/dwc3-hi3660.c b/drivers/usb/dwc3/dwc3-hi3660.c
> new file mode 100644
> index 000000000000..d8cdc0f7280b
> --- /dev/null
> +++ b/drivers/usb/dwc3/dwc3-hi3660.c
> @@ -0,0 +1,310 @@
> +/*
> + * dwc3-hi3660.c
> + *
> + * Copyright: (C) 2008-2018 hisilicon.
> + * Contact: wangbinghui<wangbinghui@hisilicon.com>
> + *
> + * USB vbus for Hisilicon device
> + *
> + * This software is available to you under a choice of one of two
> + * licenses. You may choose this file to be licensed under the terms
> + * of the GNU General Public License (GPL) Version 2 or the 2-clause
> + * BSD license listed below:
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in the
> + *    documentation and/or other materials provided with the distribution.
> + *
> + */
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +
> +#include "dwc3-hisi.h"
> +
> +/*lint -e750 -esym(750,*)*/
> +/* clk module will round to 228M */
> +#define USB3OTG_ACLK_FREQ		229000000
> +#ifndef BIT
> +#define BIT(x)	(1 << (x))
> +#endif
> +#define SCTRL_SCDEEPSLEEPED				0x08
> +#define USB_REFCLK_ISO_EN               BIT(25)
> +#define PCTRL_PERI_CTRL3                0x10
> +#define USB_TCXO_EN						BIT(1)
> +#define PERI_CTRL3_MSK_START            (16)
> +#define SC_CLK_USB3PHY_3MUX1_SEL        BIT(25)
> +
> +#define SC_SEL_ABB_BACKUP               BIT(8)
> +#define CLKDIV_MASK_START               (16)
> +
> +#define PERI_CRG_CLKDIV21               0xFC
> +
> +#define GT_CLK_ABB_BACKUP               BIT(22)
> +#define PERI_CRG_CLK_DIS5               0x54
> +
> +#define PMC_PPLL3CTRL0                  0x048
> +#define PPLL3_FBDIV_START               (8)
> +#define PPLL3_EN                        BIT(0)
> +#define PPLL3_BP                        BIT(1)
> +#define PPLL3_LOCK                      BIT(26)
> +
> +#define PMC_PPLL3CTRL1                  0x04C
> +#define PPLL3_INT_MOD                   BIT(24)
> +#define GT_CLK_PPLL3                    BIT(26)
> +
> +#define PERI_CRG_CLK_EN5                0x50
> +
> +#define SC_USB3PHY_ABB_GT_EN            BIT(15)
> +#define REF_SSP_EN                      BIT(16)
> +/*lint -e750 +esym(750,*)*/
> +
> +static int usb3_regu_init(struct hisi_dwc3_device *hisi_dwc3)
> +{
> +	if (hisi_dwc3->is_regu_on != 0) {
> +		usb_dbg("ldo already opened!\n");
> +		return 0;
> +	}
> +
> +	hisi_dwc3->is_regu_on = 1;
> +
> +	return 0;
> +}
> +
> +static int usb3_regu_shutdown(struct hisi_dwc3_device *hisi_dwc3)
> +{
> +	if (hisi_dwc3->is_regu_on == 0) {
> +		usb_dbg("regu already closed!\n");
> +		return 0;
> +	}
> +
> +	hisi_dwc3->is_regu_on = 0;
> +
> +	return 0;
> +}
> +
> +static int usb3_clk_init(struct hisi_dwc3_device *hisi_dwc3)
> +{
> +	int ret;
> +	u32 temp;
> +	void __iomem *pctrl_base = hisi_dwc3->pctrl_reg_base;
> +	void __iomem *pericfg_base = hisi_dwc3->pericfg_reg_base;
> +
> +	/* set usb aclk 240MHz to improve performance */
> +	ret = clk_set_rate(hisi_dwc3->gt_aclk_usb3otg, USB3OTG_ACLK_FREQ);
> +	if (ret)
> +		usb_err("usb aclk set rate failed\n");
> +
> +	ret = clk_prepare_enable(hisi_dwc3->gt_aclk_usb3otg);
> +	if (ret) {
> +		usb_err("clk_prepare_enable gt_aclk_usb3otg failed\n");
> +		return ret;
> +	}
> +
> +	/* usb refclk iso enable */
> +	writel(USB_REFCLK_ISO_EN, pericfg_base + PERI_CRG_ISODIS);
> +
> +	/* enable usb_tcxo_en */
> +	writel(USB_TCXO_EN | (USB_TCXO_EN << PERI_CTRL3_MSK_START),
> +	       pctrl_base + PCTRL_PERI_CTRL3);
> +
> +	/* select usbphy clk from abb */
> +	temp = readl(pctrl_base + PCTRL_PERI_CTRL24);
> +	temp &= ~SC_CLK_USB3PHY_3MUX1_SEL;
> +	writel(temp, pctrl_base + PCTRL_PERI_CTRL24);
> +
> +	/* open clk gate */
> +	writel(GT_CLK_USB3OTG_REF | GT_ACLK_USB3OTG,
> +	       pericfg_base + PERI_CRG_CLK_EN4);
> +
> +	ret = clk_prepare_enable(hisi_dwc3->clk);
> +	if (ret) {
> +		usb_err("clk_prepare_enable clk failed\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void usb3_clk_shutdown(struct hisi_dwc3_device *hisi_dwc3)
> +{
> +	u32 temp;
> +	void __iomem *pctrl_base = hisi_dwc3->pctrl_reg_base;
> +	void __iomem *pericfg_base = hisi_dwc3->pericfg_reg_base;
> +
> +	writel(GT_CLK_USB3OTG_REF | GT_ACLK_USB3OTG,
> +	       pericfg_base + PERI_CRG_CLK_DIS4);
> +
> +	temp = readl(pctrl_base + PCTRL_PERI_CTRL24);
> +	temp &= ~SC_CLK_USB3PHY_3MUX1_SEL;
> +	writel(temp, pctrl_base + PCTRL_PERI_CTRL24);
> +
> +	/* disable usb_tcxo_en */
> +	writel(0 | (USB_TCXO_EN << PERI_CTRL3_MSK_START),
> +	       pctrl_base + PCTRL_PERI_CTRL3);

looks like this should be part of your clock driver.

> +	clk_disable_unprepare(hisi_dwc3->clk);
> +	clk_disable_unprepare(hisi_dwc3->gt_aclk_usb3otg);
> +
> +	msleep(20);
> +}
> +
> +static void dwc3_release(struct hisi_dwc3_device *hisi_dwc3)
> +{
> +	u32 temp;
> +	void __iomem *pericfg_base = hisi_dwc3->pericfg_reg_base;
> +	void __iomem *otg_bc_base = hisi_dwc3->otg_bc_reg_base;
> +
> +	/* dis-reset the module */
> +	writel(IP_RST_USB3OTG_MUX | IP_RST_USB3OTG_AHBIF | IP_RST_USB3OTG_32K,
> +	       pericfg_base + PERI_CRG_RSTDIS4);
> +
> +	/* reset phy */
> +	writel(IP_RST_USB3OTGPHY_POR | IP_RST_USB3OTG,
> +	       pericfg_base + PERI_CRG_RSTEN4);
> +
> +	/* enable phy ref clk */
> +	temp = readl(otg_bc_base + USBOTG3_CTRL0);
> +	temp |= SC_USB3PHY_ABB_GT_EN;
> +	writel(temp, otg_bc_base + USBOTG3_CTRL0);
> +
> +	temp = readl(otg_bc_base + USBOTG3_CTRL7);
> +	temp |= REF_SSP_EN;
> +	writel(temp, otg_bc_base + USBOTG3_CTRL7);
> +
> +	/* exit from IDDQ mode */
> +	temp = readl(otg_bc_base + USBOTG3_CTRL2);
> +	temp &= ~(USBOTG3CTRL2_POWERDOWN_HSP | USBOTG3CTRL2_POWERDOWN_SSP);
> +	writel(temp, otg_bc_base + USBOTG3_CTRL2);
> +
> +	usleep_range(100, 120);
> +
> +	/* dis-reset phy */
> +	writel(IP_RST_USB3OTGPHY_POR, pericfg_base + PERI_CRG_RSTDIS4);
> +
> +	/* dis-reset controller */
> +	writel(IP_RST_USB3OTG, pericfg_base + PERI_CRG_RSTDIS4);

and for this you need a PHY driver under drivers/phy/

> +	msleep(20);
> +
> +	/* fake vbus valid signal */
> +	temp = readl(otg_bc_base + USBOTG3_CTRL3);
> +	temp |= (USBOTG3_CTRL3_VBUSVLDEXT | USBOTG3_CTRL3_VBUSVLDEXTSEL);
> +	writel(temp, otg_bc_base + USBOTG3_CTRL3);
> +
> +	usleep_range(100, 120);
> +}
> +
> +static void dwc3_reset(struct hisi_dwc3_device *hisi_dwc3)
> +{
> +	void __iomem *pericfg_base = hisi_dwc3->pericfg_reg_base;
> +
> +	writel(IP_RST_USB3OTG, pericfg_base + PERI_CRG_RSTEN4);
> +	writel(IP_RST_USB3OTGPHY_POR, pericfg_base + PERI_CRG_RSTEN4);
> +	writel(IP_RST_USB3OTG_MUX | IP_RST_USB3OTG_AHBIF | IP_RST_USB3OTG_32K,
> +	       pericfg_base + PERI_CRG_RSTEN4);

phy_reset()

> +}
> +
> +static int hi3660_usb3phy_init(struct hisi_dwc3_device *hisi_dwc3)
> +{
> +	int ret;
> +
> +	usb_dbg("+\n");
> +
> +	ret = usb3_regu_init(hisi_dwc3);

use regulator API

> +	if (ret)
> +		return ret;
> +
> +	ret = usb3_clk_init(hisi_dwc3);

common clk framework

> +	if (ret)
> +		return ret;
> +
> +	dwc3_release(hisi_dwc3);
> +	config_femtophy_param(hisi_dwc3);

phy_init()

> +	set_hisi_dwc3_power_flag(1);
> +
> +	usb_dbg("-\n");

pointless debugging message.

> +static int hi3660_usb3phy_shutdown(struct hisi_dwc3_device *hisi_dwc3)
> +{
> +	int ret;
> +
> +	usb_dbg("+\n");
> +
> +	set_hisi_dwc3_power_flag(0);
> +
> +	dwc3_reset(hisi_dwc3);
> +	usb3_clk_shutdown(hisi_dwc3);
> +
> +	ret = usb3_regu_shutdown(hisi_dwc3);
> +	if (ret)
> +		return ret;
> +
> +	usb_dbg("-\n");
> +
> +	return 0;
> +}
> +
> +static struct usb3_phy_ops hi3660_phy_ops = {

you want your own special PHY API? Are you nuts?? No way dude. Use drivers/phy/

> +	.init		= hi3660_usb3phy_init,
> +	.shutdown	= hi3660_usb3phy_shutdown,
> +};
> +
> +static int dwc3_hi3660_probe(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +
> +	ret = hisi_dwc3_probe(pdev, &hi3660_phy_ops);
> +	if (ret)
> +		usb_err("probe failed, ret=[%d]\n", ret);
> +
> +	return ret;
> +}
> +
> +static int dwc3_hi3660_remove(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +
> +	ret = hisi_dwc3_remove(pdev);
> +	if (ret)
> +		usb_err("hisi_dwc3_remove failed, ret=[%d]\n", ret);
> +
> +	return ret;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id dwc3_hi3660_match[] = {
> +	{ .compatible = "hisilicon,hi3660-dwc3" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, dwc3_hi3660_match);
> +#else
> +#define dwc3_hi3660_match NULL
> +#endif
> +
> +static struct platform_driver dwc3_hi3660_driver = {
> +	.probe		= dwc3_hi3660_probe,
> +	.remove		= dwc3_hi3660_remove,
> +	.driver		= {
> +		.name	= "usb3-hi3660",
> +		.of_match_table = of_match_ptr(dwc3_hi3660_match),
> +		.pm	= HISI_DWC3_PM_OPS,
> +	},
> +};
> +
> +module_platform_driver(dwc3_hi3660_driver);

seriously. All you need is for you compatible flag to be added to
dwc3-of-simple.c. Everything else should be done elsewhere (regulator
API, common clock framework, gpiolib, etc)

> +/*lint -save -e750 */
> +DEVICE_ATTR(plugusb, (0644), plugusb_show, plugusb_store);
> +/*lint -restore */

what?

> +static const char * const charger_type_array[] = {
> +	[CHARGER_TYPE_SDP]     = "sdp",       /* Standard Downstreame Port */
> +	[CHARGER_TYPE_CDP]     = "cdp",       /* Charging Downstreame Port */
> +	[CHARGER_TYPE_DCP]     = "dcp",       /* Dedicate Charging Port */
> +	[CHARGER_TYPE_UNKNOWN] = "unknown",   /* non-standard */
> +	[CHARGER_TYPE_NONE]    = "none",      /* not connected */
> +	[PLEASE_PROVIDE_POWER] = "provide"   /* host mode, provide power */
> +};

I think Linaro, recently, added support for chargers to mainline. You
should use what they did.

I'm gonna stop here. There's no way I'm going through this much code in
a single patch. Specially since 90% of it is either completely
unnecessary or should be done using already-existing generic APIs.

Sorry, no cookie today.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171024/2c30c195/attachment-0001.sig>
