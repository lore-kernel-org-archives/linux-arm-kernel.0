From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun,  4 Sep 2016 20:59:47 +0200
Subject: [PATCH 3/3] [DO_NOT_REVIEW] sa1111: left up to Russell King
In-Reply-To: <1473015587-15589-1-git-send-email-robert.jarzmik@free.fr>
References: <1473015587-15589-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1473015587-15589-3-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to be able to cope with ordering problems, especially when the
interrupt descriptor is allocated only after the sa1111 is probed, add a
workaround to "wait" for the interrupt chip to be available.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/common/sa1111.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 1b03ff639836..abd94ff83a6c 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
+#include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -1183,6 +1184,9 @@ static int sa1111_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	if (!irq_get_chip(irq))
+		return -EPROBE_DEFER;
+
 	return __sa1111_probe(&pdev->dev, mem, irq);
 }
 
-- 
2.1.4
