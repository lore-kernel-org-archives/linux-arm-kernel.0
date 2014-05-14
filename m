From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 14 May 2014 17:50:40 +0200
Subject: [RFC PATCHv1 6/7] ARM: mvebu: define the Armada 370/375/38x/XP
 machine_desc flags
In-Reply-To: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1400082641-23871-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 is a purely non-SMP processor, so it does not need the
MACHINE_NEEDS_SHAREABLE_PAGES flag, and more importantly this flag
cannot be set with this CPU core.

For all other processors, they are SMP-capable, but have cut-down
variants that only have one core. And for these variants, we need both
the cache policy to be write-allocate, and the shareable attribute to
be set on page tables in order for I/O coherency to work properly.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 8b4b44b..d1f348e 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -186,6 +186,7 @@ DT_MACHINE_START(ARMADA_370_DT, "Marvell Armada 370 (Device Tree)")
 	.init_time	= mvebu_timer_and_clk_init,
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_370_dt_compat,
+	.flags          = MACHINE_NEEDS_CPOLICY_WRITEALLOC,
 MACHINE_END
 
 static const char * const armada_xp_dt_compat[] = {
@@ -198,6 +199,8 @@ DT_MACHINE_START(ARMADA_XP_DT, "Marvell Armada XP (Device Tree)")
 	.init_time	= mvebu_timer_and_clk_init,
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_xp_dt_compat,
+	.flags          = (MACHINE_NEEDS_CPOLICY_WRITEALLOC |
+			   MACHINE_NEEDS_SHAREABLE_PAGES),
 MACHINE_END
 
 static const char * const armada_375_dt_compat[] = {
@@ -210,6 +213,8 @@ DT_MACHINE_START(ARMADA_375_DT, "Marvell Armada 375 (Device Tree)")
 	.init_machine	= mvebu_dt_init,
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_375_dt_compat,
+	.flags          = (MACHINE_NEEDS_CPOLICY_WRITEALLOC |
+			   MACHINE_NEEDS_SHAREABLE_PAGES),
 MACHINE_END
 
 static const char * const armada_38x_dt_compat[] = {
@@ -222,4 +227,6 @@ DT_MACHINE_START(ARMADA_38X_DT, "Marvell Armada 380/385 (Device Tree)")
 	.init_time	= mvebu_timer_and_clk_init,
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_38x_dt_compat,
+	.flags          = (MACHINE_NEEDS_CPOLICY_WRITEALLOC |
+			   MACHINE_NEEDS_SHAREABLE_PAGES),
 MACHINE_END
-- 
1.9.3
