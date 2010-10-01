From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:39 -0700
Subject: [PATCH 15/47] arm: mach-davinci: check irq2ctlr() result
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-16-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kulikov Vasiliy <segooon@gmail.com>

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
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/dma.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index 2ede598..6b96698 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -354,10 +354,12 @@ static int irq2ctlr(int irq)
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
 
@@ -408,10 +410,12 @@ static irqreturn_t dma_irq_handler(int irq, void *data)
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
1.7.2.1
