From: code@mmayer.net (Markus Mayer)
Date: Mon,  2 Oct 2017 16:13:46 -0700
Subject: [PATCH 1/2] memory: brcmstb: dpfe: introduce is_dcpu_enabled()
In-Reply-To: <20171002231347.8671-1-code@mmayer.net>
References: <20171002231347.8671-1-code@mmayer.net>
Message-ID: <20171002231347.8671-2-code@mmayer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Mayer <mmayer@broadcom.com>

In order to check whether or not the DCPU is running, we introduce
a function called is_dcpu_enabled().

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 21242c4..3516ee8 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -202,17 +202,26 @@ static const u32 dpfe_commands[DPFE_CMD_MAX][MSG_FIELD_MAX] = {
 	},
 };
 
+static bool is_dcpu_enabled(void __iomem *regs)
+{
+	u32 val;
+
+	val = readl_relaxed(regs + REG_DCPU_RESET);
+
+	return !(val & DCPU_RESET_MASK);
+}
+
 static void __disable_dcpu(void __iomem *regs)
 {
 	u32 val;
 
-	/* Check if DCPU is running */
+	if (!is_dcpu_enabled(regs))
+		return;
+
+	/* Put DCPU in reset if it's running. */
 	val = readl_relaxed(regs + REG_DCPU_RESET);
-	if (!(val & DCPU_RESET_MASK)) {
-		/* Put DCPU in reset */
-		val |= (1 << DCPU_RESET_SHIFT);
-		writel_relaxed(val, regs + REG_DCPU_RESET);
-	}
+	val |= (1 << DCPU_RESET_SHIFT);
+	writel_relaxed(val, regs + REG_DCPU_RESET);
 }
 
 static void __enable_dcpu(void __iomem *regs)
-- 
2.7.4
