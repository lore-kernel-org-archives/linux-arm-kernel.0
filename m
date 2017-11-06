From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon,  6 Nov 2017 10:12:49 +0100
Subject: [PATCH 4.13 36/36] irqchip/irq-mvebu-gicp: Add missing spin_lock init
In-Reply-To: <20171106085047.005824077@linuxfoundation.org>
References: <20171106085047.005824077@linuxfoundation.org>
Message-ID: <20171106085048.658146684@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

4.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <antoine.tenart@free-electrons.com>

commit c9bb86338a6bb91e4d32db04feb6b8d423e04d06 upstream.

A spin lock is used in the irq-mvebu-gicp driver, but it is never
initialized. This patch adds the missing spin_lock_init() call in the
driver's probe function.

Fixes: a68a63cb4dfc ("irqchip/irq-mvebu-gicp: Add new driver for Marvell GICP")
Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: gregory.clement at free-electrons.com
Acked-by: marc.zyngier at arm.com
Cc: thomas.petazzoni at free-electrons.com
Cc: andrew at lunn.ch
Cc: jason at lakedaemon.net
Cc: nadavh at marvell.com
Cc: miquel.raynal at free-electrons.com
Cc: linux-arm-kernel at lists.infradead.org
Cc: sebastian.hesselbarth at gmail.com
Link: https://lkml.kernel.org/r/20171025072326.21030-1-antoine.tenart at free-electrons.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-mvebu-gicp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -194,6 +194,7 @@ static int mvebu_gicp_probe(struct platf
 		return -ENOMEM;
 
 	gicp->dev = &pdev->dev;
+	spin_lock_init(&gicp->spi_lock);
 
 	gicp->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!gicp->res)
