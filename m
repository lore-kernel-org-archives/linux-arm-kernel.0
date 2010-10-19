From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 19 Oct 2010 16:39:05 +0200
Subject: [PATCH 10/12] ARM: integrator: Convert cm_lock and v3_lock to
	raw_spinlock
In-Reply-To: <20101019143717.GH11713@pengutronix.de>
References: <20101019143717.GH11713@pengutronix.de>
Message-ID: <1287499147-13846-10-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Gleixner <tglx@linutronix.de>

cm_lock and v3_lock need to be real spinlocks on preempt-rt. Convert
them to raw_spinlock. No change for !RT kernels.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-integrator/core.c   |    6 +++---
 arch/arm/mach-integrator/pci_v3.c |   14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index 8f4fb6d..e5f1d66 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -203,7 +203,7 @@ static struct amba_pl010_data integrator_uart_data = {
 
 #define CM_CTRL	IO_ADDRESS(INTEGRATOR_HDR_CTRL)
 
-static DEFINE_SPINLOCK(cm_lock);
+static DEFINE_RAW_SPINLOCK(cm_lock);
 
 /**
  * cm_control - update the CM_CTRL register.
@@ -215,10 +215,10 @@ void cm_control(u32 mask, u32 set)
 	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&cm_lock, flags);
+	raw_spin_lock_irqsave(&cm_lock, flags);
 	val = readl(CM_CTRL) & ~mask;
 	writel(val | set, CM_CTRL);
-	spin_unlock_irqrestore(&cm_lock, flags);
+	raw_spin_unlock_irqrestore(&cm_lock, flags);
 }
 
 EXPORT_SYMBOL(cm_control);
diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index 6467d99..a9b90a0 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -163,7 +163,7 @@
  *	 7:2	register number
  *  
  */
-static DEFINE_SPINLOCK(v3_lock);
+static DEFINE_RAW_SPINLOCK(v3_lock);
 
 #define PCI_BUS_NONMEM_START	0x00000000
 #define PCI_BUS_NONMEM_SIZE	SZ_256M
@@ -284,7 +284,7 @@ static int v3_read_config(struct pci_bus *bus, unsigned int devfn, int where,
 	unsigned long flags;
 	u32 v;
 
-	spin_lock_irqsave(&v3_lock, flags);
+	raw_spin_lock_irqsave(&v3_lock, flags);
 	addr = v3_open_config_window(bus, devfn, where);
 
 	switch (size) {
@@ -302,7 +302,7 @@ static int v3_read_config(struct pci_bus *bus, unsigned int devfn, int where,
 	}
 
 	v3_close_config_window();
-	spin_unlock_irqrestore(&v3_lock, flags);
+	raw_spin_unlock_irqrestore(&v3_lock, flags);
 
 	*val = v;
 	return PCIBIOS_SUCCESSFUL;
@@ -314,7 +314,7 @@ static int v3_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 	unsigned long addr;
 	unsigned long flags;
 
-	spin_lock_irqsave(&v3_lock, flags);
+	raw_spin_lock_irqsave(&v3_lock, flags);
 	addr = v3_open_config_window(bus, devfn, where);
 
 	switch (size) {
@@ -335,7 +335,7 @@ static int v3_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 	}
 
 	v3_close_config_window();
-	spin_unlock_irqrestore(&v3_lock, flags);
+	raw_spin_unlock_irqrestore(&v3_lock, flags);
 
 	return PCIBIOS_SUCCESSFUL;
 }
@@ -510,7 +510,7 @@ void __init pci_v3_preinit(void)
 	hook_fault_code(8, v3_pci_fault, SIGBUS, 0, "external abort on non-linefetch");
 	hook_fault_code(10, v3_pci_fault, SIGBUS, 0, "external abort on non-linefetch");
 
-	spin_lock_irqsave(&v3_lock, flags);
+	raw_spin_lock_irqsave(&v3_lock, flags);
 
 	/*
 	 * Unlock V3 registers, but only if they were previously locked.
@@ -583,7 +583,7 @@ void __init pci_v3_preinit(void)
 		printk(KERN_ERR "PCI: unable to grab PCI error "
 		       "interrupt: %d\n", ret);
 
-	spin_unlock_irqrestore(&v3_lock, flags);
+	raw_spin_unlock_irqrestore(&v3_lock, flags);
 }
 
 void __init pci_v3_postinit(void)
-- 
1.7.2.3
