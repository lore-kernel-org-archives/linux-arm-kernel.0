From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon,  2 May 2016 17:12:27 -0700
Subject: [PATCH 4.4 119/163] irqchip/mxs: Fix error check of
 of_io_request_and_map()
In-Reply-To: <20160503000508.556845508@linuxfoundation.org>
References: <20160503000508.556845508@linuxfoundation.org>
Message-ID: <20160503000512.416870174@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Zapolskiy <vz@mleia.com>

commit edf8fcdc6b254236be005851af35ea5e826e7e09 upstream.

The of_io_request_and_map() returns a valid pointer in iomem region or
ERR_PTR(), check for NULL always fails and may cause a NULL pointer
dereference on error path.

Fixes: 25e34b44313b ("irqchip/mxs: Prepare driver for hardware with different offsets")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Oleksij Rempel <linux@rempel-privat.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/1457486500-10237-1-git-send-email-vz at mleia.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-mxs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/irqchip/irq-mxs.c
+++ b/drivers/irqchip/irq-mxs.c
@@ -183,7 +183,7 @@ static void __iomem * __init icoll_init_
 	void __iomem *icoll_base;
 
 	icoll_base = of_io_request_and_map(np, 0, np->name);
-	if (!icoll_base)
+	if (IS_ERR(icoll_base))
 		panic("%s: unable to map resource", np->full_name);
 	return icoll_base;
 }
