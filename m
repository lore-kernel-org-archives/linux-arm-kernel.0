From: kirill@shutemov.name (Kirill A. Shutsemov)
Date: Mon, 19 Jul 2010 11:53:22 +0300
Subject: [PATCH 2/5] Add 'code' parameter for hook_fault_code()
In-Reply-To: <cover.1279529223.git.kirill@shutemov.name>
References: <cover.1279529223.git.kirill@shutemov.name>
Message-ID: <182e37fa369c926c23f21f6a06426afb8a5b6f81.1279529223.git.kirill@shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kirill A. Shutemov <kirill@shutemov.name>

Add one more parameter to hook_fault_code() to be able to set 'code'
field of struct fsr_info.

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
---
 arch/arm/include/asm/system.h     |    2 +-
 arch/arm/mach-integrator/pci_v3.c |    8 ++++----
 arch/arm/mach-iop13xx/pci.c       |    2 +-
 arch/arm/mach-ixp2000/pci.c       |    2 +-
 arch/arm/mach-ixp23xx/pci.c       |    2 +-
 arch/arm/mach-ixp4xx/common-pci.c |    3 ++-
 arch/arm/mach-ks8695/pci.c        |    4 ++--
 arch/arm/mm/alignment.c           |    6 ++++--
 arch/arm/mm/fault.c               |   14 ++++++++------
 arch/arm/plat-iop/pci.c           |    2 +-
 10 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 5f4f480..8ba1ccf 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -83,7 +83,7 @@ void arm_notify_die(const char *str, struct pt_regs *regs, struct siginfo *info,
 
 void hook_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
 				       struct pt_regs *),
-		     int sig, const char *name);
+		     int sig, int code, const char *name);
 
 #define xchg(ptr,x) \
 	((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index 9cef059..6467d99 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -505,10 +505,10 @@ void __init pci_v3_preinit(void)
 	/*
 	 * Hook in our fault handler for PCI errors
 	 */
-	hook_fault_code(4, v3_pci_fault, SIGBUS, "external abort on linefetch");
-	hook_fault_code(6, v3_pci_fault, SIGBUS, "external abort on linefetch");
-	hook_fault_code(8, v3_pci_fault, SIGBUS, "external abort on non-linefetch");
-	hook_fault_code(10, v3_pci_fault, SIGBUS, "external abort on non-linefetch");
+	hook_fault_code(4, v3_pci_fault, SIGBUS, 0, "external abort on linefetch");
+	hook_fault_code(6, v3_pci_fault, SIGBUS, 0, "external abort on linefetch");
+	hook_fault_code(8, v3_pci_fault, SIGBUS, 0, "external abort on non-linefetch");
+	hook_fault_code(10, v3_pci_fault, SIGBUS, 0, "external abort on non-linefetch");
 
 	spin_lock_irqsave(&v3_lock, flags);
 
diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
index 6d5a908..773ea0c 100644
--- a/arch/arm/mach-iop13xx/pci.c
+++ b/arch/arm/mach-iop13xx/pci.c
@@ -987,7 +987,7 @@ void __init iop13xx_pci_init(void)
 		iop13xx_atux_setup();
 	}
 
-	hook_fault_code(16+6, iop13xx_pci_abort, SIGBUS,
+	hook_fault_code(16+6, iop13xx_pci_abort, SIGBUS, 0,
 			"imprecise external abort");
 }
 
diff --git a/arch/arm/mach-ixp2000/pci.c b/arch/arm/mach-ixp2000/pci.c
index 90771ca..853fd90 100644
--- a/arch/arm/mach-ixp2000/pci.c
+++ b/arch/arm/mach-ixp2000/pci.c
@@ -209,7 +209,7 @@ ixp2000_pci_preinit(void)
 			"the needed workaround has not been configured in");
 #endif
 
-	hook_fault_code(16+6, ixp2000_pci_abort_handler, SIGBUS,
+	hook_fault_code(16+6, ixp2000_pci_abort_handler, SIGBUS, 0
 				"PCI config cycle to non-existent device");
 }
 
