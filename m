From: cavokz@gmail.com (Domenico Andreoli)
Date: Mon, 14 Mar 2011 13:46:53 +0000
Subject: [PATCH v2 1/2] CS89x0: Finish transition to CS89x0_NONISA_IRQ
References: <20110314133302.137497490@gmail.com>
Message-ID: <20110314134653.GB11935@dandreoli.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Domenico Andreoli <cavokz@gmail.com>

CS89x0_NONISA_IRQ is selected by all those non-ISA boards which use
CS89x0. This patch only cleans the last bits left after its introduction.

Signed-off-by: Domenico Andreoli <cavokz@gmail.com>

Index: arm-2.6.git/drivers/net/cs89x0.c
===================================================================
--- arm-2.6.git.orig/drivers/net/cs89x0.c	2011-03-14 11:29:35.000000000 +0000
+++ arm-2.6.git/drivers/net/cs89x0.c	2011-03-14 11:35:11.000000000 +0000
@@ -943,10 +943,10 @@
 static void __init reset_chip(struct net_device *dev)
 {
 #if !defined(CONFIG_MACH_MX31ADS)
-#if !defined(CONFIG_MACH_IXDP2351) && !defined(CONFIG_ARCH_IXDP2X01)
+#if !defined(CS89x0_NONISA_IRQ)
 	struct net_local *lp = netdev_priv(dev);
 	int ioaddr = dev->base_addr;
-#endif
+#endif /* CS89x0_NONISA_IRQ */
 	int reset_start_time;
 
 	writereg(dev, PP_SelfCTL, readreg(dev, PP_SelfCTL) | POWER_ON_RESET);
@@ -954,7 +954,7 @@
 	/* wait 30 ms */
 	msleep(30);
 
-#if !defined(CONFIG_MACH_IXDP2351) && !defined(CONFIG_ARCH_IXDP2X01)
+#if !defined(CS89x0_NONISA_IRQ)
 	if (lp->chip_type != CS8900) {
 		/* Hardware problem requires PNP registers to be reconfigured after a reset */
 		writeword(ioaddr, ADD_PORT, PP_CS8920_ISAINT);
@@ -965,7 +965,7 @@
 		outb((dev->mem_start >> 16) & 0xff, ioaddr + DATA_PORT);
 		outb((dev->mem_start >> 8) & 0xff,   ioaddr + DATA_PORT + 1);
 	}
-#endif	/* IXDP2x01 */
+#endif /* CS89x0_NONISA_IRQ */
 
 	/* Wait until the chip is reset */
 	reset_start_time = jiffies;
