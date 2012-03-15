From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 15 Mar 2012 18:06:30 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20120315180630.61dab9c2b41da3b823c9ac94@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-shmobile/setup-sh7377.c between commit 250a27237e0e ("ARM:
shmobile: remove NR_IRQS") from the arm tree and commit bfc46f3ef838
("ARM: mach-shmobile: sh7377 map_io and init_early update") from the
arm-soc tree.

Just context changes.  I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-shmobile/setup-sh7377.c
index 747ed8e,9f14609..0000000
--- a/arch/arm/mach-shmobile/setup-sh7377.c
+++ b/arch/arm/mach-shmobile/setup-sh7377.c
@@@ -30,9 -30,28 +30,29 @@@
  #include <linux/sh_intc.h>
  #include <linux/sh_timer.h>
  #include <mach/hardware.h>
 +#include <mach/irqs.h>
+ #include <mach/common.h>
+ #include <asm/mach/map.h>
  #include <asm/mach-types.h>
  #include <asm/mach/arch.h>
+ #include <asm/mach/time.h>
+ 
+ static struct map_desc sh7377_io_desc[] __initdata = {
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
+ void __init sh7377_map_io(void)
+ {
+ 	iotable_init(sh7377_io_desc, ARRAY_SIZE(sh7377_io_desc));
+ }
  
  /* SCIFA0 */
  static struct plat_sci_port scif0_platform_data = {
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120315/7cd0236d/attachment.sig>
