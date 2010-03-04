From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: Integrator: convert to use register definitions
References: <git-1267729916-f8760b0e06e1c909bb1153b5cb0434e214c90dbb@rmk-PC>
Message-ID: <git-1267729916-c5a2fd4062e2ee2088f38ac4e60a5669c1c8ac56@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Rather than using converted base address plus offset, use the register
address itself now that IO_ADDRESS() can cope with these.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-integrator/core.c          |   12 ++++++------
 arch/arm/mach-integrator/cpu.c           |    8 ++++----
 arch/arm/mach-integrator/integrator_ap.c |    2 +-
 arch/arm/mach-integrator/integrator_cp.c |   10 +++++-----
 arch/arm/mach-integrator/pci_v3.c        |    6 +++---
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index d02f0e3..ac2b0c5 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -166,8 +166,8 @@ arch_initcall(integrator_init);
  *  UART0  7    6
  *  UART1  5    4
  */
-#define SC_CTRLC	(IO_ADDRESS(INTEGRATOR_SC_BASE) + INTEGRATOR_SC_CTRLC_OFFSET)
-#define SC_CTRLS	(IO_ADDRESS(INTEGRATOR_SC_BASE) + INTEGRATOR_SC_CTRLS_OFFSET)
+#define SC_CTRLC	IO_ADDRESS(INTEGRATOR_SC_CTRLC)
+#define SC_CTRLS	IO_ADDRESS(INTEGRATOR_SC_CTRLS)
 
 static void integrator_uart_set_mctrl(struct amba_device *dev, void __iomem *base, unsigned int mctrl)
 {
@@ -199,7 +199,7 @@ static struct amba_pl010_data integrator_uart_data = {
 	.set_mctrl = integrator_uart_set_mctrl,
 };
 
-#define CM_CTRL	IO_ADDRESS(INTEGRATOR_HDR_BASE) + INTEGRATOR_HDR_CTRL_OFFSET
+#define CM_CTRL	IO_ADDRESS(INTEGRATOR_HDR_CTRL)
 
 static DEFINE_SPINLOCK(cm_lock);
 
@@ -224,9 +224,9 @@ EXPORT_SYMBOL(cm_control);
 /*
  * Where is the timer (VA)?
  */
-#define TIMER0_VA_BASE (IO_ADDRESS(INTEGRATOR_CT_BASE)+0x00000000)
-#define TIMER1_VA_BASE (IO_ADDRESS(INTEGRATOR_CT_BASE)+0x00000100)
-#define TIMER2_VA_BASE (IO_ADDRESS(INTEGRATOR_CT_BASE)+0x00000200)
+#define TIMER0_VA_BASE IO_ADDRESS(INTEGRATOR_TIMER0_BASE)
+#define TIMER1_VA_BASE IO_ADDRESS(INTEGRATOR_TIMER1_BASE)
+#define TIMER2_VA_BASE IO_ADDRESS(INTEGRATOR_TIMER2_BASE)
 
 /*
  * How long is the timer interval?
diff --git a/arch/arm/mach-integrator/cpu.c b/arch/arm/mach-integrator/cpu.c
index b761879..7f1b73b 100644
--- a/arch/arm/mach-integrator/cpu.c
+++ b/arch/arm/mach-integrator/cpu.c
@@ -26,10 +26,10 @@
 
 static struct cpufreq_driver integrator_driver;
 
-#define CM_ID  	(IO_ADDRESS(INTEGRATOR_HDR_BASE)+INTEGRATOR_HDR_ID_OFFSET)
-#define CM_OSC	(IO_ADDRESS(INTEGRATOR_HDR_BASE)+INTEGRATOR_HDR_OSC_OFFSET)
-#define CM_STAT (IO_ADDRESS(INTEGRATOR_HDR_BASE)+INTEGRATOR_HDR_STAT_OFFSET)
-#define CM_LOCK (IO_ADDRESS(INTEGRATOR_HDR_BASE)+INTEGRATOR_HDR_LOCK_OFFSET)
+#define CM_ID  	IO_ADDRESS(INTEGRATOR_HDR_ID)
+#define CM_OSC	IO_ADDRESS(INTEGRATOR_HDR_OSC)
+#define CM_STAT IO_ADDRESS(INTEGRATOR_HDR_STAT)
+#define CM_LOCK IO_ADDRESS(INTEGRATOR_HDR_LOCK)
 
 static const struct icst525_params lclk_params = {
 	.ref		= 24000,
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 45bba04..c89b231 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -56,7 +56,7 @@
 #define VA_IC_BASE	IO_ADDRESS(INTEGRATOR_IC_BASE) 
 #define VA_SC_BASE	IO_ADDRESS(INTEGRATOR_SC_BASE)
 #define VA_EBI_BASE	IO_ADDRESS(INTEGRATOR_EBI_BASE)
-#define VA_CMIC_BASE	IO_ADDRESS(INTEGRATOR_HDR_BASE) + INTEGRATOR_HDR_IC_OFFSET
+#define VA_CMIC_BASE	IO_ADDRESS(INTEGRATOR_HDR_IC)
 
 /*
  * Logical      Physical
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 333c297..c0161df 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -47,7 +47,7 @@
 
 #define INTCP_PA_CLCD_BASE		0xc0000000
 
-#define INTCP_VA_CIC_BASE		IO_ADDRESS(INTEGRATOR_HDR_BASE) + 0x40
+#define INTCP_VA_CIC_BASE		IO_ADDRESS(INTEGRATOR_HDR_BASE + 0x40)
 #define INTCP_VA_PIC_BASE		IO_ADDRESS(INTEGRATOR_IC_BASE)
 #define INTCP_VA_SIC_BASE		IO_ADDRESS(INTEGRATOR_CP_SIC_BASE)
 
@@ -265,8 +265,8 @@ static void __init intcp_init_irq(void)
 /*
  * Clock handling
  */
-#define CM_LOCK (IO_ADDRESS(INTEGRATOR_HDR_BASE)+INTEGRATOR_HDR_LOCK_OFFSET)
-#define CM_AUXOSC (IO_ADDRESS(INTEGRATOR_HDR_BASE)+0x1c)
+#define CM_LOCK IO_ADDRESS(INTEGRATOR_HDR_LOCK)
+#define CM_AUXOSC IO_ADDRESS(INTEGRATOR_HDR_BASE + 0x1c)
 
 static const struct icst525_params cp_auxvco_params = {
 	.ref		= 24000,
@@ -393,8 +393,8 @@ static struct platform_device *intcp_devs[] __initdata = {
  */
 static unsigned int mmc_status(struct device *dev)
 {
-	unsigned int status = readl(IO_ADDRESS(0xca000000) + 4);
-	writel(8, IO_ADDRESS(INTEGRATOR_CP_CTL_BASE) + 8);
+	unsigned int status = readl(IO_ADDRESS(0xca000000 + 4));
+	writel(8, IO_ADDRESS(INTEGRATOR_CP_CTL_BASE + 8));
 
 	return status & 8;
 }
diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index e87fe9f..e549162 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -391,9 +391,9 @@ static int __init pci_v3_setup_resources(struct resource **resource)
  * means I can't get additional information on the reason for the pm2fb
  * problems.  I suppose I'll just have to mind-meld with the machine. ;)
  */
-#define SC_PCI     (IO_ADDRESS(INTEGRATOR_SC_BASE) + INTEGRATOR_SC_PCIENABLE_OFFSET)
-#define SC_LBFADDR (IO_ADDRESS(INTEGRATOR_SC_BASE) + 0x20)
-#define SC_LBFCODE (IO_ADDRESS(INTEGRATOR_SC_BASE) + 0x24)
+#define SC_PCI     IO_ADDRESS(INTEGRATOR_SC_PCIENABLE)
+#define SC_LBFADDR IO_ADDRESS(INTEGRATOR_SC_BASE + 0x20)
+#define SC_LBFCODE IO_ADDRESS(INTEGRATOR_SC_BASE + 0x24)
 
 static int
 v3_pci_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
