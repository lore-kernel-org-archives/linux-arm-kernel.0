From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue,  7 Jun 2016 15:05:37 +0100
Subject: [PATCH] clk: ti: fapll: fix address space warnings
Message-ID: <1465308337-18047-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following warnings from casting "void __iomem *" pointers
to u32 when using sparse:

drivers/clk/ti/fapll.c:583:13: warning: cast removes address space of expression
drivers/clk/ti/fapll.c:623:21: warning: cast removes address space of expression

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-omap at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-clk at vger.kernel.org
---
 drivers/clk/ti/fapll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index 66a0d0e..d765f4a 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -43,14 +43,14 @@
 #define to_synth(_hw)		container_of(_hw, struct fapll_synth, hw)
 
 /* The bypass bit is inverted on the ddr_pll.. */
-#define fapll_is_ddr_pll(va)	(((u32)(va) & 0xffff) == 0x0440)
+#define fapll_is_ddr_pll(va)	(((u32 __force)(va) & 0xffff) == 0x0440)
 
 /*
  * The audio_pll_clk1 input is hard wired to the 27MHz bypass clock,
  * and the audio_pll_clk1 synthesizer is hardwared to 32KiHz output.
  */
-#define is_ddr_pll_clk1(va)	(((u32)(va) & 0xffff) == 0x044c)
-#define is_audio_pll_clk1(va)	(((u32)(va) & 0xffff) == 0x04a8)
+#define is_ddr_pll_clk1(va)	(((u32 __force)(va) & 0xffff) == 0x044c)
+#define is_audio_pll_clk1(va)	(((u32 __force)(va) & 0xffff) == 0x04a8)
 
 /* Synthesizer divider register */
 #define SYNTH_LDMDIV1		BIT(8)
-- 
2.8.1
