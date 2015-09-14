From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 14 Sep 2015 14:47:44 +0800
Subject: [PATCH RESEND 1/2] arm: berlin: use non-self-cleared reset register
 to reset cpu
In-Reply-To: <1442213265-1002-1-git-send-email-jszhang@marvell.com>
References: <1442213265-1002-1-git-send-email-jszhang@marvell.com>
Message-ID: <1442213265-1002-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Berlin SoCs, there are two kinds of cpu reset control registers: the
first one's corresponding bits will be self-cleared after some cycles,
while the second one's bits won't. Previously the first kind of reset
control register is used, this patch uses the second kind one to prepare
for the next hotplug commit.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/mach-berlin/platsmp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-berlin/platsmp.c b/arch/arm/mach-berlin/platsmp.c
index 34a3753..bde327b 100644
--- a/arch/arm/mach-berlin/platsmp.c
+++ b/arch/arm/mach-berlin/platsmp.c
@@ -17,7 +17,7 @@
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 
-#define CPU_RESET		0x00
+#define CPU_RESET		0x20
 
 #define RESET_VECT		0x00
 #define SW_RESET_ADDR		0x94
@@ -31,6 +31,8 @@ static inline void berlin_perform_reset_cpu(unsigned int cpu)
 	u32 val;
 
 	val = readl(cpu_ctrl + CPU_RESET);
+	val &= ~BIT(cpu_logical_map(cpu));
+	writel(val, cpu_ctrl + CPU_RESET);
 	val |= BIT(cpu_logical_map(cpu));
 	writel(val, cpu_ctrl + CPU_RESET);
 }
-- 
2.5.1
