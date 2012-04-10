From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 10 Apr 2012 10:07:33 -0700
Subject: ARM: locomo: use resource_size instead of PAGE_SIZE for ioremap
Message-ID: <201204101007.33576.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both locomo users, mach-pxa/poodle.c and mach-sa1100/collie.c, define
the memory resource for the locomo driver with a size of 0x2000 (SZ_8K).
Use resource_size() when doing the ioremap so that the correct range
is mapped.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Russell King <linux@arm.linux.org.uk> (maintainer:ARM PORT)

---

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index b55c362..e047c3d 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -391,7 +391,7 @@ __locomo_probe(struct device *me, struct resource *mem, int irq)
 	 * Map the whole region.  This also maps the
 	 * registers for our children.
 	 */
-	lchip->base = ioremap(mem->start, PAGE_SIZE);
+	lchip->base = ioremap(mem->start, resource_size(mem));
 	if (!lchip->base) {
 		ret = -ENOMEM;
 		goto out;
