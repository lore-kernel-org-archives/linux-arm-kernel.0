From: tony@atomide.com (Tony Lindgren)
Date: Thu, 24 Sep 2009 16:39:21 -0700
Subject: [PATCH 06/12] omap: mailbox: Flush posted write when acking mailbox
	irq
In-Reply-To: <20090924233027.6065.95725.stgit@localhost>
References: <20090924233027.6065.95725.stgit@localhost>
Message-ID: <20090924233920.6065.16789.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

The only way to flush posted write to L4 bus is to do a read back
of the same register right after the write.

This seems to be mostly needed in interrupt handlers to avoid
causing spurious interrupts.

The earlier fix has been to mark the L4 bus as strongly ordered
memory, which solves the problem, but causes performance penalties.

Similar to the fix, 03803a71041e3bc3c077f4e7b92f6ceaa9426df3

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mailbox.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 5bf9a2f..f3fefca 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -176,6 +176,9 @@ static void omap2_mbox_ack_irq(struct omap_mbox *mbox,
 	u32 bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
 
 	mbox_write_reg(bit, p->irqstatus);
+
+	/* Flush posted write for irq status to avoid spurious interrupts */
+	mbox_read_reg(p->irqstatus);
 }
 
 static int omap2_mbox_is_irq(struct omap_mbox *mbox,
