From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon,  2 May 2016 17:12:19 -0700
Subject: [PATCH 4.5 140/200] irqchip/sunxi-nmi: Fix error check of
 of_io_request_and_map()
In-Reply-To: <20160503000554.631204776@linuxfoundation.org>
References: <20160503000554.631204776@linuxfoundation.org>
Message-ID: <20160503000559.214372089@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

4.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Zapolskiy <vz@mleia.com>

commit cfe199afefe6201e998ddc07102fc1fdb55f196c upstream.

The of_io_request_and_map() returns a valid pointer in iomem region or
ERR_PTR(), check for NULL always fails and may cause a NULL pointer
dereference on error path.

Fixes: 0e841b04c829 ("irqchip/sunxi-nmi: Switch to of_io_request_and_map() from of_iomap()")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/1457486489-10189-1-git-send-email-vz at mleia.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-sunxi-nmi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -160,9 +160,9 @@ static int __init sunxi_sc_nmi_irq_init(
 
 	gc = irq_get_domain_generic_chip(domain, 0);
 	gc->reg_base = of_io_request_and_map(node, 0, of_node_full_name(node));
-	if (!gc->reg_base) {
+	if (IS_ERR(gc->reg_base)) {
 		pr_err("unable to map resource\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(gc->reg_base);
 		goto fail_irqd_remove;
 	}
 
