From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 7 Jul 2015 15:10:34 +0800
Subject: [PATCH 1/2] arm: berlin: use non-self-cleared reset register to reset
 cpu
In-Reply-To: <1436253035-371-1-git-send-email-jszhang@marvell.com>
References: <1436253035-371-1-git-send-email-jszhang@marvell.com>
Message-ID: <1436253035-371-2-git-send-email-jszhang@marvell.com>
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
2.1.4
