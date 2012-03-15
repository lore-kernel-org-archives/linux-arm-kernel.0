From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 15 Mar 2012 18:06:23 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20120315180623.ba48c5a9765ac8e4a0a17c41@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-shmobile/setup-sh7367.c between commit 250a27237e0e ("ARM:
shmobile: remove NR_IRQS") from the arm tree and commit 237caf9e6b0c
("ARM: mach-shmobile: sh7367 map_io and init_early update") from the
arm-soc tree.

Just context changes.  I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-shmobile/setup-sh7367.c
index 8e848198,a51e1a1..0000000
--- a/arch/arm/mach-shmobile/setup-sh7367.c
+++ b/arch/arm/mach-shmobile/setup-sh7367.c
@@@ -29,9 -29,28 +29,29 @@@
  #include <linux/serial_sci.h>
  #include <linux/sh_timer.h>
  #include <mach/hardware.h>
 +#include <mach/irqs.h>
+ #include <mach/common.h>
  #include <asm/mach-types.h>
  #include <asm/mach/arch.h>
+ #include <asm/mach/map.h>
+ #include <asm/mach/time.h>
+ 
+ static struct map_desc sh7367_io_desc[] __initdata = {
+ 	/* create a 1:1 entity map for 0xe6xxxxxx
+ 	 * used by CPGA, INTC and PFC.
+ 	 */
+ 	{
+ 		.virtual	= 0xe6000000,
+ 		.pfn		= __phys_to_pfn(0xe6000000),
+ 		.length		= 256 << 20,
+ 		.type		= MT_DEVICE_NONSHARED
+ 	},
+ };
+ 
+ void __init sh7367_map_io(void)
+ {
+ 	iotable_init(sh7367_io_desc, ARRAY_SIZE(sh7367_io_desc));
+ }
  
  /* SCIFA0 */
  static struct plat_sci_port scif0_platform_data = {
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120315/32f13eae/attachment-0001.sig>
