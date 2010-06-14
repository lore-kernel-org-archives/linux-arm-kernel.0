From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 14 Jun 2010 17:39:15 +0900
Subject: [PATCH 6/6] S5PV210 PM Support Main (suspend-to-mem)
In-Reply-To: <1276504755-24741-6-git-send-email-MyungJoo.Ham@samsung.com>
References: <1276504755-24741-1-git-send-email-MyungJoo.Ham@samsung.com>
	<1276504755-24741-2-git-send-email-MyungJoo.Ham@samsung.com>
	<1276504755-24741-3-git-send-email-MyungJoo.Ham@samsung.com>
	<1276504755-24741-4-git-send-email-MyungJoo.Ham@samsung.com>
	<1276504755-24741-5-git-send-email-MyungJoo.Ham@samsung.com>
	<1276504755-24741-6-git-send-email-MyungJoo.Ham@samsung.com>
Message-ID: <1276504755-24741-7-git-send-email-MyungJoo.Ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: MyungJoo Ham <MyungJoo.Ham@samsung.com>
---
 arch/arm/mach-s5pv210/Makefile               |    4 +
 arch/arm/plat-s5p/Makefile                   |    3 +
 arch/arm/plat-s5p/include/plat/map-s5p.h     |    1 +
 arch/arm/plat-s5p/sleep.S                    |  248 ++++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/pm-core.h |   53 ++++++
 arch/arm/plat-samsung/include/plat/pm.h      |   13 ++
 arch/arm/plat-samsung/pm-gpio.c              |    4 +-
 arch/arm/plat-samsung/pm.c                   |   75 +++++++-
 8 files changed, 392 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/plat-s5p/sleep.S
 create mode 100644 arch/arm/plat-samsung/include/plat/pm-core.h

diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 30be9a6..16ca1e9 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -33,3 +33,7 @@ obj-$(CONFIG_S5PV210_SETUP_I2C1) 	+= setup-i2c1.o
 obj-$(CONFIG_S5PV210_SETUP_I2C2) 	+= setup-i2c2.o
 obj-$(CONFIG_S5PV210_SETUP_SDHCI)       += setup-sdhci.o
 obj-$(CONFIG_S5PV210_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
+
+# power management support
+
+obj-$(CONFIG_PM)		+= pm.o
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index 39c242b..578a4e5 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -18,3 +18,6 @@ obj-y				+= clock.o
 obj-y				+= irq.o
 obj-$(CONFIG_S5P_EXT_INT)	+= irq-eint.o
 
+# CPU support
+
+obj-$(CONFIG_PM)		+= sleep.o
diff --git a/arch/arm/plat-s5p/include/plat/map-s5p.h b/arch/arm/plat-s5p/include/plat/map-s5p.h
index 1482852..20b8524 100644
--- a/arch/arm/plat-s5p/include/plat/map-s5p.h
+++ b/arch/arm/plat-s5p/include/plat/map-s5p.h
@@ -24,6 +24,7 @@
 #define S5P_VA_UART3		(S3C_VA_UART + 0xC00)
 
 #define S3C_UART_OFFSET		(0x400)
+#define S3C_VA_UARTx(x)         (S3C_VA_UART + ((x) * S3C_UART_OFFSET))
 
 #define VA_VIC(x)		(S3C_VA_IRQ + ((x) * 0x10000))
 #define VA_VIC0			VA_VIC(0)
diff --git a/arch/arm/plat-s5p/sleep.S b/arch/arm/plat-s5p/sleep.S
new file mode 100644
index 0000000..a1e038b
--- /dev/null
+++ b/arch/arm/plat-s5p/sleep.S
@@ -0,0 +1,248 @@
+/* linux/arch/arm/plat-s5pc1xx/sleep.S
+ *
+ * S5PC1XX Power Manager (Suspend-To-RAM) support
+ *
+ * Based on plat-s3c64xx sleep code
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*/
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <mach/hardware.h>
+#include <mach/map.h>
+
+#include <mach/regs-gpio.h>
+#include <mach/regs-clock.h>
+#include <plat/regs-serial.h>
+#include <asm/memory.h>
+
+	.text
+
+	/* s3c_cpu_save
+	 *
+	 * save enough of the CPU state to allow us to re-start
+	 * pm.c code. as we store items like the sp/lr, we will
+	 * end up returning from this function when the cpu resumes
+	 * so the return value is set to mark this.
+	 *
+	 * This arangement means we avoid having to flush the cache
+	 * from this code.
+	 *
+	 * entry:
+	 *	r0 = pointer to save block
+	 *
+	*/
+
+ENTRY(s3c_cpu_save)
+	stmfd	sp!, { r3 - r12, lr }
+
+	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
+	mrc	p15, 0, r5, c3, c0, 0	@ Domain ID
+	mrc	p15, 0, r6, c2, c0, 0	@ Translation Table BASE0
+	mrc	p15, 0, r7, c2, c0, 1	@ Translation Table BASE1
+	mrc	p15, 0, r8, c2, c0, 2	@ Translation Table Control
+	mrc	p15, 0, r9, c1, c0, 0	@ Control register
+	mrc	p15, 0, r10, c1, c0, 1	@ Auxiliary control register
+	mrc	p15, 0, r11, c1, c0, 2	@ Co-processor access controls
+	mrc	p15, 0, r12, c10, c2, 0	@ Read PRRR
+	mrc	p15, 0, r3, c10, c2, 1	@ READ NMRR
+
+ ARM(	stmia	r0, { r3 - r13 } )	@ Save CP registers and SP
+ THUMB(	stmia	r0, { r3 - r12 } )	@ Save CP registers and SP
+ THUMB(	str	sp, [ r0, #40 ]	 )
+
+
+	/* save our state to ram  */
+	bl	s3c_pm_cb_flushcache
+
+	/* call final suspend code  */
+	ldr	r0, =pm_cpu_sleep
+	@@ldr	pc, [r0]
+	ldr	r0, [r0]
+	mov	pc, r0
+
+	@@ return to the caller, after having the MMU
+	@@ turned on, this restores the last bits from the
+	@@ stack
+
+	.global resume_with_mmu
+resume_with_mmu:
+
+	/* delete added mmu table list */
+	ldr	r9 , =(PAGE_OFFSET - PHYS_OFFSET)
+	add	r4, r4, r9
+	str	r12, [r4]
+
+	ldmfd	sp!, { r3 - r12, pc }	@ return, from sp from s3c_cpu_save
+
+	.ltorg
+
+	@@ the next bits sit in the .data segment, even though they
+	@@ happen to be code... the s3c_sleep_save_phys needs to be
+	@@ accessed by the resume code before it can restore the MMU.
+	@@ This means that the variable has to be close enough for the
+	@@ code to read it... since the .text segment needs to be RO,
+	@@ the data segment can be the only place to put this code.
+
+	.data
+
+	.global	s3c_sleep_save_phys
+s3c_sleep_save_phys:
+	.word	0
+
+	/* sleep magic, to allow the bootloader to check for an valid
+	 * image to resume to. Must be the first word before the
+	 * s3c_cpu_resume entry.
+	*/
+
+	.word	0x2bedf00d
+
+	/* s3c_cpu_resume
+	 *
+	 * resume code entry for bootloader to call
+	 *
+	 * we must put this code here in the data segment as we have no
+	 * other way of restoring the stack pointer after sleep, and we
+	 * must not write to the code segment (code is read-only)
+	*/
+
+ENTRY(s3c_cpu_resume)
+	mov	r0, #PSR_I_BIT | PSR_F_BIT | SVC_MODE
+	msr	cpsr_c, r0
+
+	/* Debug
+	*
+	* Serial port configuration code
+	* Use when low-level debug functionality is needed before UARTs
+	* configuratio is restored
+	* It utilizes low-level kernel debug functions (printch,printhex),
+	* so please enable them at kernel config
+	* This code was used with S5PC110 !!!
+	*/
+#ifdef CONFIG_SAMSUNG_PM_DEBUG
+	ldr	r0, =S5P_PA_GPIO
+	ldr     r1, =0x22222222
+	str     r1, [r0, #0x0]                  @S5PC1XX_GPIO_A0_OFFSET
+	ldr     r1, =0x00002222
+	str     r1, [r0, #0x20]                 @S5PC1XX_GPIO_A1_OFFSET
+
+	/* UART_SEL MP0_5[7] at S5PC110 */
+	add     r0, r0, #0x360                  @S5PC1XX_GPIO_MP0_5_OFFSET
+	ldr     r1, [r0, #0x0]                  @S5PC1XX_GPIO_CON_OFFSET
+	bic     r1, r1, #(0xf << 28)            @ 28 = 7 * 4-bit
+	orr     r1, r1, #(0x1 << 28)            @ Output
+	str     r1, [r0, #0x0]                  @S5PC1XX_GPIO_CON_OFFSET
+
+	ldr     r1, [r0, #0x8]                  @S5PC1XX_GPIO_PULL_OFFSET
+	bic     r1, r1, #(0x3 << 14)            @ 14 = 7 * 2-bit
+	orr     r1, r1, #(0x2 << 14)            @ Pull-up enabled
+	str     r1, [r0, #0x8]                  @S5PC1XX_GPIO_PULL_OFFSET
+
+	ldr     r1, [r0, #0x4]                  @S5PC1XX_GPIO_DAT_OFFSET
+	orr     r1, r1, #(1 << 7)               @ 7 = 7 * 1-bit
+	str     r1, [r0, #0x4]                  @S5PC1XX_GPIO_DAT_OFFSET
+
+	ldr     r0, =S3C_PA_UART                 @ S5PC110_PA_UART
+	add	r0, r0, #(0x400 * CONFIG_DEBUG_S3C_UART) @
+	mov     r1, #0x3
+	str     r1, [r0, #0x000]                @ ULCON
+	ldr     r1, =0x245
+	str     r1, [r0, #0x004]                @ UCON
+	mov     r1, #0x23
+	str     r1, [r0, #0x028]                @ UBRDIV
+	mov     r1, #0x3
+	str     r1, [r0, #0x02C]                @ UDIVSLOT
+
+	mov r0, #'_'
+	bl printch
+
+	mov r0, #'_'
+	bl printch
+
+	mov r0, #'W'
+	bl printch
+
+	mov r0, #'_'
+	bl printch
+
+	mov r0, #'_'
+	bl printch
+
+	mov r0, #'\n'
+	bl printch
+
+#endif
+	mov	r1, #0
+	mcr	p15, 0, r1, c8, c7, 0	@ Invalidate TLBs
+	mcr	p15, 0, r1, c7, c5, 0	@ Invalidate I Cache
+
+ ARM(	ldr	r0, s3c_sleep_save_phys		)
+ THUMB( adr.w	r0, s3c_sleep_save_phys		)
+ THUMB(	ldr	r0, [r0]			)
+
+ ARM(	ldmia	r0, { r3 - r13 } )	@ reload regs and SPI
+ THUMB(	ldmia	r0, { r3 - r12 } )	@ reload regs and SPI
+ THUMB(	ldr	sp, [ r0, #40 ]	 )
+
+	mcr	p15, 0, r4, c13, c0, 0	@ FCSE/PID
+	mcr	p15, 0, r5, c3, c0, 0	@ Domain ID
+	mcr	p15, 0, r8, c2, c0, 2	@ Translation Table Control
+	mcr	p15, 0, r7, c2, c0, 1	@ Translation Table BASE1
+	mcr	p15, 0, r6, c2, c0, 0	@ Translation Table BASE0
+	mcr	p15, 0, r10, c1, c0, 1	@ Auxiliary control register
+
+	mov	r0, #0
+	mcr	p15, 0, r0, c8, c7, 0	@ Invalidate I & D TLB
+
+	mov	r0, #0
+	mcr	p15, 0, r11, c1, c0, 2	@ Co-processor access controls
+	mcr	p15, 0, r0, c7, c5, 4
+
+	mcr	p15, 0, r12, c10, c2, 0	@ write PRRR
+	mcr	p15, 0, r3, c10, c2, 1	@ write NMRR
+
+
+	/* calculate first section address into r8 */
+	mov	r4, r6
+	ldr	r5, =0x3fff
+	bic	r4, r4, r5
+	/* read data from INFORM0 */
+	ldr	r11, =S5P_PA_INFORM0
+
+	ldr	r10, [r11, #0]
+	mov	r10, r10 ,LSR #18
+	bic	r10, r10, #0x3
+	orr	r4, r4, r10
+
+	/* calculate mmu list value into r9 */
+	mov	r10, r10, LSL #18
+	ldr	r5, =0x40e
+	orr	r10, r10, r5
+
+	/* back up originally data */
+
+	ldr	r12, [r4]
+
+	/* Added list about mmu */
+	str	r10, [r4]
+
+	ldr	r2, =resume_with_mmu
+	mcr	p15, 0, r9, c1, c0, 0		@ turn on MMU, etc
+
+	isb
+	mov	pc, r2				@ go back to virtual address
+
+	.ltorg
diff --git a/arch/arm/plat-samsung/include/plat/pm-core.h b/arch/arm/plat-samsung/include/plat/pm-core.h
new file mode 100644
index 0000000..df282c5
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/pm-core.h
@@ -0,0 +1,53 @@
+/* linux/arch/arm/plat-s5pc1xx/include/plat/pm-core.h
+ *
+ * S5PC1XX - PM core support for arch/arm/plat-s3c/pm.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <mach/regs-gpio.h>
+#include <mach/regs-clock.h>
+#include <plat/cpu.h>
+
+#define s3c_irqwake_eintallow	(ULONG_MAX)
+#define s3c_irqwake_intallow	(0)
+
+static inline void s3c_pm_debug_init_uart(void)
+{
+	u32 tmp = __raw_readl(S5P_CLKGATE_IP3);
+
+	/* As a note, since the S5PC1XX UARTs generally have multiple
+	 * clock sources, we simply enable PCLK at the moment and hope
+	 * that the resume settings for the UART are suitable for the
+	 * use with PCLK.
+	 */
+
+	tmp |= S5P_CLKGATE_IP3_UART0;
+	tmp |= S5P_CLKGATE_IP3_UART1;
+	tmp |= S5P_CLKGATE_IP3_UART2;
+	tmp |= S5P_CLKGATE_IP3_UART3;
+
+	__raw_writel(tmp, S5P_CLKGATE_IP3);
+	udelay(10);
+}
+
+static inline void s3c_pm_arch_prepare_irqs(void)
+{
+}
+
+static inline void s3c_pm_arch_stop_clocks(void)
+{
+}
+
+static inline void s3c_pm_arch_show_resume_irqs(void)
+{
+	S3C_PMDBG("sleep: wakeup source (WAKEUP_STAT): %8.8xh\n",
+		__raw_readl(S5P_WAKEUP_STAT));
+}
+
+static inline void s3c_pm_arch_update_uart(void __iomem *regs,
+					   struct pm_uart_save *save)
+{
+}
diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-samsung/include/plat/pm.h
index 245836d..ac0bc65 100644
--- a/arch/arm/plat-samsung/include/plat/pm.h
+++ b/arch/arm/plat-samsung/include/plat/pm.h
@@ -39,6 +39,7 @@ extern unsigned long s3c_irqwake_eintallow;
 
 extern void (*pm_cpu_prep)(void);
 extern void (*pm_cpu_sleep)(void);
+extern void (*pm_cpu_finish)(void);
 
 /* Flags for PM Control */
 
@@ -73,6 +74,12 @@ struct sleep_save {
 #define SAVE_ITEM(x) \
 	{ .reg = (x) }
 
+#define SAVE_GPIO_INT(x)                \
+	SAVE_ITEM((x)),                 \
+	SAVE_ITEM((x) + 0x100),         \
+	SAVE_ITEM((x) + 0x200),         \
+	SAVE_ITEM((x) + 0x300)
+
 /**
  * struct pm_uart_save - save block for core UART
  * @ulcon: Save value for S3C2410_ULCON
@@ -161,6 +168,9 @@ extern void s3c_pm_check_store(void);
  */
 extern void s3c_pm_configure_extint(void);
 
+extern void s3c_pm_configure_int(void);
+
+
 /**
  * s3c_pm_restore_gpios() - restore the state of the gpios after sleep.
  *
@@ -187,3 +197,6 @@ extern void s3c_pm_cb_flushcache(void);
 
 extern void s3c_pm_save_core(void);
 extern void s3c_pm_restore_core(void);
+
+extern void s3c_pm_wakeup_source(unsigned int *internal,
+		unsigned int *external);
diff --git a/arch/arm/plat-samsung/pm-gpio.c b/arch/arm/plat-samsung/pm-gpio.c
index 7df03f8..1b9529a 100644
--- a/arch/arm/plat-samsung/pm-gpio.c
+++ b/arch/arm/plat-samsung/pm-gpio.c
@@ -192,7 +192,7 @@ struct s3c_gpio_pm s3c_gpio_pm_2bit = {
 	.resume = s3c_gpio_pm_2bit_resume,
 };
 
-#ifdef CONFIG_ARCH_S3C64XX
+#if defined(CONFIG_ARCH_S3C64XX) || defined(CONFIG_ARCH_S5PV210)
 static void s3c_gpio_pm_4bit_save(struct s3c_gpio_chip *chip)
 {
 	chip->pm_save[1] = __raw_readl(chip->base + OFFS_CON);
@@ -302,7 +302,7 @@ struct s3c_gpio_pm s3c_gpio_pm_4bit = {
 	.save	= s3c_gpio_pm_4bit_save,
 	.resume = s3c_gpio_pm_4bit_resume,
 };
-#endif /* CONFIG_ARCH_S3C64XX */
+#endif /* CONFIG_ARCH_S3C64XX || CONFIG_ARCH_S5PV210 */
 
 /**
  * s3c_pm_save_gpio() - save gpio chip data for suspend
diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index 27cfca5..503e3bd 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -26,10 +26,16 @@
 #include <plat/regs-serial.h>
 #include <mach/regs-clock.h>
 #include <mach/regs-irq.h>
+#include <mach/irqs.h>
 #include <asm/irq.h>
 
 #include <plat/pm.h>
+#ifdef CONFIG_CPU_S5PV210
+#include <plat/pm-core.h>
+#else
 #include <mach/pm-core.h>
+#endif
+#include <plat/gpio-ext.h>
 
 /* for external use */
 
@@ -231,6 +237,27 @@ static void s3c_pm_show_resume_irqs(int start, unsigned long which,
 
 void (*pm_cpu_prep)(void);
 void (*pm_cpu_sleep)(void);
+void (*pm_cpu_finish)(void);
+
+unsigned int s3c_pm_wakeup_source_save_int;
+unsigned int s3c_pm_wakeup_source_save_ext;
+static void s3c_pm_wakeup_source_set(unsigned int internal,
+		unsigned int external)
+{
+	s3c_pm_wakeup_source_save_int = internal & ~s3c_irqwake_intmask;
+	if (internal & 0x01)
+		s3c_pm_wakeup_source_save_ext = external &
+			~s3c_irqwake_eintmask;
+	else
+		s3c_pm_wakeup_source_save_ext = 0;
+}
+
+void s3c_pm_wakeup_source(unsigned int *internal,
+		unsigned int *external)
+{
+	*internal = s3c_pm_wakeup_source_save_int;
+	*external = s3c_pm_wakeup_source_save_ext;
+}
 
 #define any_allowed(mask, allow) (((mask) & (allow)) != (allow))
 
@@ -259,6 +286,11 @@ static int s3c_pm_enter(suspend_state_t state)
 	 * require a full power-cycle)
 	*/
 
+	/* set the irq configuration for wake */
+	s3c_irqwake_intmask = 0xFFDD;
+	s3c_pm_configure_int();
+	s3c_pm_configure_extint();
+
 	if (!any_allowed(s3c_irqwake_intmask, s3c_irqwake_intallow) &&
 	    !any_allowed(s3c_irqwake_eintmask, s3c_irqwake_eintallow)) {
 		printk(KERN_ERR "%s: No wake-up sources!\n", __func__);
@@ -270,19 +302,20 @@ static int s3c_pm_enter(suspend_state_t state)
 
 	s3c_sleep_save_phys = virt_to_phys(regs_save);
 
-	S3C_PMDBG("s3c_sleep_save_phys=0x%08lx\n", s3c_sleep_save_phys);
-
 	/* save all necessary core registers not covered by the drivers */
 
 	s3c_pm_save_gpios();
 	s3c_pm_save_uarts();
 	s3c_pm_save_core();
 
-	/* set the irq configuration for wake */
 
-	s3c_pm_configure_extint();
+	/* For the future use with deep idle */
+	__raw_writel(virt_to_phys(regs_save), S5P_INFORM2);
+	__raw_writel(0, S5P_INFORM1);
+
+	S3C_PMDBG("s3c_sleep_save_phys=0x%08lx\n", s3c_sleep_save_phys);
 
-	S3C_PMDBG("sleep: irq wakeup masks: %08lx,%08lx\n",
+	S3C_PMDBG("sleep: IRQ wakeup masks: %08lx,%08lx\n",
 	    s3c_irqwake_intmask, s3c_irqwake_eintmask);
 
 	s3c_pm_arch_prepare_irqs();
@@ -312,11 +345,11 @@ static int s3c_pm_enter(suspend_state_t state)
 	cpu_init();
 
 	/* restore the system state */
-
 	s3c_pm_restore_core();
 	s3c_pm_restore_uarts();
 	s3c_pm_restore_gpios();
 
+
 	s3c_pm_debug_init();
 
 	/* check what irq (if any) restored the system */
@@ -325,11 +358,36 @@ static int s3c_pm_enter(suspend_state_t state)
 
 	S3C_PMDBG("%s: post sleep, preparing to return\n", __func__);
 
+	__raw_writel(__raw_readl(S5P_OTHERS) | (1<<31) | (1<<30) | (1<<29) |
+		(1<<28), S5P_OTHERS);
+
+	/* WAKEUP STAT */
+	printk(KERN_INFO "Wakeup Stat: %8.8xh\n", __raw_readl(S5P_WAKEUP_STAT));
+
 	/* LEDs should now be 1110 */
 	s3c_pm_debug_smdkled(1 << 1, 0);
 
 	s3c_pm_check_restore();
 
+	/* If ext int is the wakeup source... */
+	if (__raw_readl(S5P_WAKEUP_STAT) & 0x01) { /* EXTINT */
+		/* If HOME or HOLD key pressed, trigger an event manually */
+
+		S3C_PMDBG("EXT INT SOURCE = %2.2x %2.2x %2.2x %2.2x\n",
+				__raw_readl(S5P_WKUP_INT_PEND24_31),
+				__raw_readl(S5P_WKUP_INT_PEND16_23),
+				__raw_readl(S5P_WKUP_INT_PEND8_15),
+				__raw_readl(S5P_WKUP_INT_PEND0_7));
+
+		s3c_pm_wakeup_source_set(__raw_readl(S5P_WAKEUP_STAT),
+				__raw_readl(S5P_WKUP_INT_PEND24_31)<<24 |
+				__raw_readl(S5P_WKUP_INT_PEND16_23)<<16 |
+				__raw_readl(S5P_WKUP_INT_PEND8_15)<<8 |
+				__raw_readl(S5P_WKUP_INT_PEND0_7)<<0);
+	}
+	else
+		s3c_pm_wakeup_source_set(__raw_readl(S5P_WAKEUP_STAT), 0);
+
 	/* ok, let's return from sleep */
 
 	S3C_PMDBG("S3C PM Resume (post-restore)\n");
@@ -353,11 +411,14 @@ static int s3c_pm_prepare(void)
 static void s3c_pm_finish(void)
 {
 	s3c_pm_check_cleanup();
+
+	if (pm_cpu_finish)
+		pm_cpu_finish();
 }
 
 static struct platform_suspend_ops s3c_pm_ops = {
-	.enter		= s3c_pm_enter,
 	.prepare	= s3c_pm_prepare,
+	.enter		= s3c_pm_enter,
 	.finish		= s3c_pm_finish,
 	.valid		= suspend_valid_only_mem,
 };
-- 
1.6.3.3
