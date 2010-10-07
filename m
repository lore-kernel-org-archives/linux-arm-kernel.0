From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Thu, 7 Oct 2010 15:04:59 +0300
Subject: [PATCH 3/3] mx51: Move OTG initialisation for all boards to a
	single file
In-Reply-To: <20101007070839.GO29673@pengutronix.de>
References: <cover.1286412080.git.amit.kucheria@linaro.org>
	<2306a14fec6647b68a4aee1743a75d040ec141b1.1286412080.git.amit.kucheria@linaro.org>
	<20101007070839.GO29673@pengutronix.de>
Message-ID: <20101007120459.GJ2457@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Oct 07, Uwe Kleine-K?nig wrote:
> On Thu, Oct 07, 2010 at 03:58:48AM +0300, Amit Kucheria wrote:
> > The OTG initialisation is the same for all MX51 boards currently known. Move
> > to a common file.
> > 
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm/mach-mx5/Makefile             |    2 +-
> >  arch/arm/mach-mx5/board-cpuimx51.c     |   25 +-------------------
> >  arch/arm/mach-mx5/board-mx51_babbage.c |   25 +-------------------
> >  arch/arm/mach-mx5/board-mx51_efikamx.c |   23 +-----------------
> >  arch/arm/mach-mx5/usb.c                |   40 ++++++++++++++++++++++++++++++++
> >  5 files changed, 44 insertions(+), 71 deletions(-)
> >  create mode 100644 arch/arm/mach-mx5/usb.c
> > 
> > diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
> > index d1aac9c..1daba15 100644
> > --- a/arch/arm/mach-mx5/Makefile
> > +++ b/arch/arm/mach-mx5/Makefile
> > @@ -3,7 +3,7 @@
> >  #
> >  
> >  # Object file lists.
> > -obj-y   := cpu.o mm.o clock-mx51.o devices.o
> > +obj-y   := cpu.o mm.o clock-mx51.o devices.o usb.o
> >  
> >  obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
> >  obj-$(CONFIG_MACH_MX51_3DS) += board-mx51_3ds.o
> > diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
> > index a6c09c7..c54d26e 100644
> > --- a/arch/arm/mach-mx5/board-cpuimx51.c
> > +++ b/arch/arm/mach-mx5/board-cpuimx51.c
> > @@ -56,9 +56,7 @@
> >  #define MX51_USB_CTRL_1_OFFSET		0x10
> >  #define MX51_USB_CTRL_UH1_EXT_CLK_EN	(1 << 25)
> >  
> > -#define	MX51_USB_PLLDIV_12_MHZ		0x00
> > -#define	MX51_USB_PLL_DIV_19_2_MHZ	0x01
> > -#define	MX51_USB_PLL_DIV_24_MHZ		0x02
> > +extern int initialize_otg_port(struct platform_device *pdev);
> I suggest to put this in a header file.

OK.

