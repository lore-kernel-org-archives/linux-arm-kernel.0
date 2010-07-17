From: segooon@gmail.com (Kulikov Vasiliy)
Date: Sat, 17 Jul 2010 19:19:07 +0400
Subject: [PATCH 1/5] arm: mach-davinci: check irq2ctlr() result
Message-ID: <1279379947-15152-1-git-send-email-segooon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If irq2ctlr() fails return IRQ_NONE.
Also as it can fail make 'ctlr' signed.


The semantic patch that finds this problem (many false-positive results):
(http://coccinelle.lip6.fr/)

// <smpl>
@ r1 @
identifier f;
@@
int f(...) { ... }

@@
identifier r1.f;
type T;
unsigned T x;
@@

*x = f(...)
 ...
*x > 0


Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
---
 arch/arm/mach-davinci/dma.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index d33827a..d1127e1 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -344,10 +344,12 @@ static int irq2ctlr(int irq)
 static irqreturn_t dma_irq_handler(int irq, void *data)
 {
 	int i;
-	unsigned ctlr;
+	int ctlr;
 	unsigned int cnt = 0;
 
 	ctlr = irq2ctlr(irq);
+	if (ctlr < 0)
+		return IRQ_NONE;
 
 	dev_dbg(data, "dma_irq_handler\n");
 
@@ -398,10 +400,12 @@ static irqreturn_t dma_irq_handler(int irq, void *data)
 static irqreturn_t dma_ccerr_handler(int irq, void *data)
 {
 	int i;
-	unsigned ctlr;
+	int ctlr;
 	unsigned int cnt = 0;
 
 	ctlr = irq2ctlr(irq);
+	if (ctlr < 0)
+		return IRQ_NONE;
 
 	dev_dbg(data, "dma_ccerr_handler\n");
 
-- 
1.7.0.4
