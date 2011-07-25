From: B19295@freescale.com (Lin Tony-B19295)
Date: Mon, 25 Jul 2011 07:26:17 +0000
Subject: [PATCH v2 5/6] ARM: mxs: add usb phy operations
In-Reply-To: <20013.6155.531965.918650@ipc1.ka-ro>
References: <1311577284-11506-1-git-send-email-tony.lin@freescale.com>
	<1311577284-11506-6-git-send-email-tony.lin@freescale.com>
	<20013.6155.531965.918650@ipc1.ka-ro>
Message-ID: <97D3A72708D04647A5AC84A04996E5B5162A56@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Lothar Wa?mann
> Sent: Monday, July 25, 2011 3:15 PM
> To: Lin Tony-B19295
> Cc: koen.beel.barco at gmail.com; linux-usb at vger.kernel.org;
> stern at rowland.harvard.edu; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v2 5/6] ARM: mxs: add usb phy operations
> 
> Hi,
> 
> Tony Lin writes:
> > add usb phy register definitions and functions usb host driver will
> > use these callback functions to initialize usb phy and change working
> > mode
> >
> > Signed-off-by: Tony Lin <tony.lin@freescale.com>
> > ---
> >  arch/arm/mach-mxs/Kconfig            |    1 +
> >  arch/arm/mach-mxs/Makefile           |    1 +
> >  arch/arm/mach-mxs/mxs_usb.c          |  286
> ++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-mxs/regs-usbphy-mx28.h |  240
> > ++++++++++++++++++++++++++++
> >  4 files changed, 528 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> > index 4cd0231..1c4264f 100644
> > --- a/arch/arm/mach-mxs/Kconfig
> > +++ b/arch/arm/mach-mxs/Kconfig
> > @@ -49,6 +49,7 @@ config MACH_MX28EVK
> >  	select MXS_HAVE_PLATFORM_MXS_MMC
> >  	select MXS_HAVE_PLATFORM_MXSFB
> >  	select MXS_OCOTP
> > +	select USB_ARCH_HAS_EHCI
> >  	help
> >  	  Include support for MX28EVK platform. This includes specific
> >  	  configurations for the board and its peripherals.
> > diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
> > index 6c38262..726c49f 100644
> > --- a/arch/arm/mach-mxs/Makefile
> > +++ b/arch/arm/mach-mxs/Makefile
> > @@ -12,5 +12,6 @@ obj-$(CONFIG_MACH_MX23EVK) += mach-mx23evk.o
> >  obj-$(CONFIG_MACH_MX28EVK) += mach-mx28evk.o
> >  obj-$(CONFIG_MODULE_TX28) += module-tx28.o
> >  obj-$(CONFIG_MACH_TX28)    += mach-tx28.o
> > +obj-$(CONFIG_USB_EHCI_MXC)   += mxs_usb.o
> >
> >  obj-y += devices/
> > diff --git a/arch/arm/mach-mxs/mxs_usb.c b/arch/arm/mach-mxs/mxs_usb.c
> > new file mode 100644 index 0000000..01753ea
> > --- /dev/null
> > +++ b/arch/arm/mach-mxs/mxs_usb.c
> > @@ -0,0 +1,286 @@
> > +/*
> > + * Copyright (C) 2009-2011 Freescale Semiconductor, Inc. All Rights
> Reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify
> > + * it under the terms of the GNU General Public License as published
> > +by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > +along
> > + * with this program; if not, write to the Free Software Foundation,
> > +Inc.,
> > + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/types.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/io.h>
> > +#include <linux/err.h>
> > +#include <linux/fsl_devices.h>
> > +#include <linux/gpio.h>
> > +#include <asm/mach-types.h>
> > +#include <asm/mach/arch.h>
> > +#include <mach/irqs.h>
> > +#include <mach/mx28.h>
> > +#include "regs-usbphy-mx28.h"
> > +
> > +/* EHCI registers: */
> > +#define UOG_USBCMD		(0x140) /* USB command register */
> > +#define UOG_USBSTS		(0x144) /* USB status register */
> > +#define UOG_PORTSC1		(0x184) /* port status and control */
> > +/* x_PORTSCx */
> > +#define PORTSC_PTS_MASK		(3 << 30) /* parallel xcvr mask */
> > +#define PORTSC_PTS_UTMI		(0 << 30) /* UTMI/UTMI+ */
> > +#define PORTSC_PTW		(1 << 28) /* UTMI width */
> > +/* USBCMD */
> > +#define UCMD_RUN_STOP           (1 << 0) /* controller run/stop */
> > +#define UCMD_RESET		(1 << 1) /* controller reset */
> > +
> > +#define HOSTPHY_CONNECT_STATE	(1 << 3)
> > +#define STS_PCD			(1 << 2) /* port change detect */
> > +
> > +struct mxs_usb_private_date {
> > +	struct clk *usb_clk, *usb_phy_clk;
> > +	int internal_phy_clk_already_on;
> > +	void __iomem *phy_regs;		/* usb phy register base */
> > +	void __iomem *ctrl_regs;	/* usb controller register base */
> > +};
> > +
> > +static inline int fsl_platform_get_usb_connect_status
> > +			(struct mxs_usb_private_date *ppriv) {
> > +	u32 status;
> > +
> > +	status = __raw_readl(ppriv->phy_regs + HW_USBPHY_STATUS);
> > +
> > +	return ((status & HOSTPHY_CONNECT_STATE) == 0); }
> > +
> > +/* enable/disable high-speed disconnect detector of phy ctrl */
> > +static inline void fsl_platform_disconnect_detect
> > +			(struct mxs_usb_private_date *ppriv, int enable) {
> > +	if (enable) {
> > +		__raw_writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
> > +		ppriv->phy_regs + HW_USBPHY_CTRL_SET);
> > +	} else {
> > +		__raw_writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
> > +		ppriv->phy_regs + HW_USBPHY_CTRL_CLR);
> > +	}
> > +}
> > +
> > +static void fsl_plt_usbh_irq_handler(struct mxc_usbh_platform_data
> > +*pdata) {
> > +	u32			status;
> > +	struct mxs_usb_private_date *ppriv = pdata->ppriv;
> > +
> > +	status = __raw_readl(ppriv->ctrl_regs + UOG_USBSTS);
> > +
> > +	if (status & STS_PCD)
> > +		fsl_platform_disconnect_detect(ppriv,
> > +			fsl_platform_get_usb_connect_status(ppriv));
> > +}
> > +
> > +static int usb_phy_enable(struct mxc_usbh_platform_data *pdata) {
> > +	u32 tmp;
> > +	u32 i = 0;
> > +	struct mxs_usb_private_date *ppriv = pdata->ppriv;
> > +	void __iomem *usbcmd, *phy_ctrl, *portsc;
> > +
> > +	/* Reset USB IP */
> > +	/* Set run stop bit */
> > +	/* Send reset command */
> > +	usbcmd = ppriv->ctrl_regs + UOG_USBCMD;
> > +	tmp = __raw_readl(usbcmd); /* usb command */
> > +	tmp &= ~UCMD_RUN_STOP;
> > +	__raw_writel(tmp, usbcmd);
> > +	while (__raw_readl(usbcmd) & UCMD_RUN_STOP) {
> > +		i++;
> > +		if (i == 1000)
> > +			break;
> > +		mdelay(1);
> > +	}
> > +	tmp |= UCMD_RESET;
> > +	__raw_writel(tmp, usbcmd);
> > +	i = 0;
> > +	while (__raw_readl(usbcmd) & UCMD_RESET) {
> > +		i++;
> > +		if (i == 1000)
> > +			break;
> > +		mdelay(1);
> > +	}
> > +	mdelay(10);
> > +
> > +	/* Reset USBPHY module, set soft reset bit */
> > +	phy_ctrl = ppriv->phy_regs + HW_USBPHY_CTRL;
> > +	tmp = __raw_readl(phy_ctrl);
> > +	tmp |= BM_USBPHY_CTRL_SFTRST;
> > +	__raw_writel(tmp, phy_ctrl);
> > +	udelay(10);
> > +
> > +	/* clear CLKGATE and SFTRST bits to be out of reset mode*/
> > +	tmp = __raw_readl(phy_ctrl);
> > +	tmp &= ~(BM_USBPHY_CTRL_CLKGATE | BM_USBPHY_CTRL_SFTRST);
> > +	__raw_writel(tmp, phy_ctrl);
> > +	udelay(10);
> > +
> > +	/* set UTMI xcvr */
> > +	/* Workaround an IC issue for ehci driver:
> > +	 * when turn off root hub port power, EHCI set
> > +	 * PORTSC reserved bits to be 0, but PTW with 0
> > +	 * means 8 bits tranceiver width, here change
> > +	 * it back to be 16 bits and do PHY diable and
> > +	 * then enable.
> > +	 */
> > +	portsc = ppriv->ctrl_regs + UOG_PORTSC1;
> > +	tmp = __raw_readl(portsc);
> > +	tmp &=  ~PORTSC_PTS_MASK;
> > +	tmp |= (PORTSC_PTS_UTMI | PORTSC_PTW);
> > +	__raw_writel(tmp, portsc);
> > +
> > +	/* Power up the PHY */
> > +	__raw_writel(0, ppriv->phy_regs + HW_USBPHY_PWD);
> > +	return 0;
> > +}
> > +
> > +static int fsl_usbh_init(struct platform_device *pdev) {
> > +	struct mxc_usbh_platform_data *pdata = pdev->dev.platform_data;
> > +	struct mxs_usb_private_date *ppriv = pdata->ppriv;
> > +	u32 tmp;
> > +
> > +	usb_phy_enable(pdata);
> > +	/* enable FS/LS device */
> > +	tmp = __raw_readl(ppriv->phy_regs + HW_USBPHY_CTRL);
> > +	tmp |= (BM_USBPHY_CTRL_ENUTMILEVEL2 | BM_USBPHY_CTRL_ENUTMILEVEL3);
> > +	__raw_writel(tmp, ppriv->phy_regs + HW_USBPHY_CTRL);
> > +
> > +	return 0;
> > +}
> > +
> > +static void phy_clock_gate(struct mxs_usb_private_date *ppriv, bool
> > +on) {
> > +	u32 tmp;
> > +
> > +	if (on) {
> > +		ppriv->internal_phy_clk_already_on += 1;
> > +		if (ppriv->internal_phy_clk_already_on == 1) {
> > +			tmp = BM_USBPHY_CTRL_SFTRST | BM_USBPHY_CTRL_CLKGATE;
> > +			__raw_writel(tmp, ppriv->phy_regs + HW_USBPHY_CTRL_CLR);
> > +		}
> > +	} else {
> > +		ppriv->internal_phy_clk_already_on -= 1;
> > +		if (ppriv->internal_phy_clk_already_on == 0) {
> > +			tmp = BM_USBPHY_CTRL_CLKGATE;
> > +			__raw_writel(tmp, ppriv->phy_regs + HW_USBPHY_CTRL_SET);
> > +		}
> > +	}
> > +	if (WARN_ON(ppriv->internal_phy_clk_already_on < 0))
> > +		printk(KERN_ERR "please check phy clock ON/OFF sequence\n"); }
> > +static int fsl_usb_host_init(struct platform_device *pdev) {
> > +	struct mxc_usbh_platform_data *pdata = pdev->dev.platform_data;
> > +	struct mxs_usb_private_date *ppriv = pdata->ppriv;
> > +
> > +	ppriv->phy_regs = ioremap(MX28_USBPHY1_BASE_ADDR, SZ_8K);
> > +	if (ppriv->phy_regs == NULL)
> > +		return -ENOMEM;
> > +
> > +	ppriv->ctrl_regs = ioremap(MX28_USBCTRL1_BASE_ADDR, SZ_8K);
> > +	if (ppriv->ctrl_regs == NULL)
> > +		return -ENOMEM;
> > +
> What about proper cleanup in the error case?
> 
> > +	ppriv->usb_clk = clk_get(&pdev->dev, "usb1");
> > +	if (IS_ERR(ppriv->usb_clk))
> > +		return PTR_ERR(ppriv->usb_clk);
> dto.
> 
> > +	clk_enable(ppriv->usb_clk);
> > +
> > +	ppriv->usb_phy_clk = clk_get(&pdev->dev, "usb1_phy");
> > +	if (IS_ERR(ppriv->usb_phy_clk))
> > +		return PTR_ERR(ppriv->usb_phy_clk);
> dto.
> 
> > +	clk_enable(ppriv->usb_phy_clk);
> > +
> > +	phy_clock_gate(ppriv, true);
> > +	return fsl_usbh_init(pdev);
> > +}
> > +
> > +static int fsl_usb_host_uninit(struct platform_device *pdev) {
> > +	struct mxc_usbh_platform_data *pdata = pdev->dev.platform_data;
> > +	struct mxs_usb_private_date *ppriv = pdata->ppriv;
> > +
> > +	phy_clock_gate(ppriv, false);
> > +	if (ppriv->usb_phy_clk) {
> >
> > +		clk_disable(ppriv->usb_phy_clk);
> > +		clk_put(ppriv->usb_phy_clk);
> > +	}
> > +	if (ppriv->usb_clk) {
> > +		clk_disable(ppriv->usb_clk);
> > +		clk_put(ppriv->usb_clk);
> > +	}
> > +	if (ppriv->phy_regs)
> > +		iounmap(ppriv->phy_regs);
> > +	if (ppriv->ctrl_regs)
> > +		iounmap(ppriv->ctrl_regs);
> > +
> >
> The 'if' clauses are redundant here. fsl_usb_host_uninit() will only be
> called when fsl_usb_host_init() has succeeded and thus all pointers have
> been set up correctly (which makes it necessary to have proper cleanup
> code in fsl_usb_host_init()).
> 
> 
Yes, silly mistake. Will correct it. 

> Lothar Wa?mann
> --
> ___________________________________________________________
> 
> Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
> Gesch?ftsf?hrer: Matthias Kaussen
> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
> 
> www.karo-electronics.de | info at karo-electronics.de
> ___________________________________________________________
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
