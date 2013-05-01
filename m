From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 1 May 2013 16:44:23 +1000
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20130501164423.1233db0b618d0e6b7184c05b@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-tegra/hotplug.c between commit da2265b130f6 ("ARM: tegra:
remove tegra specific cpu_disable()") from the arm tree and commit
7469688e832e ("ARM: tegra: Unify tegra{20,30,114}_init_early()") from the
arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-tegra/hotplug.c
index e8323bc,8da9f78..0000000
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@@ -12,8 -11,10 +11,9 @@@
  #include <linux/smp.h>
  #include <linux/clk/tegra.h>
  
 -#include <asm/cacheflush.h>
  #include <asm/smp_plat.h>
  
+ #include "fuse.h"
  #include "sleep.h"
  
  static void (*tegra_hotplug_shutdown)(void);
@@@ -46,18 -47,22 +46,13 @@@ void __ref tegra_cpu_die(unsigned int c
  	BUG();
  }
  
- #ifdef CONFIG_ARCH_TEGRA_2x_SOC
- extern void tegra20_hotplug_shutdown(void);
- void __init tegra20_hotplug_init(void)
 -int tegra_cpu_disable(unsigned int cpu)
 -{
 -	/*
 -	 * we don't allow CPU 0 to be shutdown (it is still too special
 -	 * e.g. clock tick interrupts)
 -	 */
 -	return cpu == 0 ? -EPERM : 0;
 -}
 -
+ void __init tegra_hotplug_init(void)
  {
- 	tegra_hotplug_shutdown = tegra20_hotplug_shutdown;
- }
- #endif
+ 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
+ 		return;
  
- #ifdef CONFIG_ARCH_TEGRA_3x_SOC
- extern void tegra30_hotplug_shutdown(void);
- void __init tegra30_hotplug_init(void)
- {
- 	tegra_hotplug_shutdown = tegra30_hotplug_shutdown;
+ 	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) && tegra_chip_id == TEGRA20)
+ 		tegra_hotplug_shutdown = tegra20_hotplug_shutdown;
+ 	if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) && tegra_chip_id == TEGRA30)
+ 		tegra_hotplug_shutdown = tegra30_hotplug_shutdown;
  }
- #endif
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130501/69c65567/attachment.sig>
