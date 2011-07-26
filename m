From: B19295@freescale.com (Lin Tony-B19295)
Date: Tue, 26 Jul 2011 07:12:18 +0000
Subject: [PATCH v2 5/6] ARM: mxs: add usb phy operations
In-Reply-To: <CAHMSPgP7QQHEsN1s9CUhCcAadRvu1W=qTFuizQHUpYfT-EqNjg@mail.gmail.com>
References: <1311577284-11506-1-git-send-email-tony.lin@freescale.com>
	<1311577284-11506-6-git-send-email-tony.lin@freescale.com>
	<CAHMSPgP7QQHEsN1s9CUhCcAadRvu1W=qTFuizQHUpYfT-EqNjg@mail.gmail.com>
Message-ID: <97D3A72708D04647A5AC84A04996E5B51662C0@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi,
> 
> From what I see in the datasheet of mx23/mx28, phy regs for mx23 and
> mx28 are the same.
> Then it might be better to name the file regs-usbphy-mxs.h instead of
> regs-usbphy-mx28.h.
> 
> Koen
> 
Good idea.

> On Mon, Jul 25, 2011 at 9:01 AM, Tony Lin <tony.lin@freescale.com> wrote:
> > add usb phy register definitions and functions usb host driver will
> > use these callback functions to initialize usb phy and change working
> > mode
> >
> > Signed-off-by: Tony Lin <tony.lin@freescale.com>
> > ---
> > ?arch/arm/mach-mxs/Kconfig ? ? ? ? ? ?| ? ?1 +
> > ?arch/arm/mach-mxs/Makefile ? ? ? ? ? | ? ?1 +
> > ?arch/arm/mach-mxs/mxs_usb.c ? ? ? ? ?| ?286
> > ++++++++++++++++++++++++++++++++++
> > ?arch/arm/mach-mxs/regs-usbphy-mx28.h | ?240
> > ++++++++++++++++++++++++++++
> > ?4 files changed, 528 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> > index 4cd0231..1c4264f 100644
> > --- a/arch/arm/mach-mxs/Kconfig
> > +++ b/arch/arm/mach-mxs/Kconfig
> > @@ -49,6 +49,7 @@ config MACH_MX28EVK
> > ? ? ? ?select MXS_HAVE_PLATFORM_MXS_MMC
> > ? ? ? ?select MXS_HAVE_PLATFORM_MXSFB
> > ? ? ? ?select MXS_OCOTP
> > + ? ? ? select USB_ARCH_HAS_EHCI
> > ? ? ? ?help
> > ? ? ? ? ?Include support for MX28EVK platform. This includes specific
> > ? ? ? ? ?configurations for the board and its peripherals.
> > diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
> > index 6c38262..726c49f 100644
> > --- a/arch/arm/mach-mxs/Makefile
> > +++ b/arch/arm/mach-mxs/Makefile
> > @@ -12,5 +12,6 @@ obj-$(CONFIG_MACH_MX23EVK) += mach-mx23evk.o
> > ?obj-$(CONFIG_MACH_MX28EVK) += mach-mx28evk.o
> > ?obj-$(CONFIG_MODULE_TX28) += module-tx28.o
> > ?obj-$(CONFIG_MACH_TX28) ? ?+= mach-tx28.o
> > +obj-$(CONFIG_USB_EHCI_MXC) ? += mxs_usb.o
> >
> > ?obj-y += devices/
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
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
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
> > +#define UOG_USBCMD ? ? ? ? ? ? (0x140) /* USB command register */
> > +#define UOG_USBSTS ? ? ? ? ? ? (0x144) /* USB status register */
> > +#define UOG_PORTSC1 ? ? ? ? ? ?(0x184) /* port status and control */
> > +/* x_PORTSCx */
> > +#define PORTSC_PTS_MASK ? ? ? ? ? ? ? ?(3 << 30) /* parallel xcvr
> > +mask */ #define PORTSC_PTS_UTMI ? ? ? ? ? ? ? ?(0 << 30) /*
> > +UTMI/UTMI+ */ #define PORTSC_PTW ? ? ? ? ? ? (1 << 28) /* UTMI width
> > +*/
> > +/* USBCMD */
> > +#define UCMD_RUN_STOP ? ? ? ? ? (1 << 0) /* controller run/stop */
> > +#define UCMD_RESET ? ? ? ? ? ? (1 << 1) /* controller reset */
> > +
> > +#define HOSTPHY_CONNECT_STATE ?(1 << 3) #define
> STS_PCD
> > +(1 << 2) /* port change detect */
> > +
> > +struct mxs_usb_private_date {
> > + ? ? ? struct clk *usb_clk, *usb_phy_clk;
> > + ? ? ? int internal_phy_clk_already_on;
> > + ? ? ? void __iomem *phy_regs; ? ? ? ? /* usb phy register base */
> > + ? ? ? void __iomem *ctrl_regs; ? ? ? ?/* usb controller register
> > +base */ };
> > +
> > +static inline int fsl_platform_get_usb_connect_status
> > + ? ? ? ? ? ? ? ? ? ? ? (struct mxs_usb_private_date *ppriv) {
> > + ? ? ? u32 status;
> > +
> > + ? ? ? status = __raw_readl(ppriv->phy_regs + HW_USBPHY_STATUS);
> > +
> > + ? ? ? return ((status & HOSTPHY_CONNECT_STATE) == 0); }
> > +
> > +/* enable/disable high-speed disconnect detector of phy ctrl */
> > +static inline void fsl_platform_disconnect_detect
> > + ? ? ? ? ? ? ? ? ? ? ? (struct mxs_usb_private_date *ppriv, int
> > +enable) {
> > + ? ? ? if (enable) {
> > + ? ? ? ? ? ? ? __raw_writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
> > + ? ? ? ? ? ? ? ppriv->phy_regs + HW_USBPHY_CTRL_SET);
> > + ? ? ? } else {
> > + ? ? ? ? ? ? ? __raw_writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
> > + ? ? ? ? ? ? ? ppriv->phy_regs + HW_USBPHY_CTRL_CLR);
> > + ? ? ? }
> > +}
> > +
> > +static void fsl_plt_usbh_irq_handler(struct mxc_usbh_platform_data
> > +*pdata) {
> > + ? ? ? u32 ? ? ? ? ? ? ? ? ? ? status;
> > + ? ? ? struct mxs_usb_private_date *ppriv = pdata->ppriv;
> > +
> > + ? ? ? status = __raw_readl(ppriv->ctrl_regs + UOG_USBSTS);
> > +
> > + ? ? ? if (status & STS_PCD)
> > + ? ? ? ? ? ? ? fsl_platform_disconnect_detect(ppriv,
> > + ? ? ? ? ? ? ? ? ? ? ? fsl_platform_get_usb_connect_status(ppriv));
> > +}
> > +
> > +static int usb_phy_enable(struct mxc_usbh_platform_data *pdata) {
> > + ? ? ? u32 tmp;
> > + ? ? ? u32 i = 0;
> > + ? ? ? struct mxs_usb_private_date *ppriv = pdata->ppriv;
> > + ? ? ? void __iomem *usbcmd, *phy_ctrl, *portsc;
> > +
> > + ? ? ? /* Reset USB IP */
> > + ? ? ? /* Set run stop bit */
> > + ? ? ? /* Send reset command */
> > + ? ? ? usbcmd = ppriv->ctrl_regs + UOG_USBCMD;
> > + ? ? ? tmp = __raw_readl(usbcmd); /* usb command */
> > + ? ? ? tmp &= ~UCMD_RUN_STOP;
> > + ? ? ? __raw_writel(tmp, usbcmd);
> > + ? ? ? while (__raw_readl(usbcmd) & UCMD_RUN_STOP) {
> > + ? ? ? ? ? ? ? i++;
> > + ? ? ? ? ? ? ? if (i == 1000)
> > + ? ? ? ? ? ? ? ? ? ? ? break;
> > + ? ? ? ? ? ? ? mdelay(1);
> > + ? ? ? }
> > + ? ? ? tmp |= UCMD_RESET;
> > + ? ? ? __raw_writel(tmp, usbcmd);
> > + ? ? ? i = 0;
> > + ? ? ? while (__raw_readl(usbcmd) & UCMD_RESET) {
> > + ? ? ? ? ? ? ? i++;
> > + ? ? ? ? ? ? ? if (i == 1000)
> > + ? ? ? ? ? ? ? ? ? ? ? break;
> > + ? ? ? ? ? ? ? mdelay(1);
> > + ? ? ? }
> > + ? ? ? mdelay(10);
> > +
> > + ? ? ? /* Reset USBPHY module, set soft reset bit */
> > + ? ? ? phy_ctrl = ppriv->phy_regs + HW_USBPHY_CTRL;
> > + ? ? ? tmp = __raw_readl(phy_ctrl);
> > + ? ? ? tmp |= BM_USBPHY_CTRL_SFTRST;
> > + ? ? ? __raw_writel(tmp, phy_ctrl);
> > + ? ? ? udelay(10);
> > +
> > + ? ? ? /* clear CLKGATE and SFTRST bits to be out of reset mode*/
> > + ? ? ? tmp = __raw_readl(phy_ctrl);
> > + ? ? ? tmp &= ~(BM_USBPHY_CTRL_CLKGATE | BM_USBPHY_CTRL_SFTRST);
> > + ? ? ? __raw_writel(tmp, phy_ctrl);
> > + ? ? ? udelay(10);
> > +
> > + ? ? ? /* set UTMI xcvr */
> > + ? ? ? /* Workaround an IC issue for ehci driver:
> > + ? ? ? ?* when turn off root hub port power, EHCI set
> > + ? ? ? ?* PORTSC reserved bits to be 0, but PTW with 0
> > + ? ? ? ?* means 8 bits tranceiver width, here change
> > + ? ? ? ?* it back to be 16 bits and do PHY diable and
> > + ? ? ? ?* then enable.
> > + ? ? ? ?*/
> > + ? ? ? portsc = ppriv->ctrl_regs + UOG_PORTSC1;
> > + ? ? ? tmp = __raw_readl(portsc);
> > + ? ? ? tmp &= ?~PORTSC_PTS_MASK;
> > + ? ? ? tmp |= (PORTSC_PTS_UTMI | PORTSC_PTW);
> > + ? ? ? __raw_writel(tmp, portsc);
> > +
> > + ? ? ? /* Power up the PHY */
> > + ? ? ? __raw_writel(0, ppriv->phy_regs + HW_USBPHY_PWD);
> > + ? ? ? return 0;
> > +}
> > +
> > +static int fsl_usbh_init(struct platform_device *pdev) {
> > + ? ? ? struct mxc_usbh_platform_data *pdata =
> > +pdev->dev.platform_data;
> > + ? ? ? struct mxs_usb_private_date *ppriv = pdata->ppriv;
> > + ? ? ? u32 tmp;
> > +
> > + ? ? ? usb_phy_enable(pdata);
> > + ? ? ? /* enable FS/LS device */
> > + ? ? ? tmp = __raw_readl(ppriv->phy_regs + HW_USBPHY_CTRL);
> > + ? ? ? tmp |= (BM_USBPHY_CTRL_ENUTMILEVEL2 |
> > + BM_USBPHY_CTRL_ENUTMILEVEL3);
> > + ? ? ? __raw_writel(tmp, ppriv->phy_regs + HW_USBPHY_CTRL);
> > +
> > + ? ? ? return 0;
> > +}
> > +
> > +static void phy_clock_gate(struct mxs_usb_private_date *ppriv, bool
> > +on) {
> > + ? ? ? u32 tmp;
> > +
> > + ? ? ? if (on) {
> > + ? ? ? ? ? ? ? ppriv->internal_phy_clk_already_on += 1;
> > + ? ? ? ? ? ? ? if (ppriv->internal_phy_clk_already_on == 1) {
> > + ? ? ? ? ? ? ? ? ? ? ? tmp = BM_USBPHY_CTRL_SFTRST |
> > +BM_USBPHY_CTRL_CLKGATE;
> > + ? ? ? ? ? ? ? ? ? ? ? __raw_writel(tmp, ppriv->phy_regs +
> > +HW_USBPHY_CTRL_CLR);
> > + ? ? ? ? ? ? ? }
> > + ? ? ? } else {
> > + ? ? ? ? ? ? ? ppriv->internal_phy_clk_already_on -= 1;
> > + ? ? ? ? ? ? ? if (ppriv->internal_phy_clk_already_on == 0) {
> > + ? ? ? ? ? ? ? ? ? ? ? tmp = BM_USBPHY_CTRL_CLKGATE;
> > + ? ? ? ? ? ? ? ? ? ? ? __raw_writel(tmp, ppriv->phy_regs +
> > +HW_USBPHY_CTRL_SET);
> > + ? ? ? ? ? ? ? }
> > + ? ? ? }
> > + ? ? ? if (WARN_ON(ppriv->internal_phy_clk_already_on < 0))
> > + ? ? ? ? ? ? ? printk(KERN_ERR "please check phy clock ON/OFF
> > +sequence\n"); } static int fsl_usb_host_init(struct platform_device
> > +*pdev) {
> > + ? ? ? struct mxc_usbh_platform_data *pdata =
> > +pdev->dev.platform_data;
> > + ? ? ? struct mxs_usb_private_date *ppriv = pdata->ppriv;
> > +
> > + ? ? ? ppriv->phy_regs = ioremap(MX28_USBPHY1_BASE_ADDR, SZ_8K);
> > + ? ? ? if (ppriv->phy_regs == NULL)
> > + ? ? ? ? ? ? ? return -ENOMEM;
> > +
> > + ? ? ? ppriv->ctrl_regs = ioremap(MX28_USBCTRL1_BASE_ADDR, SZ_8K);
> > + ? ? ? if (ppriv->ctrl_regs == NULL)
> > + ? ? ? ? ? ? ? return -ENOMEM;
> > +
> > + ? ? ? ppriv->usb_clk = clk_get(&pdev->dev, "usb1");
> > + ? ? ? if (IS_ERR(ppriv->usb_clk))
> > + ? ? ? ? ? ? ? return PTR_ERR(ppriv->usb_clk);
> > + ? ? ? clk_enable(ppriv->usb_clk);
> > +
> > + ? ? ? ppriv->usb_phy_clk = clk_get(&pdev->dev, "usb1_phy");
> > + ? ? ? if (IS_ERR(ppriv->usb_phy_clk))
> > + ? ? ? ? ? ? ? return PTR_ERR(ppriv->usb_phy_clk);
> > + ? ? ? clk_enable(ppriv->usb_phy_clk);
> > +
> > + ? ? ? phy_clock_gate(ppriv, true);
> > + ? ? ? return fsl_usbh_init(pdev);
> > +}
> > +
> > +static int fsl_usb_host_uninit(struct platform_device *pdev) {
> > + ? ? ? struct mxc_usbh_platform_data *pdata =
> > +pdev->dev.platform_data;
> > + ? ? ? struct mxs_usb_private_date *ppriv = pdata->ppriv;
> > +
> > + ? ? ? phy_clock_gate(ppriv, false);
> > + ? ? ? if (ppriv->usb_phy_clk) {
> > + ? ? ? ? ? ? ? clk_disable(ppriv->usb_phy_clk);
> > + ? ? ? ? ? ? ? clk_put(ppriv->usb_phy_clk);
> > + ? ? ? }
> > + ? ? ? if (ppriv->usb_clk) {
> > + ? ? ? ? ? ? ? clk_disable(ppriv->usb_clk);
> > + ? ? ? ? ? ? ? clk_put(ppriv->usb_clk);
> > + ? ? ? }
> > + ? ? ? if (ppriv->phy_regs)
> > + ? ? ? ? ? ? ? iounmap(ppriv->phy_regs);
> > + ? ? ? if (ppriv->ctrl_regs)
> > + ? ? ? ? ? ? ? iounmap(ppriv->ctrl_regs);
> > +
> > + ? ? ? return 0;
> > +}
> > +
> > +static struct mxs_usb_private_date usbh_private = {
> > + ? ? ? .internal_phy_clk_already_on = 0, };
> > +
> > +static struct mxc_usbh_platform_data usbh_config = {
> > + ? ? ? .init = fsl_usb_host_init,
> > + ? ? ? .exit = fsl_usb_host_uninit,
> > + ? ? ? .portsc = MXC_EHCI_MODE_ULPI,
> > + ? ? ? .otg = NULL,
> > + ? ? ? .plt_irq_handler = fsl_plt_usbh_irq_handler,
> > + ? ? ? .ppriv = &usbh_private,
> > +};
> > +
> > +/* The resources for kinds of usb devices */ static struct resource
> > +usbh_resources[] = {
> > + ? ? ? {
> > + ? ? ? ? ? ? ? .start = MX28_USBCTRL1_BASE_ADDR,
> > + ? ? ? ? ? ? ? .end = MX28_USBCTRL1_BASE_ADDR + 0x1ff,
> > + ? ? ? ? ? ? ? .flags = IORESOURCE_MEM,
> > + ? ? ? },
> > + ? ? ? {
> > + ? ? ? ? ? ? ? .start = MX28_INT_USB1,
> > + ? ? ? ? ? ? ? .flags = IORESOURCE_IRQ,
> > + ? ? ? },
> > +};
> > +
> > +static int __init usbh_init(void)
> > +{
> > + ? ? ? struct platform_device *pdev;
> > + ? ? ? int instance_id = ~(u32) 0;
> > + ? ? ? u64 ehci_dmamask = ~(u32) 0;
> > +
> > + ? ? ? if (!cpu_is_mx28())
> > + ? ? ? ? ? ? ? return 0;
> > +
> > + ? ? ? pdev = platform_device_register_resndata(NULL, "mxc-ehci",
> > + instance_id,
> > + ? ? ? ? ? ? ? ? ? ? ? usbh_resources, ARRAY_SIZE(usbh_resources),
> > + ? ? ? ? ? ? ? ? ? ? ? &usbh_config, sizeof(struct
> > + mxc_usbh_platform_data));
> > + ? ? ? if (IS_ERR(pdev)) {
> > + ? ? ? ? ? ? ? pr_debug("can't register Host, %ld\n", PTR_ERR(pdev));
> > + ? ? ? ? ? ? ? return PTR_ERR(pdev);
> > + ? ? ? }
> > +
> > + ? ? ? pdev->dev.coherent_dma_mask = 0xffffffff;
> > + ? ? ? pdev->dev.dma_mask = &ehci_dmamask;
> > +
> > + ? ? ? return 0;
> > +}
> > +module_init(usbh_init);
> > diff --git a/arch/arm/mach-mxs/regs-usbphy-mx28.h
> > b/arch/arm/mach-mxs/regs-usbphy-mx28.h
> > new file mode 100644
> > index 0000000..2ec273b
> > --- /dev/null
> > +++ b/arch/arm/mach-mxs/regs-usbphy-mx28.h
> > @@ -0,0 +1,240 @@
> > +/*
> > + * Freescale USBPHY Register Definitions
> > + *
> > + * Copyright 2008-2011 Freescale Semiconductor, Inc. All Rights
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
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
> > +02111-1307 USA
> > + *
> > + *
> > + * Xml Revision: 1.52
> > + * Template revision: 26195
> > + */
> > +
> > +#ifndef __ARCH_ARM___USBPHY_H
> > +#define __ARCH_ARM___USBPHY_H
> > +
> > +
> > +#define HW_USBPHY_PWD ? ? ? ? ?0x00000000 #define
> HW_USBPHY_PWD_SET
> > +0x00000004 #define HW_USBPHY_PWD_CLR ? ? ?0x00000008 #define
> > +HW_USBPHY_PWD_TOG ? ? ?0x0000000c
> > +
> > +#define BM_USBPHY_PWD_RXPWDRX ?0x00100000 #define
> > +BM_USBPHY_PWD_RXPWDDIFF ? ? ? ?0x00080000 #define
> > +BM_USBPHY_PWD_RXPWD1PT1 ? ? ? ?0x00040000 #define
> > +BM_USBPHY_PWD_RXPWDENV 0x00020000
> > +
> > +#define BM_USBPHY_PWD_TXPWDV2I 0x00001000 #define
> > +BM_USBPHY_PWD_TXPWDIBIAS ? ? ? 0x00000800 #define
> > +BM_USBPHY_PWD_TXPWDFS ?0x00000400
> > +
> > +#define HW_USBPHY_TX ? ? ? ? ? 0x00000010 #define
> HW_USBPHY_TX_SET
> > +0x00000014 #define HW_USBPHY_TX_CLR ? ? ? 0x00000018 #define
> > +HW_USBPHY_TX_TOG ? ? ? 0x0000001c
> > +
> > +#define BP_USBPHY_TX_USBPHY_TX_EDGECTRL ? ? ? ?26 #define
> > +BM_USBPHY_TX_USBPHY_TX_EDGECTRL ? ? ? ?0x1C000000 #define
> > +BF_USBPHY_TX_USBPHY_TX_EDGECTRL(v) ?\
> > + ? ? ? ? ? ? ? (((v) << 26) & BM_USBPHY_TX_USBPHY_TX_EDGECTRL)
> > +#define BM_USBPHY_TX_USBPHY_TX_SYNC_INVERT ? ? 0x02000000 #define
> > +BM_USBPHY_TX_USBPHY_TX_SYNC_MUX ? ? ? ?0x01000000
> > +
> > +#define BM_USBPHY_TX_TXENCAL45DP ? ? ? 0x00200000 #define
> > +BP_USBPHY_TX_TXCAL45DP 16 #define BM_USBPHY_TX_TXCAL45DP 0x000F0000
> > +#define BF_USBPHY_TX_TXCAL45DP(v) ?\
> > + ? ? ? ? ? ? ? (((v) << 16) & BM_USBPHY_TX_TXCAL45DP) #define
> > +BM_USBPHY_TX_TXENCAL45DN ? ? ? 0x00002000 #define
> > +BP_USBPHY_TX_TXCAL45DN 8 #define BM_USBPHY_TX_TXCAL45DN 0x00000F00
> > +#define BF_USBPHY_TX_TXCAL45DN(v) ?\
> > + ? ? ? ? ? ? ? (((v) << 8) & BM_USBPHY_TX_TXCAL45DN)
> > +
> > +#define BP_USBPHY_TX_D_CAL ? ? 0
> > +#define BM_USBPHY_TX_D_CAL ? ? 0x0000000F #define
> > +BF_USBPHY_TX_D_CAL(v) ?\
> > + ? ? ? ? ? ? ? (((v) << 0) & BM_USBPHY_TX_D_CAL)
> > +
> > +#define HW_USBPHY_RX ? ? ? ? ? 0x00000020 #define
> HW_USBPHY_RX_SET
> > +0x00000024 #define HW_USBPHY_RX_CLR ? ? ? 0x00000028 #define
> > +HW_USBPHY_RX_TOG ? ? ? 0x0000002c
> > +
> > +#define BM_USBPHY_RX_RXDBYPASS 0x00400000 #define
> > +BP_USBPHY_RX_DISCONADJ 4 #define BM_USBPHY_RX_DISCONADJ 0x00000070
> > +#define BF_USBPHY_RX_DISCONADJ(v) ?\
> > + ? ? ? ? ? ? ? (((v) << 4) & BM_USBPHY_RX_DISCONADJ) #define
> > +BP_USBPHY_RX_ENVADJ ? ?0 #define BM_USBPHY_RX_ENVADJ ? ?0x00000007
> > +#define BF_USBPHY_RX_ENVADJ(v) ?\
> > + ? ? ? ? ? ? ? (((v) << 0) & BM_USBPHY_RX_ENVADJ)
> > +
> > +#define HW_USBPHY_CTRL ? ? ? ? 0x00000030 #define
> HW_USBPHY_CTRL_SET
> > +0x00000034 #define HW_USBPHY_CTRL_CLR ? ? 0x00000038 #define
> > +HW_USBPHY_CTRL_TOG ? ? 0x0000003c
> > +
> > +#define BM_USBPHY_CTRL_SFTRST ?0x80000000 #define
> > +BM_USBPHY_CTRL_CLKGATE 0x40000000 #define
> > +BM_USBPHY_CTRL_UTMI_SUSPENDM ? 0x20000000 #define
> > +BM_USBPHY_CTRL_HOST_FORCE_LS_SE0 ? ? ? 0x10000000 #define
> > +BM_USBPHY_CTRL_ENAUTOSET_USBCLKS ? ? ? 0x04000000 #define
> > +BM_USBPHY_CTRL_ENAUTOCLR_USBCLKGATE ? ?0x02000000 #define
> > +BM_USBPHY_CTRL_FSDLL_RST_EN ? ?0x01000000 #define
> > +BM_USBPHY_CTRL_ENVBUSCHG_WKUP ?0x00800000 #define
> > +BM_USBPHY_CTRL_ENIDCHG_WKUP ? ?0x00400000 #define
> > +BM_USBPHY_CTRL_ENDPDMCHG_WKUP ?0x00200000 #define
> > +BM_USBPHY_CTRL_ENAUTOCLR_PHY_PWD ? ? ? 0x00100000 #define
> > +BM_USBPHY_CTRL_ENAUTOCLR_CLKGATE ? ? ? 0x00080000 #define
> > +BM_USBPHY_CTRL_ENAUTO_PWRON_PLL ? ? ? ?0x00040000 #define
> > +BM_USBPHY_CTRL_WAKEUP_IRQ ? ? ?0x00020000 #define
> > +BM_USBPHY_CTRL_ENIRQWAKEUP ? ? 0x00010000 #define
> > +BM_USBPHY_CTRL_ENUTMILEVEL3 ? ?0x00008000 #define
> > +BM_USBPHY_CTRL_ENUTMILEVEL2 ? ?0x00004000 #define
> > +BM_USBPHY_CTRL_DATA_ON_LRADC ? 0x00002000 #define
> > +BM_USBPHY_CTRL_DEVPLUGIN_IRQ ? 0x00001000 #define
> > +BM_USBPHY_CTRL_ENIRQDEVPLUGIN ?0x00000800 #define
> > +BM_USBPHY_CTRL_RESUME_IRQ ? ? ?0x00000400 #define
> > +BM_USBPHY_CTRL_ENIRQRESUMEDETECT ? ? ? 0x00000200 #define
> > +BM_USBPHY_CTRL_RESUMEIRQSTICKY 0x00000100 #define
> > +BM_USBPHY_CTRL_ENOTGIDDETECT ? 0x00000080 #define
> > +BM_USBPHY_CTRL_DEVPLUGIN_POLARITY ? ? ?0x00000020 #define
> > +BM_USBPHY_CTRL_ENDEVPLUGINDETECT ? ? ? 0x00000010 #define
> > +BM_USBPHY_CTRL_HOSTDISCONDETECT_IRQ ? ?0x00000008 #define
> > +BM_USBPHY_CTRL_ENIRQHOSTDISCON 0x00000004 #define
> > +BM_USBPHY_CTRL_ENHOSTDISCONDETECT ? ? ?0x00000002
> > +
> > +#define HW_USBPHY_STATUS ? ? ? 0x00000040
> > +
> > +#define BM_USBPHY_STATUS_RESUME_STATUS 0x00000400 #define
> > +BM_USBPHY_STATUS_OTGID_STATUS ?0x00000100 #define
> > +BM_USBPHY_STATUS_DEVPLUGIN_STATUS ? ? ?0x00000040 #define
> > +BM_USBPHY_STATUS_HOSTDISCONDETECT_STATUS ? ? ? 0x00000008
> > +
> > +#define HW_USBPHY_DEBUG ? ? ? ? ? ? ? ?0x00000050 #define
> > +HW_USBPHY_DEBUG_SET ? ?0x00000054 #define HW_USBPHY_DEBUG_CLR
> > +0x00000058 #define HW_USBPHY_DEBUG_TOG ? ?0x0000005c
> > +
> > +#define BM_USBPHY_DEBUG_CLKGATE ? ? ? ?0x40000000 #define
> > +BM_USBPHY_DEBUG_HOST_RESUME_DEBUG ? ? ?0x20000000 #define
> > +BP_USBPHY_DEBUG_SQUELCHRESETLENGTH ? ? 25 #define
> > +BM_USBPHY_DEBUG_SQUELCHRESETLENGTH ? ? 0x1E000000 #define
> > +BF_USBPHY_DEBUG_SQUELCHRESETLENGTH(v) ?\
> > + ? ? ? ? ? ? ? (((v) << 25) & BM_USBPHY_DEBUG_SQUELCHRESETLENGTH)
> > +#define BM_USBPHY_DEBUG_ENSQUELCHRESET 0x01000000 #define
> > +BP_USBPHY_DEBUG_SQUELCHRESETCOUNT ? ? ?16 #define
> > +BM_USBPHY_DEBUG_SQUELCHRESETCOUNT ? ? ?0x001F0000 #define
> > +BF_USBPHY_DEBUG_SQUELCHRESETCOUNT(v) ?\
> > + ? ? ? ? ? ? ? (((v) << 16) & BM_USBPHY_DEBUG_SQUELCHRESETCOUNT)
> > +#define BM_USBPHY_DEBUG_ENTX2RXCOUNT ? 0x00001000 #define
> > +BP_USBPHY_DEBUG_TX2RXCOUNT ? ? 8 #define
> BM_USBPHY_DEBUG_TX2RXCOUNT
> > +0x00000F00 #define BF_USBPHY_DEBUG_TX2RXCOUNT(v) ?\
> > + ? ? ? ? ? ? ? (((v) << 8) & BM_USBPHY_DEBUG_TX2RXCOUNT) #define
> > +BP_USBPHY_DEBUG_ENHSTPULLDOWN ?4 #define
> > +BM_USBPHY_DEBUG_ENHSTPULLDOWN ?0x00000030 #define
> > +BF_USBPHY_DEBUG_ENHSTPULLDOWN(v) ?\
> > + ? ? ? ? ? ? ? (((v) << 4) & BM_USBPHY_DEBUG_ENHSTPULLDOWN) #define
> > +BP_USBPHY_DEBUG_HSTPULLDOWN ? ?2 #define
> BM_USBPHY_DEBUG_HSTPULLDOWN
> > +0x0000000C #define BF_USBPHY_DEBUG_HSTPULLDOWN(v) ?\
> > + ? ? ? ? ? ? ? (((v) << 2) & BM_USBPHY_DEBUG_HSTPULLDOWN) #define
> > +BM_USBPHY_DEBUG_DEBUG_INTERFACE_HOLD ? 0x00000002 #define
> > +BM_USBPHY_DEBUG_OTGIDPIOLOCK ? 0x00000001
> > +
> > +#define HW_USBPHY_DEBUG0_STATUS ? ? ? ?0x00000060
> > +
> > +#define BP_USBPHY_DEBUG0_STATUS_SQUELCH_COUNT ?26 #define
> > +BM_USBPHY_DEBUG0_STATUS_SQUELCH_COUNT ?0xFC000000 #define
> > +BF_USBPHY_DEBUG0_STATUS_SQUELCH_COUNT(v) \
> > + ? ? ? ? ? ? ? (((v) << 26) & BM_USBPHY_DEBUG0_STATUS_SQUELCH_COUNT)
> > +#define BP_USBPHY_DEBUG0_STATUS_UTMI_RXERROR_FAIL_COUNT ? ? ? ?16
> > +#define BM_USBPHY_DEBUG0_STATUS_UTMI_RXERROR_FAIL_COUNT
> > +0x03FF0000 #define
> BF_USBPHY_DEBUG0_STATUS_UTMI_RXERROR_FAIL_COUNT(v)
> > +\
> > + ? ? ? ? ? ? ? (((v) << 16) &
> > +BM_USBPHY_DEBUG0_STATUS_UTMI_RXERROR_FAIL_COUNT)
> > +#define BP_USBPHY_DEBUG0_STATUS_LOOP_BACK_FAIL_COUNT ? 0 #define
> > +BM_USBPHY_DEBUG0_STATUS_LOOP_BACK_FAIL_COUNT ? 0x0000FFFF #define
> > +BF_USBPHY_DEBUG0_STATUS_LOOP_BACK_FAIL_COUNT(v) ?\
> > + ? ? ? ? ? ? ? (((v) << 0) &
> > +BM_USBPHY_DEBUG0_STATUS_LOOP_BACK_FAIL_COUNT)
> > +
> > +#define HW_USBPHY_DEBUG1 ? ? ? 0x00000070 #define
> > +HW_USBPHY_DEBUG1_SET ? 0x00000074 #define HW_USBPHY_DEBUG1_CLR
> > +0x00000078 #define HW_USBPHY_DEBUG1_TOG ? 0x0000007c
> > +
> > +#define BP_USBPHY_DEBUG1_ENTAILADJVD ? 13 #define
> > +BM_USBPHY_DEBUG1_ENTAILADJVD ? 0x00006000 #define
> > +BF_USBPHY_DEBUG1_ENTAILADJVD(v) ?\
> > + ? ? ? ? ? ? ? (((v) << 13) & BM_USBPHY_DEBUG1_ENTAILADJVD) #define
> > +BM_USBPHY_DEBUG1_ENTX2TX ? ? ? 0x00001000 #define
> > +BP_USBPHY_DEBUG1_DBG_ADDRESS ? 0 #define
> BM_USBPHY_DEBUG1_DBG_ADDRESS
> > +0x0000000F #define BF_USBPHY_DEBUG1_DBG_ADDRESS(v) ?\
> > + ? ? ? ? ? ? ? (((v) << 0) & BM_USBPHY_DEBUG1_DBG_ADDRESS)
> > +
> > +#define HW_USBPHY_VERSION ? ? ?0x00000080
> > +
> > +#define BP_USBPHY_VERSION_MAJOR ? ? ? ?24 #define
> > +BM_USBPHY_VERSION_MAJOR ? ? ? ?0xFF000000 #define
> > +BF_USBPHY_VERSION_MAJOR(v) \
> > + ? ? ? ? ? ? ? (((v) << 24) & BM_USBPHY_VERSION_MAJOR) #define
> > +BP_USBPHY_VERSION_MINOR ? ? ? ?16 #define
> BM_USBPHY_VERSION_MINOR
> > +0x00FF0000 #define BF_USBPHY_VERSION_MINOR(v) ?\
> > + ? ? ? ? ? ? ? (((v) << 16) & BM_USBPHY_VERSION_MINOR) #define
> > +BP_USBPHY_VERSION_STEP 0 #define BM_USBPHY_VERSION_STEP 0x0000FFFF
> > +#define BF_USBPHY_VERSION_STEP(v) ?\
> > + ? ? ? ? ? ? ? (((v) << 0) & BM_USBPHY_VERSION_STEP)
> > +
> > +#define HW_USBPHY_IP ? ? ? ? ? 0x00000090 #define
> HW_USBPHY_IP_SET
> > +0x00000094 #define HW_USBPHY_IP_CLR ? ? ? 0x00000098 #define
> > +HW_USBPHY_IP_TOG ? ? ? 0x0000009c
> > +
> > +#define BP_USBPHY_IP_DIV_SEL ? 23
> > +#define BM_USBPHY_IP_DIV_SEL ? 0x01800000 #define
> > +BF_USBPHY_IP_DIV_SEL(v) ?\
> > + ? ? ? ? ? ? ? (((v) << 23) & BM_USBPHY_IP_DIV_SEL) #define
> > +BV_USBPHY_IP_DIV_SEL__DEFAULT ? 0x0 #define
> > +BV_USBPHY_IP_DIV_SEL__LOWER ? ? 0x1 #define
> > +BV_USBPHY_IP_DIV_SEL__LOWEST ? ?0x2 #define
> > +BV_USBPHY_IP_DIV_SEL__UNDEFINED 0x3 #define BP_USBPHY_IP_LFR_SEL ? 21
> > +#define BM_USBPHY_IP_LFR_SEL ? 0x00600000 #define
> > +BF_USBPHY_IP_LFR_SEL(v) ?\
> > + ? ? ? ? ? ? ? (((v) << 21) & BM_USBPHY_IP_LFR_SEL) #define
> > +BV_USBPHY_IP_LFR_SEL__DEFAULT ? 0x0 #define
> > +BV_USBPHY_IP_LFR_SEL__TIMES_2 ? 0x1 #define
> > +BV_USBPHY_IP_LFR_SEL__TIMES_05 ?0x2 #define
> > +BV_USBPHY_IP_LFR_SEL__UNDEFINED 0x3 #define BP_USBPHY_IP_CP_SEL ? ?19
> > +#define BM_USBPHY_IP_CP_SEL ? ?0x00180000 #define
> > +BF_USBPHY_IP_CP_SEL(v) ?\
> > + ? ? ? ? ? ? ? (((v) << 19) & BM_USBPHY_IP_CP_SEL) #define
> > +BV_USBPHY_IP_CP_SEL__DEFAULT ? 0x0 #define
> > +BV_USBPHY_IP_CP_SEL__TIMES_2 ? 0x1 #define
> > +BV_USBPHY_IP_CP_SEL__TIMES_05 ?0x2 #define
> > +BV_USBPHY_IP_CP_SEL__UNDEFINED 0x3 #define
> BM_USBPHY_IP_TSTI_TX_DP
> > +0x00040000 #define BM_USBPHY_IP_TSTI_TX_DM ? ? ? ?0x00020000 #define
> > +BM_USBPHY_IP_ANALOG_TESTMODE ? 0x00010000 #define
> > +BM_USBPHY_IP_EN_USB_CLKS ? ? ? 0x00000004 #define
> > +BM_USBPHY_IP_PLL_LOCKED ? ? ? ?0x00000002 #define
> > +BM_USBPHY_IP_PLL_POWER 0x00000001 #endif /* __ARCH_ARM___USBPHY_H */
> > --
> > 1.7.0.4
> >
> >
> >
