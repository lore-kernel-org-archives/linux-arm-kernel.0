From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 06 Sep 2016 17:37:48 +0100
Subject: [PATCH 4/8] ARM: sa1111: fix error code propagation in sa1111_probe()
In-Reply-To: <20160906163711.GB1041@n2100.armlinux.org.uk>
References: <20160906163711.GB1041@n2100.armlinux.org.uk>
Message-ID: <E1bhJNc-0008D0-CW@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that we propagate the platform_get_irq() error code out of the
probe function.  This allows probe deferrals to work correctly should
platform_get_irq() not be able to resolve the interrupt in a DT
environment at probe time.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/common/sa1111.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index fb0a0a4dfea4..332b92317fd8 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -1017,7 +1017,7 @@ static int sa1111_probe(struct platform_device *pdev)
 		return -EINVAL;
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return -ENXIO;
+		return irq;
 
 	return __sa1111_probe(&pdev->dev, mem, irq);
 }
-- 
2.1.0
