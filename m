From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 16 Jan 2011 00:12:11 +0100
Subject: [PATCH] IXP4xx: Fix qmgr_release_queue() flushing unexpected queue
	entries.
In-Reply-To: <m38vylixqw.fsf@intrepid.localdomain> (Krzysztof Halasa's message
	of "Sat, 15 Jan 2011 23:54:31 +0100")
References: <m3lj2mi047.fsf@intrepid.localdomain>
	<20110115170619.GK15996@n2100.arm.linux.org.uk>
	<m38vylixqw.fsf@intrepid.localdomain>
Message-ID: <m3pqrxhid0.fsf_-_@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Queues should be empty when released, if not, there is a safety valve.
Make sure the queue is usable after it triggers.

--- a/arch/arm/mach-ixp4xx/ixp4xx_qmgr.c
+++ b/arch/arm/mach-ixp4xx/ixp4xx_qmgr.c
@@ -265,6 +265,11 @@ void qmgr_release_queue(unsigned int queue)
 	       qmgr_queue_descs[queue], queue);
 	qmgr_queue_descs[queue][0] = '\x0';
 #endif
+
+	while ((addr = qmgr_get_entry(queue)))
+		printk(KERN_ERR "qmgr: released queue %i not empty: 0x%08X\n",
+		       queue, addr);
+
 	__raw_writel(0, &qmgr_regs->sram[queue]);
 
 	used_sram_bitmap[0] &= ~mask[0];
@@ -275,10 +280,6 @@ void qmgr_release_queue(unsigned int queue)
 	spin_unlock_irq(&qmgr_lock);
 
 	module_put(THIS_MODULE);
-
-	while ((addr = qmgr_get_entry(queue)))
-		printk(KERN_ERR "qmgr: released queue %i not empty: 0x%08X\n",
-		       queue, addr);
 }
 
 static int qmgr_init(void)

-- 
Krzysztof Halasa
