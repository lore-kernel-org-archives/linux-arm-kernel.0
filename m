From: lukma@denx.de (Lukasz Majewski)
Date: Wed, 29 Nov 2017 23:07:04 +0100
Subject: [PATCH v2 6/6] ARM: ep93xx: ts72xx: Add support for BK3 board -
 ts72xx derivative
In-Reply-To: <86943b7f-be3a-2f41-1ffe-c4d7abfee148@gmail.com>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171121143204.1839-1-lukma@denx.de>
 <20171121143204.1839-7-lukma@denx.de>
 <86943b7f-be3a-2f41-1ffe-c4d7abfee148@gmail.com>
Message-ID: <20171129230704.68b5ec42@jawa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

> Hello Lukasz,
> 
> some nitpicking below...
> 
> On 21/11/17 15:32, Lukasz Majewski wrote:
> > The BK3 board is a derivative of the ts72xx reference design.
> > 
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> > Changes for v2:
> > - Place bk3 support code to the ts72xx.c file
> > ---
> >  arch/arm/mach-ep93xx/Kconfig  |  7 +++++
> >  arch/arm/mach-ep93xx/ts72xx.c | 64
> > +++++++++++++++++++++++++++++++++++++++++++
> > arch/arm/mach-ep93xx/ts72xx.h |  5 ++++
> > arch/arm/tools/mach-types     |  1 + 4 files changed, 77
> > insertions(+)
> > 
> > diff --git a/arch/arm/mach-ep93xx/Kconfig
> > b/arch/arm/mach-ep93xx/Kconfig index 61a75ca3684e..c095236d7ff8
> > 100644 --- a/arch/arm/mach-ep93xx/Kconfig
> > +++ b/arch/arm/mach-ep93xx/Kconfig
> > @@ -21,6 +21,13 @@ config MACH_ADSSPHERE
> >  	  Say 'Y' here if you want your kernel to support the ADS
> >  	  Sphere board.
> >  
> > +config MACH_BK3
> > +	bool "Support Liebherr BK3.1"
> > +	select MACH_TS72XX
> > +	help
> > +	  Say 'Y' here if you want your kernel to support the
> > +	  Liebherr controller BK3.1.
> > +
> >  config MACH_EDB93XX
> >  	bool
> >  
> > diff --git a/arch/arm/mach-ep93xx/ts72xx.c
> > b/arch/arm/mach-ep93xx/ts72xx.c index 2e8fcc6e87b6..0de19b136ad0
> > 100644 --- a/arch/arm/mach-ep93xx/ts72xx.c
> > +++ b/arch/arm/mach-ep93xx/ts72xx.c
> > @@ -18,8 +18,10 @@
> >  #include <linux/io.h>
> >  #include <linux/mtd/rawnand.h>
> >  #include <linux/mtd/partitions.h>
> > +#include <linux/amba/bus.h>
> >  
> >  #include <mach/hardware.h>
> > +#include <mach/irqs.h>
> >  
> >  #include <asm/mach-types.h>
> >  #include <asm/mach/map.h>
> > @@ -261,3 +263,65 @@ MACHINE_START(TS72XX, "Technologic Systems
> > TS-72xx SBC") .init_late	= ep93xx_init_late,
> >  	.restart	= ep93xx_restart,
> >  MACHINE_END
> > +
> > +/*************************************************************************
> > + * BK3 support code
> > +
> > *************************************************************************/
> > +static struct mtd_partition bk3_nand_parts[] = {
> > +	{
> > +		.name		= "System",
> > +		.offset	= 0x00000000,  
> 
> I see the above and below lines as unaligned

This is strange.... I'm using emacs with extension to have coding style
for kernel.

Probably tabs get unaligned...

> 
> > +		.size		= 0x01e00000,
> > +	}, {
> > +		.name		= "Data",
> > +		.offset	= 0x01e00000,  
> 
> same here
> 
> > +		.size		= 0x05f20000
> > +	}, {
> > +		.name		= "RedBoot",
> > +		.offset	= 0x07d20000,  
> 
> same here
> 
> > +		.size		= 0x002e0000,
> > +		.mask_flags	= MTD_WRITEABLE,	/*
> > force RO */
> > +	},
> > +};
> > +
> > +static AMBA_APB_DEVICE(i2s1, "apb:i2s", 1, EP93XX_I2S_PHYS_BASE,
> > +		       { IRQ_EP93XX_SAI }, NULL);
> > +
> > +static struct map_desc bk3_io_desc[] __initdata = {
> > +	{
> > +		.virtual	= BK3_CPLDVER_VIRT_BASE,
> > +		.pfn		=
> > __phys_to_pfn(BK3_CPLDVER_PHYS_BASE),
> > +		.length	= BK3_CPLDVER_SIZE,  
> 
> same here
> 
> > +		.type		= MT_DEVICE,
> > +	}
> > +};
> > +
> > +static void __init bk3_map_io(void)
> > +{
> > +	ts72xx_common_map_io();
> > +	iotable_init(bk3_io_desc, ARRAY_SIZE(bk3_io_desc));
> > +}
> > +
> > +static void __init bk3_init_machine(void)
> > +{
> > +	ep93xx_init_devices();
> > +
> > +	ts72xx_register_flash(bk3_nand_parts,
> > ARRAY_SIZE(bk3_nand_parts),
> > +			      EP93XX_CS6_PHYS_BASE);
> > +
> > +	platform_device_register(&ts72xx_wdt_device);
> > +	ep93xx_register_eth(&ts72xx_eth_data, 1);
> > +
> > +	amba_device_register(&i2s1_device, &iomem_resource);
> > +}
> > +
> > +MACHINE_START(BK3, "Liebherr controller BK3.1")
> > +	/* Maintainer: Lukasz Majewski <lukma@denx.de> */  
> 
> Don't you want to add an entry to the MAINTAINERS file instead?
> Then get_maintainer.pl would be able to suggest your email.

Yes. This would be a good idea (I've followed the "style" of other
boards in the mach-ep93xx directory).

I will fix that ....... and send v3 with included some extra code - as
I've found and fixed several issues since last posting.

Anyway, many thanks for review. 

> 
> > +	.atag_offset	= 0x100,
> > +	.map_io	= bk3_map_io,  
> 
> again, inconsistent alignment...

Even more..... checkpatch.pl did not complained....

> 
> > +	.init_irq	= ep93xx_init_irq,
> > +	.init_time	= ep93xx_timer_init,
> > +	.init_machine	= bk3_init_machine,
> > +	.init_late	= ep93xx_init_late,
> > +	.restart	= ep93xx_restart,
> > +MACHINE_END
> > diff --git a/arch/arm/mach-ep93xx/ts72xx.h
> > b/arch/arm/mach-ep93xx/ts72xx.h index d9ff04db3221..d3165bb9ee78
> > 100644 --- a/arch/arm/mach-ep93xx/ts72xx.h
> > +++ b/arch/arm/mach-ep93xx/ts72xx.h
> > @@ -45,6 +45,11 @@
> >  #define TS72XX_WDT_CONTROL_PHYS_BASE	0x23800000
> >  #define TS72XX_WDT_FEED_PHYS_BASE	0x23c00000
> >  
> > +/* BK3 specific defines */
> > +#define BK3_CPLDVER_PHYS_BASE		0x23400000
> > +#define BK3_CPLDVER_VIRT_BASE		0xfebfd000
> > +#define BK3_CPLDVER_SIZE		0x00001000
> > +
> >  #ifndef __ASSEMBLY__
> >  
> >  static inline int ts72xx_model(void)
> > diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
> > index a9313b66f770..4eac94c1eb6f 100644
> > --- a/arch/arm/tools/mach-types
> > +++ b/arch/arm/tools/mach-types
> > @@ -345,6 +345,7 @@ mxlads
> > MACH_MXLADS		MXLADS			1851
> > linkstation_mini	MACH_LINKSTATION_MINI
> > LINKSTATION_MINI	1858 afeb9260
> > MACH_AFEB9260		AFEB9260		1859
> > imx27ipcam		MACH_IMX27IPCAM
> > IMX27IPCAM		1871 +bk3
> > MACH_BK3		BK3			1880
> > rd88f6183ap_ge		MACH_RD88F6183AP_GE
> > RD88F6183AP_GE		1894 realview_pba8
> > MACH_REALVIEW_PBA8	REALVIEW_PBA8		1897
> > realview_pbx		MACH_REALVIEW_PBX
> > REALVIEW_PBX		1901  



Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171129/1e13ddbe/attachment.sig>
