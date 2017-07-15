From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 15 Jul 2017 22:07:45 +0200
Subject: [PATCH 10/11] irqchip: digicolor: Drop unnecessary static
In-Reply-To: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1500149266-32357-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1500149266-32357-11-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop static on a local variable, when the variable is initialized before
any possible use.  Thus, the static has no benefit.

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@bad exists@
position p;
identifier x;
type T;
@@
static T x at p;
...
x = <+...x...+>

@@
identifier x;
expression e;
type T;
position p != bad.p;
@@
-static
 T x at p;
 ... when != x
     when strict
?x = e;
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
These patches are all independent of each other.

 drivers/irqchip/irq-digicolor.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/drivers/irqchip/irq-digicolor.c b/drivers/irqchip/irq-digicolor.c
--- a/drivers/irqchip/irq-digicolor.c
+++ b/drivers/irqchip/irq-digicolor.c
@@ -71,7 +71,7 @@ static void __init digicolor_set_gc(void
 static int __init digicolor_of_init(struct device_node *node,
 				struct device_node *parent)
 {
-	static void __iomem *reg_base;
+	void __iomem *reg_base;
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	struct regmap *ucregs;
 	int ret;
