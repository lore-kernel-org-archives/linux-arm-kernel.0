From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  2 Oct 2015 16:44:05 +0100
Subject: [PATCH 1/2] irqchip/gic-v3-its: Silence warning when
 its_lpi_alloc_chunks gets inlined
In-Reply-To: <1443800646-8074-1-git-send-email-marc.zyngier@arm.com>
References: <1443800646-8074-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1443800646-8074-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

More agressive inlining in recent versions of GCC have uncovered
a new set of warnings:

	drivers/irqchip/irq-gic-v3-its.c: In function its_msi_prepare:
	drivers/irqchip/irq-gic-v3-its.c:1148:26: warning: lpi_base may be used
	uninitialized in this function [-Wmaybe-uninitialized]
	  dev->event_map.lpi_base = lpi_base;
                          ^
	drivers/irqchip/irq-gic-v3-its.c:1116:6: note: lpi_base was declared here
	  int lpi_base;
	      ^
	drivers/irqchip/irq-gic-v3-its.c:1149:25: warning: nr_lpis may be used
	uninitialized in this function [-Wmaybe-uninitialized]
	  dev->event_map.nr_lpis = nr_lpis;
	                         ^
	drivers/irqchip/irq-gic-v3-its.c:1117:6: note: nr_lpis was declared here
	  int nr_lpis;
	      ^
The warning is fairly benign (there is no code path that could
actually use uninitialized vatiables), but let's silence it anyway
by zeroing the variables on the error path.

Reported-by: Alex Shi <alex.shi@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ac7ae2b..25ceae9f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -719,6 +719,9 @@ static unsigned long *its_lpi_alloc_chunks(int nr_irqs, int *base, int *nr_ids)
 out:
 	spin_unlock(&lpi_lock);
 
+	if (!bitmap)
+		*base = *nr_ids = 0;
+
 	return bitmap;
 }
 
-- 
2.1.4
