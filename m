From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 24 Oct 2011 05:49:55 -0400
Subject: [PATCH 06/12] ARM: mach-h720x: move special idle code to a out-of-line
	pm_idle hook
In-Reply-To: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
References: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
Message-ID: <1319449801-12367-7-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-h720x/common.c              |   20 ++++++++++++++++++++
 arch/arm/mach-h720x/include/mach/system.h |    6 ------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-h720x/common.c b/arch/arm/mach-h720x/common.c
index 51d4e44ab9..f3bf3572a3 100644
--- a/arch/arm/mach-h720x/common.c
+++ b/arch/arm/mach-h720x/common.c
@@ -242,3 +242,23 @@ void __init h720x_map_io(void)
 {
 	iotable_init(h720x_io_desc,ARRAY_SIZE(h720x_io_desc));
 }
+
+static void h720x__idle(void)
+{
+	CPU_REG (PMU_BASE, PMU_MODE) = PMU_MODE_IDLE;
+	nop();
+	nop();
+	CPU_REG (PMU_BASE, PMU_MODE) = PMU_MODE_RUN;
+	nop();
+	nop();
+	local_irq_enable();
+}
+
+static int __init h720x__idle_init(void)
+{
+	pm_idle = h720x__idle;
+	return 0;
+}
+
+arch_initcall(h720x_idle_init);
+
diff --git a/arch/arm/mach-h720x/include/mach/system.h b/arch/arm/mach-h720x/include/mach/system.h
index a708d24ee4..65032f5c24 100644
--- a/arch/arm/mach-h720x/include/mach/system.h
+++ b/arch/arm/mach-h720x/include/mach/system.h
@@ -16,12 +16,6 @@
 
 static void arch_idle(void)
 {
-	CPU_REG (PMU_BASE, PMU_MODE) = PMU_MODE_IDLE;
-	nop();
-	nop();
-	CPU_REG (PMU_BASE, PMU_MODE) = PMU_MODE_RUN;
-	nop();
-	nop();
 }
 
 
-- 
1.7.7.1.431.g10b2a
