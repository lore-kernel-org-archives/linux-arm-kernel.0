From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 26 Sep 2016 09:21:51 +0200
Subject: [PATCH] ARM: pxa: fix pxa25x interrupt init
Message-ID: <1474874511-26617-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the device-tree case, the root interrupt controller cannot be
accessed through the 6th coprocessor, contrary to pxa27x and pxa3xx
architectures.

Fix it to behave as in non-devicetree builds.

Fixes: 32f17997c130 ("ARM: pxa: remove irq init from dt machines")
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/pxa25x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 12b94357fbc1..c725baf119e1 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -156,7 +156,7 @@ static int __init __init
 pxa25x_dt_init_irq(struct device_node *node, struct device_node *parent)
 {
 	pxa_dt_irq_init(pxa25x_set_wake);
-	set_handle_irq(ichp_handle_irq);
+	set_handle_irq(icip_handle_irq);
 
 	return 0;
 }
-- 
2.1.4
