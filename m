From: robherring2@gmail.com (Rob Herring)
Date: Wed,  8 Feb 2012 19:33:37 -0600
Subject: [PATCH v2 2/4] ARM: rpc: make default fiq handler run-time installed
In-Reply-To: <1328751219-2552-1-git-send-email-robherring2@gmail.com>
References: <1328751219-2552-1-git-send-email-robherring2@gmail.com>
Message-ID: <1328751219-2552-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Only rpc uses disable_fiq macro. Change it to a run-time installed
default FIQ handler. The handler is installed before interrupts are
enabled so the behavior should be unchanged.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-rpc/Makefile |    2 +-
 arch/arm/mach-rpc/fiq.S    |   12 ++++++++++++
 arch/arm/mach-rpc/irq.c    |    6 ++++++
 3 files changed, 19 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-rpc/fiq.S

diff --git a/arch/arm/mach-rpc/Makefile b/arch/arm/mach-rpc/Makefile
index aa77bc9..dfa405c 100644
--- a/arch/arm/mach-rpc/Makefile
+++ b/arch/arm/mach-rpc/Makefile
@@ -4,7 +4,7 @@
 
 # Object file lists.
 
-obj-y			:= dma.o irq.o riscpc.o
+obj-y			:= dma.o fiq.o irq.o riscpc.o
 obj-m			:=
 obj-n			:=
 obj-			:=
diff --git a/arch/arm/mach-rpc/fiq.S b/arch/arm/mach-rpc/fiq.S
new file mode 100644
index 0000000..e0e4ac5
--- /dev/null
+++ b/arch/arm/mach-rpc/fiq.S
@@ -0,0 +1,12 @@
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <mach/hardware.h>
+#include <mach/entry-macro.S>
+
+	.text
+
+	.global	rpc_default_fiq_end
+ENTRY(rpc_default_fiq_start)
+	disable_fiq
+	subs	pc, lr, #4
+rpc_default_fiq_end:
diff --git a/arch/arm/mach-rpc/irq.c b/arch/arm/mach-rpc/irq.c
index 2e1b530..cf0e669 100644
--- a/arch/arm/mach-rpc/irq.c
+++ b/arch/arm/mach-rpc/irq.c
@@ -5,6 +5,7 @@
 #include <asm/mach/irq.h>
 #include <asm/hardware/iomd.h>
 #include <asm/irq.h>
+#include <asm/fiq.h>
 
 static void iomd_ack_irq_a(struct irq_data *d)
 {
@@ -112,6 +113,8 @@ static struct irq_chip iomd_fiq_chip = {
 	.irq_unmask	= iomd_unmask_irq_fiq,
 };
 
+extern unsigned char rpc_default_fiq_start, rpc_default_fiq_end;
+
 void __init rpc_init_irq(void)
 {
 	unsigned int irq, flags;
@@ -121,6 +124,9 @@ void __init rpc_init_irq(void)
 	iomd_writeb(0, IOMD_FIQMASK);
 	iomd_writeb(0, IOMD_DMAMASK);
 
+	set_fiq_handler(&rpc_default_fiq_start,
+		&rpc_default_fiq_end - &rpc_default_fiq_start);
+
 	for (irq = 0; irq < NR_IRQS; irq++) {
 		flags = IRQF_VALID;
 
-- 
1.7.5.4
