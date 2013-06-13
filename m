From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 13 Jun 2013 17:36:51 -0400
Subject: [GIT PULL 3/3] ARM: mvebu: register map changes for v3.11
In-Reply-To: <20130613212137.GE31667@titan.lakedaemon.net>
References: <20130613212137.GE31667@titan.lakedaemon.net>
Message-ID: <20130613213651.GG31667@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This branch is off by itself because it depends on mvebu/cleanup and
mvebu/fixes-non-critical.  It's been in linux-next about a week and has
an squirrelly merge conflict with armada-370-xp.c.  I've attached the
resolution to the bottom of this email.

If you have any questions or if there is a better way for me to format
this, please let me know.

thx,

Jason.


The following changes since commit fdc0b43fbb0e0958f13d3453dfb9df707c0af904:

  Merge tag 'tags/cleanup-3.11-3' into mvebu/regmap (2013-06-13 17:47:57 +0000)

are available in the git repository at:


  git://git.infradead.org/users/jcooper/linux.git tags/regmap-3.11

for you to fetch changes up to 5fb2038d61ce94e7c9224db2aaff5633ca224953:

  arm: mvebu: disable DEBUG_LL/EARLY_PRINTK in defconfig (2013-06-13 17:48:59 +0000)

----------------------------------------------------------------
mvebu register map changes for v3.11

This series removes the hardcoded register base address for mvebu.

Depends:
 - mvebu/fixes-non-critical (up to tags/fixes-non-3.11-1)
 - mvebu/cleanup (up to tags/cleanup-3.11-3)

----------------------------------------------------------------
Thomas Petazzoni (8):
      arm: mvebu: remove dependency of SMP init on static I/O mapping
      arm: mvebu: avoid hardcoded virtual address in coherency code
      arm: mvebu: move cache and mvebu-mbus initialization later
      arm: mvebu: remove hardcoded static I/O mapping
      arm: mvebu: don't hardcode a physical address in headsmp.S
      arm: mvebu: don't hardcode the physical address for mvebu-mbus
      arm: mvebu: add another earlyprintk Kconfig option
      arm: mvebu: disable DEBUG_LL/EARLY_PRINTK in defconfig

 arch/arm/Kconfig.debug              | 30 ++++++++++++++++++++--
 arch/arm/configs/mvebu_defconfig    |  2 --
 arch/arm/include/debug/mvebu.S      |  5 ++++
 arch/arm/mach-mvebu/armada-370-xp.c | 51 ++++++++++++++++++++-----------------
 arch/arm/mach-mvebu/armada-370-xp.h | 10 --------
 arch/arm/mach-mvebu/coherency.c     | 44 ++++++++++++++++----------------
 arch/arm/mach-mvebu/coherency.h     |  4 ---
 arch/arm/mach-mvebu/common.h        |  2 ++
 arch/arm/mach-mvebu/headsmp.S       | 16 ++++++------
 arch/arm/mach-mvebu/platsmp.c       | 10 +++++++-
 10 files changed, 101 insertions(+), 73 deletions(-)

---->8------
commit 50531ed35f3951a5e0d5d6c4ea31b603d3852061
Merge: 81edb26 5fb2038
Author: Jason Cooper <jason@lakedaemon.net>
Date:   Thu Jun 13 18:04:40 2013 +0000

    Merge branch 'mvebu/regmap' into for-next
    
    Conflicts:
    	arch/arm/mach-mvebu/armada-370-xp.c

diff --cc arch/arm/mach-mvebu/armada-370-xp.c
index 8721e2d,0dbc370..97cbb80
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@@ -14,7 -14,7 +14,8 @@@
  
  #include <linux/kernel.h>
  #include <linux/init.h>
 +#include <linux/clk-provider.h>
+ #include <linux/of_address.h>
  #include <linux/of_platform.h>
  #include <linux/io.h>
  #include <linux/time-armada-370-xp.h>
@@@ -61,12 -56,22 +56,22 @@@ static void __init armada_370_xp_mbus_i
  	else
  		mbus_soc_name = "marvell,armadaxp-mbus";
  
+ 	dn = of_find_node_by_name(NULL, "internal-regs");
+ 	BUG_ON(!dn);
+ 
  	mvebu_mbus_init(mbus_soc_name,
- 			ARMADA_370_XP_MBUS_WINS_BASE,
+ 			of_translate_address(dn, &mbus_wins_offs),
  			ARMADA_370_XP_MBUS_WINS_SIZE,
- 			ARMADA_370_XP_SDRAM_WINS_BASE,
+ 			of_translate_address(dn, &sdram_wins_offs),
  			ARMADA_370_XP_SDRAM_WINS_SIZE);
+ }
  
+ static void __init armada_370_xp_timer_and_clk_init(void)
+ {
 -	mvebu_clocks_init();
++	of_clk_init(NULL);
+ 	armada_370_xp_timer_init();
+ 	coherency_init();
+ 	armada_370_xp_mbus_init();
  #ifdef CONFIG_CACHE_L2X0
  	l2x0_of_init(0, ~0UL);
  #endif
