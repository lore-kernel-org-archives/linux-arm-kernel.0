From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 27 Jun 2016 13:42:52 +1000
Subject: linux-next: manual merge of the devicetree tree with the arm-soc tree
Message-ID: <20160627134252.7478785f@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Today's linux-next merge of the devicetree tree got a conflict in:

  arch/arm/mach-bcm/board_bcm21664.c

between commit:

  406c8f6c9954 ("ARM: bcm21664: Remove reset code")

from the arm-soc tree and commit:

  850bea2335e4 ("arm: Remove unnecessary of_platform_populate with default match table")

from the devicetree tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm/mach-bcm/board_bcm21664.c
index 65b3db06e57a,0d7034c57334..000000000000
--- a/arch/arm/mach-bcm/board_bcm21664.c
+++ b/arch/arm/mach-bcm/board_bcm21664.c
@@@ -11,15 -11,54 +11,12 @@@
   * GNU General Public License for more details.
   */
  
- #include <linux/of_platform.h>
 -#include <linux/of_address.h>
 -#include <linux/io.h>
--
  #include <asm/mach/arch.h>
  
  #include "kona_l2_cache.h"
  
 -#define RSTMGR_DT_STRING		"brcm,bcm21664-resetmgr"
 -
 -#define RSTMGR_REG_WR_ACCESS_OFFSET	0
 -#define RSTMGR_REG_CHIP_SOFT_RST_OFFSET	4
 -
 -#define RSTMGR_WR_PASSWORD		0xa5a5
 -#define RSTMGR_WR_PASSWORD_SHIFT	8
 -#define RSTMGR_WR_ACCESS_ENABLE		1
 -
 -static void bcm21664_restart(enum reboot_mode mode, const char *cmd)
 -{
 -	void __iomem *base;
 -	struct device_node *resetmgr;
 -
 -	resetmgr = of_find_compatible_node(NULL, NULL, RSTMGR_DT_STRING);
 -	if (!resetmgr) {
 -		pr_emerg("Couldn't find " RSTMGR_DT_STRING "\n");
 -		return;
 -	}
 -	base = of_iomap(resetmgr, 0);
 -	if (!base) {
 -		pr_emerg("Couldn't map " RSTMGR_DT_STRING "\n");
 -		return;
 -	}
 -
 -	/*
 -	 * A soft reset is triggered by writing a 0 to bit 0 of the soft reset
 -	 * register. To write to that register we must first write the password
 -	 * and the enable bit in the write access enable register.
 -	 */
 -	writel((RSTMGR_WR_PASSWORD << RSTMGR_WR_PASSWORD_SHIFT) |
 -		RSTMGR_WR_ACCESS_ENABLE,
 -		base + RSTMGR_REG_WR_ACCESS_OFFSET);
 -	writel(0, base + RSTMGR_REG_CHIP_SOFT_RST_OFFSET);
 -
 -	/* Wait for reset */
 -	while (1);
 -}
 -
  static void __init bcm21664_init(void)
  {
- 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
  	kona_l2_cache_init();
  }
  