> >  
> >  #if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
> >  static struct plat_serial8250_port serial_platform_data[] = {
> > @@ -162,27 +160,6 @@ static struct i2c_board_info eukrea_cpuimx51_i2c_devices[] = {
> >  	},
> >  };
> >  
> > -/* This function is board specific as the bit mask for the plldiv will also
> > -be different for other Freescale SoCs, thus a common bitmask is not
> > -possible and cannot get place in /plat-mxc/ehci.c.*/
> > -static int initialize_otg_port(struct platform_device *pdev)
> > -{
> > -	u32 v;
> > -	void __iomem *usb_base;
> > -	void __iomem *usbother_base;
> > -
> > -	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
> > -	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
> > -
> > -	/* Set the PHY clock to 19.2MHz */
> > -	v = __raw_readl(usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
> > -	v &= ~MX5_USB_UTMI_PHYCTRL1_PLLDIV_MASK;
> > -	v |= MX51_USB_PLL_DIV_19_2_MHZ;
> > -	__raw_writel(v, usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
> > -	iounmap(usb_base);
> > -	return 0;
> > -}
> > -
> >  static int initialize_usbh1_port(struct platform_device *pdev)
> >  {
> >  	u32 v;
> > diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
> > index 7c0b661..cdbbec8 100644
> > --- a/arch/arm/mach-mx5/board-mx51_babbage.c
> > +++ b/arch/arm/mach-mx5/board-mx51_babbage.c
> > @@ -42,9 +42,7 @@
> >  #define MX51_USB_CTRL_1_OFFSET			0x10
> >  #define MX51_USB_CTRL_UH1_EXT_CLK_EN		(1 << 25)
> >  
> > -#define	MX51_USB_PLLDIV_12_MHZ		0x00
> > -#define	MX51_USB_PLL_DIV_19_2_MHZ	0x01
> > -#define	MX51_USB_PLL_DIV_24_MHZ	0x02
> > +extern int initialize_otg_port(struct platform_device *pdev);
> >  
> >  static struct platform_device *devices[] __initdata = {
> >  	&mxc_fec_device,
> > @@ -210,27 +208,6 @@ static inline void babbage_fec_reset(void)
> >  	gpio_set_value(BABBAGE_FEC_PHY_RESET, 1);
> >  }
> >  
> > -/* This function is board specific as the bit mask for the plldiv will also
> > -be different for other Freescale SoCs, thus a common bitmask is not
> > -possible and cannot get place in /plat-mxc/ehci.c.*/
> > -static int initialize_otg_port(struct platform_device *pdev)
> > -{
> > -	u32 v;
> > -	void __iomem *usb_base;
> > -	void __iomem *usbother_base;
> > -
> > -	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
> > -	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
> > -
> > -	/* Set the PHY clock to 19.2MHz */
> > -	v = __raw_readl(usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
> > -	v &= ~MX5_USB_UTMI_PHYCTRL1_PLLDIV_MASK;
> > -	v |= MX51_USB_PLL_DIV_19_2_MHZ;
> > -	__raw_writel(v, usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
> > -	iounmap(usb_base);
> > -	return 0;
> > -}
> > -
> >  static int initialize_usbh1_port(struct platform_device *pdev)
> >  {
> >  	u32 v;
> > diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
> > index b00502a..93734ae 100644
> > --- a/arch/arm/mach-mx5/board-mx51_efikamx.c
> > +++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
> > @@ -37,7 +37,7 @@
> >  #include "devices-imx51.h"
> >  #include "devices.h"
> >  
> > -#define	MX51_USB_PLL_DIV_24_MHZ	0x01
> > +extern int initialize_otg_port(struct platform_device *pdev);
> >  
> >  static struct pad_desc mx51efikamx_pads[] = {
> >  	/* UART1 */
> > @@ -65,27 +65,6 @@ static inline void mxc_init_imx_uart(void)
> >  }
> >  #endif /* SERIAL_IMX */
> >  
> > -/* This function is board specific as the bit mask for the plldiv will also
> > - * be different for other Freescale SoCs, thus a common bitmask is not
> > - * possible and cannot get place in /plat-mxc/ehci.c.
> > - */
> > -static int initialize_otg_port(struct platform_device *pdev)
> > -{
> > -	u32 v;
> > -	void __iomem *usb_base;
> > -	void __iomem *usbother_base;
> > -	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
> > -	usbother_base = (void __iomem *)(usb_base + MX5_USBOTHER_REGS_OFFSET);
> > -
> > -	/* Set the PHY clock to 19.2MHz */
> > -	v = __raw_readl(usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
> > -	v &= ~MX5_USB_UTMI_PHYCTRL1_PLLDIV_MASK;
> > -	v |= MX51_USB_PLL_DIV_24_MHZ;
> > -	__raw_writel(v, usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
> > -	iounmap(usb_base);
> > -	return 0;
> > -}
> > -
> >  static struct mxc_usbh_platform_data dr_utmi_config = {
> >  	.init   = initialize_otg_port,
> >  	.portsc = MXC_EHCI_UTMI_16BIT,
> > diff --git a/arch/arm/mach-mx5/usb.c b/arch/arm/mach-mx5/usb.c
> > new file mode 100644
> > index 0000000..277f957
> > --- /dev/null
> > +++ b/arch/arm/mach-mx5/usb.c
> > @@ -0,0 +1,40 @@
> > +/*
> > + * Copyright (C) 2010 Linaro Limited
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > +#include <linux/platform_device.h>
> > +#include <linux/io.h>
> > +
> > +#include <mach/hardware.h>
> > +#include <mach/mxc_ehci.h>
> > +
> > +#define	MX51_USB_PLL_DIV_24_MHZ	0x01
> > +
> > +/* This function is SoC specific as the bit mask for the plldiv will also
> > + * be different for other Freescale SoCs, thus a common bitmask is not
> > + * possible and cannot get place in /plat-mxc/ehci.c.
> > + */
> > +int initialize_otg_port(struct platform_device *pdev)
> > +{
> > +	u32 v;
> > +	void __iomem *usb_base;
> > +	void __iomem *usbother_base;
> > +
> > +	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
> > +	usbother_base = (void __iomem *)(usb_base + MX5_USBOTHER_REGS_OFFSET);
> > +
> > +	/* Set the PHY clock to 24 MHz */
> > +	v = __raw_readl(usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
> > +	v &= ~MX5_USB_UTMI_PHYCTRL1_PLLDIV_MASK;
> I wonder why a field in a register called MXC_USB_PHY_CTR_FUNC2 is named
> MX5_USB_UTMI_PHYCTRL1_PLLDIV.  Usually the register name is a prefix for
> the field name?!

I have a patch renaming the various bit-fields and registers to conform to
the reference manual. I'll post it soon.

> > +	v |= MX51_USB_PLL_DIV_24_MHZ;
> hmm, babbage used

> 	> -     v &= ~MX5_USB_UTMI_PHYCTRL1_PLLDIV_MASK;
> 	> -     v |= MX51_USB_PLL_DIV_19_2_MHZ;
> 
> ?

Good catch :)

But if you look at the reference manual, table 60-6, 19.2 MHz would use a
value of 0x0, but the actual code uses a value of 0x1 that corresponds to
24MHz. 19.2MHz (0x0) doesn't even work for me.

> Maybe you want to reorder your patches such that your patch 2 comes
> after this one, as currently this patch removes ~80% of the code patch 2
> introduces.

I did it to make bisection easier. I didn't want to add a new board feature
and do consolidation in a single patch.

> Otherwise the same comments apply here that I made on patch 2.

Thanks for the review.

Will send out updates.
