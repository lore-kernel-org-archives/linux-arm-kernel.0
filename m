From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 7 Feb 2013 15:44:57 +1100
Subject: linux-next: manual merge of the arm-soc tree with the iommu tree
Message-ID: <20130207154457.942992d85ab7ab5834067f7e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-shmobile/setup-r8a7740.c between commit f671e0224a7f ("ARM:
mach-shmobile: r8a7740: Add IPMMU device") from the iommu tree and
commits f977ec94f7f2 ("ARM: shmobile: Remove duplicate inclusion of
dma-mapping.h in setup-r8a7740.c") and e67d7afc5674 ("ARM: shmobile:
r8a7740: add TMU timer support") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-shmobile/setup-r8a7740.c
index b85bea5,30ac79c..0000000
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@@ -27,8 -27,6 +27,7 @@@
  #include <linux/serial_sci.h>
  #include <linux/sh_dma.h>
  #include <linux/sh_timer.h>
- #include <linux/dma-mapping.h>
 +#include <linux/platform_data/sh_ipmmu.h>
  #include <mach/dma-register.h>
  #include <mach/r8a7740.h>
  #include <mach/pm-rmobile.h>
@@@ -263,37 -287,97 +288,128 @@@ static struct platform_device cmt10_dev
  	.num_resources	= ARRAY_SIZE(cmt10_resources),
  };
  
 +/* IPMMUI (an IPMMU module for ICB/LMB) */
 +static struct resource ipmmu_resources[] = {
 +	[0] = {
 +		.name	= "IPMMUI",
 +		.start	= 0xfe951000,
 +		.end	= 0xfe9510ff,
 +		.flags	= IORESOURCE_MEM,
 +	},
 +};
 +
 +static const char * const ipmmu_dev_names[] = {
 +	"sh_mobile_lcdc_fb.0",
 +	"sh_mobile_lcdc_fb.1",
 +	"sh_mobile_ceu.0",
 +};
 +
 +static struct shmobile_ipmmu_platform_data ipmmu_platform_data = {
 +	.dev_names = ipmmu_dev_names,
 +	.num_dev_names = ARRAY_SIZE(ipmmu_dev_names),
 +};
 +
 +static struct platform_device ipmmu_device = {
 +	.name           = "ipmmu",
 +	.id             = -1,
 +	.dev = {
 +		.platform_data = &ipmmu_platform_data,
 +	},
 +	.resource       = ipmmu_resources,
 +	.num_resources  = ARRAY_SIZE(ipmmu_resources),
 +};
 +
+ /* TMU */
+ static struct sh_timer_config tmu00_platform_data = {
+ 	.name = "TMU00",
+ 	.channel_offset = 0x4,
+ 	.timer_bit = 0,
+ 	.clockevent_rating = 200,
+ };
+ 
+ static struct resource tmu00_resources[] = {
+ 	[0] = {
+ 		.name	= "TMU00",
+ 		.start	= 0xfff80008,
+ 		.end	= 0xfff80014 - 1,
+ 		.flags	= IORESOURCE_MEM,
+ 	},
+ 	[1] = {
+ 		.start	= intcs_evt2irq(0xe80),
+ 		.flags	= IORESOURCE_IRQ,
+ 	},
+ };
+ 
+ static struct platform_device tmu00_device = {
+ 	.name		= "sh_tmu",
+ 	.id		= 0,
+ 	.dev = {
+ 		.platform_data	= &tmu00_platform_data,
+ 	},
+ 	.resource	= tmu00_resources,
+ 	.num_resources	= ARRAY_SIZE(tmu00_resources),
+ };
+ 
+ static struct sh_timer_config tmu01_platform_data = {
+ 	.name = "TMU01",
+ 	.channel_offset = 0x10,
+ 	.timer_bit = 1,
+ 	.clocksource_rating = 200,
+ };
+ 
+ static struct resource tmu01_resources[] = {
+ 	[0] = {
+ 		.name	= "TMU01",
+ 		.start	= 0xfff80014,
+ 		.end	= 0xfff80020 - 1,
+ 		.flags	= IORESOURCE_MEM,
+ 	},
+ 	[1] = {
+ 		.start	= intcs_evt2irq(0xea0),
+ 		.flags	= IORESOURCE_IRQ,
+ 	},
+ };
+ 
+ static struct platform_device tmu01_device = {
+ 	.name		= "sh_tmu",
+ 	.id		= 1,
+ 	.dev = {
+ 		.platform_data	= &tmu01_platform_data,
+ 	},
+ 	.resource	= tmu01_resources,
+ 	.num_resources	= ARRAY_SIZE(tmu01_resources),
+ };
+ 
+ static struct sh_timer_config tmu02_platform_data = {
+ 	.name = "TMU02",
+ 	.channel_offset = 0x1C,
+ 	.timer_bit = 2,
+ 	.clocksource_rating = 200,
+ };
+ 
+ static struct resource tmu02_resources[] = {
+ 	[0] = {
+ 		.name	= "TMU02",
+ 		.start	= 0xfff80020,
+ 		.end	= 0xfff8002C - 1,
+ 		.flags	= IORESOURCE_MEM,
+ 	},
+ 	[1] = {
+ 		.start	= intcs_evt2irq(0xec0),
+ 		.flags	= IORESOURCE_IRQ,
+ 	},
+ };
+ 
+ static struct platform_device tmu02_device = {
+ 	.name		= "sh_tmu",
+ 	.id		= 2,
+ 	.dev = {
+ 		.platform_data	= &tmu02_platform_data,
+ 	},
+ 	.resource	= tmu02_resources,
+ 	.num_resources	= ARRAY_SIZE(tmu02_resources),
+ };
+ 
  static struct platform_device *r8a7740_early_devices[] __initdata = {
  	&scif0_device,
  	&scif1_device,
@@@ -305,7 -389,9 +421,10 @@@
  	&scif7_device,
  	&scifb_device,
  	&cmt10_device,
 +	&ipmmu_device,
+ 	&tmu00_device,
+ 	&tmu01_device,
+ 	&tmu02_device,
  };
  
  /* DMA */
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130207/a6cf6b8a/attachment.sig>
