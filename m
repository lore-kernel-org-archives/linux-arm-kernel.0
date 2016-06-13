From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Sun, 12 Jun 2016 22:55:29 -0700
Subject: [PATCH 3/3] i.MX: system.c: Replace magic numbers
In-Reply-To: <1465797329-22537-1-git-send-email-andrew.smirnov@gmail.com>
References: <1465797329-22537-1-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <1465797329-22537-3-git-send-email-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

RESEND, now with Russell King on CC list.

 arch/arm/include/asm/hardware/cache-l2x0.h | 7 +++++++
 arch/arm/mach-imx/system.c                 | 5 ++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 3a5ec1c..5e27162 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -61,6 +61,13 @@
 #define L2X0_LINE_TAG			0xF30
 #define L2X0_DEBUG_CTRL			0xF40
 #define L310_PREFETCH_CTRL		0xF60
+#define   L310_DOUBLE_LINEFILL_EN			BIT(30)
+#define   L310_INSTRUCTION_PREFETCH_EN			BIT(29)
+#define   L310_DATA_PREFETCH_EN				BIT(28)
+#define   L310_DOUBLE_LINEFILL_ON_WRAP_READ_DIS		BIT(27)
+#define   L310_PREFETCH_DROP_EN				BIT(24)
+#define   L310_INCR_DOUBLE_LINEFILL_EN			BIT(23)
+#define   L310_ESCLUSIVE_SEQUENCE_EN			BIT(21)
 #define L310_POWER_CTRL			0xF80
 #define   L310_DYNAMIC_CLK_GATING_EN	(1 << 1)
 #define   L310_STNDBY_MODE_EN		(1 << 0)
diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index b153376..bd9a96b 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -109,7 +109,10 @@ void __init imx_init_l2cache(void)
 	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & L2X0_CTRL_EN)) {
 		/* Configure the L2 PREFETCH and POWER registers */
 		val = readl_relaxed(l2x0_base + L310_PREFETCH_CTRL);
-		val |= 0x70800000;
+		val |=  L310_DOUBLE_LINEFILL_EN |
+		        L310_INSTRUCTION_PREFETCH_EN |
+			L310_DATA_PREFETCH_EN |
+			L310_INCR_DOUBLE_LINEFILL_EN;
 		writel_relaxed(val, l2x0_base + L310_PREFETCH_CTRL);
 	}
 
-- 
2.5.5
