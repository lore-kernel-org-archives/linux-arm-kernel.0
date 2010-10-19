From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 19 Oct 2010 16:39:06 +0200
Subject: [PATCH 11/12] ARM: ixp4xx: Convert pci_lock to raw_spinlock
In-Reply-To: <20101019143717.GH11713@pengutronix.de>
References: <20101019143717.GH11713@pengutronix.de>
Message-ID: <1287499147-13846-11-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Gleixner <tglx@linutronix.de>

ixp4xx_pci_lock needs to be a real spinlock on preempt-rt. Convert it
to a raw_spinlock. No change for !RT kernels.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-ixp4xx/common-pci.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index 24498a9..90a7d68 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -54,7 +54,7 @@ unsigned long ixp4xx_pci_reg_base = 0;
  * these transactions are atomic or we will end up
  * with corrupt data on the bus or in a driver.
  */
-static DEFINE_SPINLOCK(ixp4xx_pci_lock);
+static DEFINE_RAW_SPINLOCK(ixp4xx_pci_lock);
 
 /*
  * Read from PCI config space
@@ -62,10 +62,10 @@ static DEFINE_SPINLOCK(ixp4xx_pci_lock);
 static void crp_read(u32 ad_cbe, u32 *data)
 {
 	unsigned long flags;
-	spin_lock_irqsave(&ixp4xx_pci_lock, flags);
+	raw_spin_lock_irqsave(&ixp4xx_pci_lock, flags);
 	*PCI_CRP_AD_CBE = ad_cbe;
 	*data = *PCI_CRP_RDATA;
-	spin_unlock_irqrestore(&ixp4xx_pci_lock, flags);
+	raw_spin_unlock_irqrestore(&ixp4xx_pci_lock, flags);
 }
 
 /*
@@ -74,10 +74,10 @@ static void crp_read(u32 ad_cbe, u32 *data)
 static void crp_write(u32 ad_cbe, u32 data)
 { 
 	unsigned long flags;
-	spin_lock_irqsave(&ixp4xx_pci_lock, flags);
+	raw_spin_lock_irqsave(&ixp4xx_pci_lock, flags);
 	*PCI_CRP_AD_CBE = CRP_AD_CBE_WRITE | ad_cbe;
 	*PCI_CRP_WDATA = data;
-	spin_unlock_irqrestore(&ixp4xx_pci_lock, flags);
+	raw_spin_unlock_irqrestore(&ixp4xx_pci_lock, flags);
 }
 
 static inline int check_master_abort(void)
@@ -101,7 +101,7 @@ int ixp4xx_pci_read_errata(u32 addr, u32 cmd, u32* data)
 	int retval = 0;
 	int i;
 
-	spin_lock_irqsave(&ixp4xx_pci_lock, flags);
+	raw_spin_lock_irqsave(&ixp4xx_pci_lock, flags);
 
 	*PCI_NP_AD = addr;
 
@@ -118,7 +118,7 @@ int ixp4xx_pci_read_errata(u32 addr, u32 cmd, u32* data)
 	if(check_master_abort())
 		retval = 1;
 
-	spin_unlock_irqrestore(&ixp4xx_pci_lock, flags);
+	raw_spin_unlock_irqrestore(&ixp4xx_pci_lock, flags);
 	return retval;
 }
 
@@ -127,7 +127,7 @@ int ixp4xx_pci_read_no_errata(u32 addr, u32 cmd, u32* data)
 	unsigned long flags;
 	int retval = 0;
 
-	spin_lock_irqsave(&ixp4xx_pci_lock, flags);
+	raw_spin_lock_irqsave(&ixp4xx_pci_lock, flags);
 
 	*PCI_NP_AD = addr;
 
@@ -140,7 +140,7 @@ int ixp4xx_pci_read_no_errata(u32 addr, u32 cmd, u32* data)
 	if(check_master_abort())
 		retval = 1;
 
-	spin_unlock_irqrestore(&ixp4xx_pci_lock, flags);
+	raw_spin_unlock_irqrestore(&ixp4xx_pci_lock, flags);
 	return retval;
 }
 
@@ -149,7 +149,7 @@ int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data)
 	unsigned long flags;
 	int retval = 0;
 
-	spin_lock_irqsave(&ixp4xx_pci_lock, flags);
+	raw_spin_lock_irqsave(&ixp4xx_pci_lock, flags);
 
 	*PCI_NP_AD = addr;
 
@@ -162,7 +162,7 @@ int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data)
 	if(check_master_abort())
 		retval = 1;
 
-	spin_unlock_irqrestore(&ixp4xx_pci_lock, flags);
+	raw_spin_unlock_irqrestore(&ixp4xx_pci_lock, flags);
 	return retval;
 }
 
-- 
1.7.2.3
