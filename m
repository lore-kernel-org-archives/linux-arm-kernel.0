From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 15 Mar 2012 17:56:28 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20120315175628.ca8afd4482712e1043212416@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-shmobile/setup-r8a7740.c between commit 250a27237e0e ("ARM:
shmobile: remove NR_IRQS") from the arm tree and commit d3ab7221489f
("ARM: mach-shmobile: r8a7740 map_io and init_early update") from the
arm-soc tree.

Just context changes.  I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-shmobile/setup-r8a7740.c
index fa15d81,74e5234..0000000
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@@ -25,9 -25,41 +25,42 @@@
  #include <linux/serial_sci.h>
  #include <linux/sh_timer.h>
  #include <mach/r8a7740.h>
 +#include <mach/irqs.h>
+ #include <mach/common.h>
  #include <asm/mach-types.h>
+ #include <asm/mach/map.h>
  #include <asm/mach/arch.h>
+ #include <asm/mach/time.h>
+ 
+ static struct map_desc r8a7740_io_desc[] __initdata = {
+ 	 /*
+ 	  * for CPGA/INTC/PFC
+ 	  * 0xe6000000-0xefffffff -> 0xe6000000-0xefffffff
+ 	  */
+ 	{
+ 		.virtual	= 0xe6000000,
+ 		.pfn		= __phys_to_pfn(0xe6000000),
+ 		.length		= 160 << 20,
+ 		.type		= MT_DEVICE_NONSHARED
+ 	},
+ #ifdef CONFIG_CACHE_L2X0
+ 	/*
+ 	 * for l2x0_init()
+ 	 * 0xf0100000-0xf0101000 -> 0xf0002000-0xf0003000
+ 	 */
+ 	{
+ 		.virtual	= 0xf0002000,
+ 		.pfn		= __phys_to_pfn(0xf0100000),
+ 		.length		= PAGE_SIZE,
+ 		.type		= MT_DEVICE_NONSHARED
+ 	},
+ #endif
+ };
+ 
+ void __init r8a7740_map_io(void)
+ {
+ 	iotable_init(r8a7740_io_desc, ARRAY_SIZE(r8a7740_io_desc));
+ }
  
  /* SCIFA0 */
  static struct plat_sci_port scif0_platform_data = {
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120315/d0bcf050/attachment.sig>
