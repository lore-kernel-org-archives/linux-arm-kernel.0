From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 20 Jun 2011 15:26:12 -0700
Subject: [PATCH] locomo: use resource_size instead of PAGE_SIZE for ioremap
Message-ID: <201106201526.12796.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memory resource for the locomo device is properly initialized
by both users (mach-pxa/poodle.c and mach-sa1100/collie.c).  Use
resource_size in the ioremap instead of assuming the resource size
is PAGE_SIZE.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

--

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
