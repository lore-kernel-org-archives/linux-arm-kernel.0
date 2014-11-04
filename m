From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:49:56 +0900
Subject: [PATCH 08/11] ARM: shmobile: r8a7740: Add D4 pm domain support
In-Reply-To: <cover.1415058794.git.horms+renesas@verge.net.au>
References: <cover.1415058794.git.horms+renesas@verge.net.au>
Message-ID: <7e81f5434db5bbef3ac55d3f44f702566c0323c6.1415058794.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add support for the D4 power domain.
This domain contains the Coresight-ETM hardware block.

As long as the ARM debug/perf code doesn't use resource management with
runtime PM support, the D4 power domain must be kept powered to avoid a
crash during resume from s2ram (dbg_cpu_pm_notify() calls
reset_ctrl_regs() unconditionally, causing an undefined instruction
oops).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-r8a7740.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 081a4f9..8b1af2a 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -32,6 +32,16 @@ static int r8a7740_pd_a3sp_suspend(void)
 	return console_suspend_enabled ? 0 : -EBUSY;
 }
 
+static int r8a7740_pd_d4_suspend(void)
+{
+	/*
+	 * The D4 domain contains the Coresight-ETM hardware block and
+	 * therefore it should only be turned off if the debug module is
+	 * not in use.
+	 */
+	return -EBUSY;
+}
+
 static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 	{
 		.genpd.name	= "A4LC",
@@ -40,6 +50,11 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
 		.genpd.name	= "A4MP",
 		.bit_shift	= 2,
 	}, {
+		.genpd.name	= "D4",
+		.bit_shift	= 3,
+		.gov		= &pm_domain_always_on_gov,
+		.suspend	= r8a7740_pd_d4_suspend,
+	}, {
 		.genpd.name	= "A3RV",
 		.bit_shift	= 6,
 	}, {
-- 
2.1.1
