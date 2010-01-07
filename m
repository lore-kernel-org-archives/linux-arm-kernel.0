From: tony@atomide.com (Tony Lindgren)
Date: Wed, 06 Jan 2010 16:20:43 -0800
Subject: [PATCH 11/12] omap3: Fix booting if package is uninitialized
In-Reply-To: <20100107001728.21352.38471.stgit@baageli.muru.com>
References: <20100107001728.21352.38471.stgit@baageli.muru.com>
Message-ID: <20100107002043.21352.9923.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise bringing up new boards can be harder:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1]
last sysfs file:
Modules linked in:
CPU: 0    Not tainted  (2.6.33-rc2-00015-g0bc9c93-dirty #37)
PC is at omap_mux_init+0xa4/0x3d8
LR is at omap_mux_init+0x3c/0x3d8
...

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index e071b3f..459ef23 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -994,8 +994,10 @@ int __init omap_mux_init(u32 mux_pbase, u32 mux_size,
 	}
 
 #ifdef CONFIG_OMAP_MUX
-	omap_mux_package_fixup(package_subset, superset);
-	omap_mux_package_init_balls(package_balls, superset);
+	if (package_subset)
+		omap_mux_package_fixup(package_subset, superset);
+	if (package_balls)
+		omap_mux_package_init_balls(package_balls, superset);
 	omap_mux_set_cmdline_signals();
 	omap_mux_set_board_signals(board_mux);
 #endif
