From: p.fedin@samsung.com (Pavel Fedin)
Date: Wed, 01 Jul 2015 16:36:22 +0300
Subject: [PATCH 4/4] irqchip, gicv3-its: Implement Cavium ThunderX errata
 22375, 24313
In-Reply-To: <1435673643-31676-5-git-send-email-rric@kernel.org>
References: <1435673643-31676-1-git-send-email-rric@kernel.org>
 <1435673643-31676-5-git-send-email-rric@kernel.org>
Message-ID: <023101d0b402$eba41e00$c2ec5a00$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> This implements two gicv3-its errata for ThunderX. Both with small
> impact affecting only ITS table allocation.
> 
>  erratum 22375: only alloc 8MB table size

 I have a simpler solution to this one:
---
For some reason on ThunderX GITS_BASER reports entry size == 8 for ITT,
while real size, reported by GITS_TYPER is 4. Consequently, allocated
table size appears twice bigger than expected. And, if we set
GITS_BASER.SIZE accordingly (the value appears to be 0xFF instead of 0x7F)
the ITS will not work.

Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 3 ++-
 include/linux/irqchip/arm-gic-v3.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ed70163..c420f17 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -827,6 +827,7 @@ static int its_alloc_tables(struct its_node *its)
 		if (type == GITS_BASER_TYPE_DEVICE) {
 			u64 typer = readq_relaxed(its->base + GITS_TYPER);
 			u32 ids = GITS_TYPER_DEVBITS(typer);
+			u32 itte_size = GITS_TYPER_ITTE_SIZE(typer);
 
 			/*
 			 * 'order' was initialized earlier to the default page
@@ -834,7 +835,7 @@ static int its_alloc_tables(struct its_node *its)
 			 * smaller than that.  If the requested allocation
 			 * is smaller, round up to the default page granule.
 			 */
-			order = max(get_order((1UL << ids) * entry_size),
+			order = max(get_order((1UL << ids) * itte_size),
 				    order);
 			if (order >= MAX_ORDER) {
 				order = MAX_ORDER - 1;
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index ffbc034..7f515e6 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -184,6 +184,8 @@
 #define GITS_CTLR_ENABLE		(1U << 0)
 #define GITS_CTLR_QUIESCENT		(1U << 31)
 
+#define GITS_TYPER_ITTE_SIZE_SHIFT	4
+#define GITS_TYPER_ITTE_SIZE(r)		((((r) >> GITS_TYPER_ITTE_SIZE_SHIFT) & 0xf) + 1)
 #define GITS_TYPER_DEVBITS_SHIFT	13
 #define GITS_TYPER_DEVBITS(r)		((((r) >> GITS_TYPER_DEVBITS_SHIFT) & 0x1f) + 1)
 #define GITS_TYPER_PTA			(1UL << 19)
-- 
2.4.4


Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