diff --git a/arch/arm/mach-ixp23xx/pci.c b/arch/arm/mach-ixp23xx/pci.c
index 4b0e598..563819a 100644
--- a/arch/arm/mach-ixp23xx/pci.c
+++ b/arch/arm/mach-ixp23xx/pci.c
@@ -229,7 +229,7 @@ void __init ixp23xx_pci_preinit(void)
 {
 	ixp23xx_pci_common_init();
 
-	hook_fault_code(16+6, ixp23xx_pci_abort_handler, SIGBUS,
+	hook_fault_code(16+6, ixp23xx_pci_abort_handler, SIGBUS, 0,
 			"PCI config cycle to non-existent device");
 
 	*IXP23XX_PCI_ADDR_EXT = 0x0000e000;
diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index e318153..f4fbb5e 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -382,7 +382,8 @@ void __init ixp4xx_pci_preinit(void)
 
 
 	/* hook in our fault handler for PCI errors */
-	hook_fault_code(16+6, abort_handler, SIGBUS, "imprecise external abort");
+	hook_fault_code(16+6, abort_handler, SIGBUS, 0,
+			"imprecise external abort");
 
 	pr_debug("setup PCI-AHB(inbound) and AHB-PCI(outbound) address mappings\n");
 
diff --git a/arch/arm/mach-ks8695/pci.c b/arch/arm/mach-ks8695/pci.c
index 7849966..5fcd082 100644
--- a/arch/arm/mach-ks8695/pci.c
+++ b/arch/arm/mach-ks8695/pci.c
@@ -268,8 +268,8 @@ static void __init ks8695_pci_preinit(void)
 	__raw_writel(0, KS8695_PCI_VA + KS8695_PIOBAC);
 
 	/* hook in fault handlers */
-	hook_fault_code(8, ks8695_pci_fault, SIGBUS, "external abort on non-linefetch");
-	hook_fault_code(10, ks8695_pci_fault, SIGBUS, "external abort on non-linefetch");
+	hook_fault_code(8, ks8695_pci_fault, SIGBUS, 0, "external abort on non-linefetch");
+	hook_fault_code(10, ks8695_pci_fault, SIGBUS, 0, "external abort on non-linefetch");
 }
 
 static void ks8695_show_pciregs(void)
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 53a6096..77cfdbe 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -924,8 +924,10 @@ static int __init alignment_init(void)
 		ai_usermode = UM_FIXUP;
 	}
 
-	hook_fault_code(1, do_alignment, SIGBUS, "alignment exception");
-	hook_fault_code(3, do_alignment, SIGBUS, "alignment exception");
+	hook_fault_code(1, do_alignment, SIGBUS, BUS_ADRALN,
+			"alignment exception");
+	hook_fault_code(3, do_alignment, SIGBUS, BUS_ADRALN,
+			"alignment exception");
 
 	return 0;
 }
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index ce6f3a4..84131c8 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -508,13 +508,15 @@ static struct fsr_info {
 
 void __init
 hook_fault_code(int nr, int (*fn)(unsigned long, unsigned int, struct pt_regs *),
-		int sig, const char *name)
+		int sig, int code, const char *name)
 {
-	if (nr >= 0 && nr < ARRAY_SIZE(fsr_info)) {
-		fsr_info[nr].fn   = fn;
-		fsr_info[nr].sig  = sig;
-		fsr_info[nr].name = name;
-	}
+	if (nr < 0 || nr >= ARRAY_SIZE(fsr_info))
+		BUG();
+
+	fsr_info[nr].fn   = fn;
+	fsr_info[nr].sig  = sig;
+	fsr_info[nr].code = code;
+	fsr_info[nr].name = name;
 }
 
 /*
diff --git a/arch/arm/plat-iop/pci.c b/arch/arm/plat-iop/pci.c
index ce31f31..43f2b15 100644
--- a/arch/arm/plat-iop/pci.c
+++ b/arch/arm/plat-iop/pci.c
@@ -359,7 +359,7 @@ static void __init iop3xx_atu_debug(void)
 	DBG("ATU: IOP3XX_ATUCMD=0x%04x\n", *IOP3XX_ATUCMD);
 	DBG("ATU: IOP3XX_ATUCR=0x%08x\n", *IOP3XX_ATUCR);
 
-	hook_fault_code(16+6, iop3xx_pci_abort, SIGBUS, "imprecise external abort");
+	hook_fault_code(16+6, iop3xx_pci_abort, SIGBUS, 0, "imprecise external abort");
 }
 
 /* for platforms that might be host-bus-adapters */
-- 
1.7.1.1
