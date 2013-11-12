From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Nov 2013 14:47:41 +0100
Subject: [PATCH 1/7] ARM: sa1100: switch to MULTI_IRQ_HANDLER
Message-ID: <1384264061-6174-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This rewrites the entry-macro for the SA1100 in C and selects
MULTI_IRQ_HANDLER for this platform, creates a local struct for
two of the irq_chips in the SA1100 irq controller, and uses
an irqdomain to map the 32 non-cascaded IRQs on this platform.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                                |   2 +
 arch/arm/mach-sa1100/assabet.c                  |   1 +
 arch/arm/mach-sa1100/badge4.c                   |   1 +
 arch/arm/mach-sa1100/cerf.c                     |   1 +
 arch/arm/mach-sa1100/collie.c                   |   1 +
 arch/arm/mach-sa1100/generic.h                  |   3 +
 arch/arm/mach-sa1100/h3100.c                    |   1 +
 arch/arm/mach-sa1100/h3600.c                    |   1 +
 arch/arm/mach-sa1100/hackkit.c                  |   1 +
 arch/arm/mach-sa1100/include/mach/entry-macro.S |  41 ---------
 arch/arm/mach-sa1100/irq.c                      | 112 ++++++++++++++++--------
 arch/arm/mach-sa1100/jornada720.c               |   1 +
 arch/arm/mach-sa1100/lart.c                     |   1 +
 arch/arm/mach-sa1100/nanoengine.c               |   1 +
 arch/arm/mach-sa1100/pleb.c                     |   1 +
 arch/arm/mach-sa1100/shannon.c                  |   1 +
 arch/arm/mach-sa1100/simpad.c                   |   1 +
 17 files changed, 93 insertions(+), 78 deletions(-)
 delete mode 100644 arch/arm/mach-sa1100/include/mach/entry-macro.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c0c4ea0582f..dedca8a21e77 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -687,7 +687,9 @@ config ARCH_SA1100
 	select CPU_SA1100
 	select GENERIC_CLOCKEVENTS
 	select HAVE_IDE
+	select IRQ_DOMAIN
 	select ISA
+	select MULTI_IRQ_HANDLER
 	select NEED_MACH_MEMORY_H
 	select SPARSE_IRQ
 	help
diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index e838ba27e443..e0285a9581de 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -622,6 +622,7 @@ MACHINE_START(ASSABET, "Intel-Assabet")
 	.map_io		= assabet_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_time	= sa1100_timer_init,
 	.init_machine	= assabet_init,
 	.init_late	= sa11x0_init_late,
diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index 63361b6d04e9..acbaae4cae5b 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -335,6 +335,7 @@ MACHINE_START(BADGE4, "Hewlett-Packard Laboratories BadgePAD 4")
 	.map_io		= badge4_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_late	= sa11x0_init_late,
 	.init_time	= sa1100_timer_init,
 #ifdef CONFIG_SA1111
diff --git a/arch/arm/mach-sa1100/cerf.c b/arch/arm/mach-sa1100/cerf.c
index 2d25ececb415..cad0ada8ff2c 100644
--- a/arch/arm/mach-sa1100/cerf.c
+++ b/arch/arm/mach-sa1100/cerf.c
@@ -174,6 +174,7 @@ MACHINE_START(CERF, "Intrinsyc CerfBoard/CerfCube")
 	.map_io		= cerf_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= cerf_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_time	= sa1100_timer_init,
 	.init_machine	= cerf_init,
 	.init_late	= sa11x0_init_late,
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index 7fb96ebdc0fb..3e26ddc2c8d8 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -399,6 +399,7 @@ MACHINE_START(COLLIE, "Sharp-Collie")
 	.map_io		= collie_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_time	= sa1100_timer_init,
 	.init_machine	= collie_init,
 	.init_late	= sa11x0_init_late,
diff --git a/arch/arm/mach-sa1100/generic.h b/arch/arm/mach-sa1100/generic.h
index 9a33695c9492..f382e1258c5b 100644
--- a/arch/arm/mach-sa1100/generic.h
+++ b/arch/arm/mach-sa1100/generic.h
@@ -5,8 +5,11 @@
  */
 #include <linux/reboot.h>
 
+struct pt_regs;
+
 extern void sa1100_timer_init(void);
 extern void __init sa1100_map_io(void);
+extern void sa1100_handle_irq(struct pt_regs *regs);
 extern void __init sa1100_init_irq(void);
 extern void __init sa1100_init_gpio(void);
 extern void sa11x0_restart(enum reboot_mode, const char *);
diff --git a/arch/arm/mach-sa1100/h3100.c b/arch/arm/mach-sa1100/h3100.c
index b8f2b151539b..5ab169d566a7 100644
--- a/arch/arm/mach-sa1100/h3100.c
+++ b/arch/arm/mach-sa1100/h3100.c
@@ -108,6 +108,7 @@ MACHINE_START(H3100, "Compaq iPAQ H3100")
 	.map_io		= h3100_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_time	= sa1100_timer_init,
 	.init_machine	= h3100_mach_init,
 	.init_late	= sa11x0_init_late,
diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index b8dc5bd22623..7209c0e0a173 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -158,6 +158,7 @@ MACHINE_START(H3600, "Compaq iPAQ H3600")
 	.map_io		= h3600_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_time	= sa1100_timer_init,
 	.init_machine	= h3600_mach_init,
 	.init_late	= sa11x0_init_late,
diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index 643d5f2d9af9..1998805a9610 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -229,6 +229,7 @@ MACHINE_START(HACKKIT, "HackKit Cpu Board")
 	.map_io		= hackkit_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_time	= sa1100_timer_init,
 	.init_machine	= hackkit_init,
 	.init_late	= sa11x0_init_late,
diff --git a/arch/arm/mach-sa1100/include/mach/entry-macro.S b/arch/arm/mach-sa1100/include/mach/entry-macro.S
deleted file mode 100644
index 8cf7630bf024..000000000000
--- a/arch/arm/mach-sa1100/include/mach/entry-macro.S
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * arch/arm/mach-sa1100/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for SA1100-based platforms
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-		.macro  get_irqnr_preamble, base, tmp
-		mov	\base, #0xfa000000		@ ICIP = 0xfa050000
-		add	\base, \base, #0x00050000
-		.endm
-
-		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr	\irqstat, [\base]		@ get irqs
-		ldr	\irqnr, [\base, #4]		@ ICMR = 0xfa050004
-		ands	\irqstat, \irqstat, \irqnr
-		mov	\irqnr, #0
-		beq	1001f
-		tst	\irqstat, #0xff
-		moveq	\irqstat, \irqstat, lsr #8
-		addeq	\irqnr, \irqnr, #8
-		tsteq	\irqstat, #0xff
-		moveq	\irqstat, \irqstat, lsr #8
-		addeq	\irqnr, \irqnr, #8
-		tsteq	\irqstat, #0xff
-		moveq	\irqstat, \irqstat, lsr #8
-		addeq	\irqnr, \irqnr, #8
-		tst	\irqstat, #0x0f
-		moveq	\irqstat, \irqstat, lsr #4
-		addeq	\irqnr, \irqnr, #4
-		tst	\irqstat, #0x03
-		moveq	\irqstat, \irqstat, lsr #2
-		addeq	\irqnr, \irqnr, #2
-		tst	\irqstat, #0x01
-		addeqs	\irqnr, \irqnr, #1
-1001:
-		.endm
-
diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 2124f1fc2fbe..15fd8a580391 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -16,13 +16,15 @@
 #include <linux/irq.h>
 #include <linux/ioport.h>
 #include <linux/syscore_ops.h>
+#include <linux/irqdomain.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <asm/mach/irq.h>
 
-#include "generic.h"
+#include <asm/exception.h>
+#include <asm/irq.h>
 
+#include "generic.h"
 
 /*
  * SA1100 GPIO edge detection for IRQs:
@@ -96,15 +98,6 @@ static int sa1100_low_gpio_wake(struct irq_data *d, unsigned int on)
 	return 0;
 }
 
-static struct irq_chip sa1100_low_gpio_chip = {
-	.name		= "GPIO-l",
-	.irq_ack	= sa1100_low_gpio_ack,
-	.irq_mask	= sa1100_low_gpio_mask,
-	.irq_unmask	= sa1100_low_gpio_unmask,
-	.irq_set_type	= sa1100_gpio_type,
-	.irq_set_wake	= sa1100_low_gpio_wake,
-};
-
 /*
  * IRQ11 (GPIO11 through 27) handler.  We enter here with the
  * irq_controller_lock held, and IRQs disabled.  Decode the IRQ
@@ -215,14 +208,74 @@ static int sa1100_set_wake(struct irq_data *d, unsigned int on)
 	return -EINVAL;
 }
 
-static struct irq_chip sa1100_normal_chip = {
-	.name		= "SC",
-	.irq_ack	= sa1100_mask_irq,
-	.irq_mask	= sa1100_mask_irq,
-	.irq_unmask	= sa1100_unmask_irq,
-	.irq_set_wake	= sa1100_set_wake,
+/**
+ * struct sa1100_sc - SA1100 interrupt controller
+ * @domain: irqdomain used to map the irqs for these chips
+ * @low_gpio_chip: irqchip to handle hardware IRQs 0-10
+ * @normal_chip: irqchip to handle hardware IRQs 12-31
+ */
+struct sa1100_sc {
+	struct irq_domain *domain;
+	struct irq_chip low_gpio_chip;
+	struct irq_chip normal_chip;
+};
+
+static struct sa1100_sc sa1100_sc = {
+	.low_gpio_chip = {
+		.name		= "GPIO-l",
+		.irq_ack	= sa1100_low_gpio_ack,
+		.irq_mask	= sa1100_low_gpio_mask,
+		.irq_unmask	= sa1100_low_gpio_unmask,
+		.irq_set_type	= sa1100_gpio_type,
+		.irq_set_wake	= sa1100_low_gpio_wake,
+	},
+	.normal_chip = {
+		.name		= "SC",
+		.irq_ack	= sa1100_mask_irq,
+		.irq_mask	= sa1100_mask_irq,
+		.irq_unmask	= sa1100_unmask_irq,
+		.irq_set_wake	= sa1100_set_wake,
+	},
+};
+
+asmlinkage void __exception_irq_entry sa1100_handle_irq(struct pt_regs *regs)
+{
+	struct sa1100_sc *sc = &sa1100_sc;
+	u32 status;
+	int irq;
+
+	while ((status = (ICIP & ICMR))) {
+		irq = ffs(status) - 1;
+		handle_IRQ(irq_find_mapping(sc->domain, irq), regs);
+	}
+}
+
+static int sa1100_sc_irqdomain_map(struct irq_domain *d, unsigned int irq,
+				   irq_hw_number_t hwirq)
+{
+	struct sa1100_sc *sc = d->host_data;
+
+	irq_set_chip_data(irq, sc);
+	if (hwirq >= 0 && hwirq <= 10)
+		irq_set_chip_and_handler(irq, &sc->low_gpio_chip,
+					 handle_edge_irq);
+	if (hwirq == 11) { /* IRQ_GPIO11_27 */
+		irq_set_chip(irq, &sc->normal_chip);
+		irq_set_chained_handler(irq, sa1100_high_gpio_handler);
+	}
+	if (hwirq >= 12 && hwirq <= 31)
+		irq_set_chip_and_handler(irq, &sc->normal_chip,
+					 handle_level_irq);
+	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+	return 0;
+}
+
+static struct irq_domain_ops sa1100_sc_irqdomain_ops = {
+	.map = sa1100_sc_irqdomain_map,
+	.xlate = irq_domain_xlate_onetwocell,
 };
 
+
 static struct resource irq_resource =
 	DEFINE_RES_MEM_NAMED(0x90050000, SZ_64K, "irqs");
 
@@ -254,7 +307,7 @@ static int sa1100irq_suspend(void)
 	 */
 	GRER = PWER & GPIO_IRQ_rising_edge;
 	GFER = PWER & GPIO_IRQ_falling_edge;
-	
+
 	/*
 	 * Clear any pending GPIO interrupts.
 	 */
@@ -294,6 +347,7 @@ device_initcall(sa1100irq_init_devicefs);
 void __init sa1100_init_irq(void)
 {
 	unsigned int irq;
+	struct sa1100_sc *sc = &sa1100_sc;
 
 	request_resource(&iomem_resource, &irq_resource);
 
@@ -314,29 +368,13 @@ void __init sa1100_init_irq(void)
 	 */
 	ICCR = 1;
 
-	for (irq = 0; irq <= 10; irq++) {
-		irq_set_chip_and_handler(irq, &sa1100_low_gpio_chip,
-					 handle_edge_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-	}
-
-	for (irq = 12; irq <= 31; irq++) {
-		irq_set_chip_and_handler(irq, &sa1100_normal_chip,
-					 handle_level_irq);
-		set_irq_flags(irq, IRQF_VALID);
-	}
-
+	/* Register IRQs 0-31 using a legacy irqdomain */
+	sc->domain = irq_domain_add_legacy(NULL, 32, 0, 0,
+					   &sa1100_sc_irqdomain_ops, sc);
 	for (irq = 32; irq <= 48; irq++) {
 		irq_set_chip_and_handler(irq, &sa1100_high_gpio_chip,
 					 handle_edge_irq);
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 	}
-
-	/*
-	 * Install handler for GPIO 11-27 edge detect interrupts
-	 */
-	irq_set_chip(IRQ_GPIO11_27, &sa1100_normal_chip);
-	irq_set_chained_handler(IRQ_GPIO11_27, sa1100_high_gpio_handler);
-
 	sa1100_init_gpio();
 }
diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index c0b1f5bafae4..74d5894d1e67 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -346,6 +346,7 @@ MACHINE_START(JORNADA720, "HP Jornada 720")
 	.map_io		= jornada720_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_time	= sa1100_timer_init,
 	.init_machine	= jornada720_mach_init,
 	.init_late	= sa11x0_init_late,
diff --git a/arch/arm/mach-sa1100/lart.c b/arch/arm/mach-sa1100/lart.c
index 51b0eb52c014..2f3c8a14f34d 100644
--- a/arch/arm/mach-sa1100/lart.c
+++ b/arch/arm/mach-sa1100/lart.c
@@ -169,6 +169,7 @@ MACHINE_START(LART, "LART")
 	.map_io		= lart_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_machine	= lart_init,
 	.init_late	= sa11x0_init_late,
 	.init_time	= sa1100_timer_init,
diff --git a/arch/arm/mach-sa1100/nanoengine.c b/arch/arm/mach-sa1100/nanoengine.c
index f1cb3784d525..b35b1cae5785 100644
--- a/arch/arm/mach-sa1100/nanoengine.c
+++ b/arch/arm/mach-sa1100/nanoengine.c
@@ -110,6 +110,7 @@ MACHINE_START(NANOENGINE, "BSE nanoEngine")
 	.map_io		= nanoengine_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_time	= sa1100_timer_init,
 	.init_machine	= nanoengine_init,
 	.init_late	= sa11x0_init_late,
diff --git a/arch/arm/mach-sa1100/pleb.c b/arch/arm/mach-sa1100/pleb.c
index 091261878eff..f35c4d909a35 100644
--- a/arch/arm/mach-sa1100/pleb.c
+++ b/arch/arm/mach-sa1100/pleb.c
@@ -133,6 +133,7 @@ MACHINE_START(PLEB, "PLEB")
 	.map_io		= pleb_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_time	= sa1100_timer_init,
 	.init_machine   = pleb_init,
 	.init_late	= sa11x0_init_late,
diff --git a/arch/arm/mach-sa1100/shannon.c b/arch/arm/mach-sa1100/shannon.c
index c8866bce7386..975dc9560442 100644
--- a/arch/arm/mach-sa1100/shannon.c
+++ b/arch/arm/mach-sa1100/shannon.c
@@ -102,6 +102,7 @@ MACHINE_START(SHANNON, "Shannon (AKA: Tuxscreen)")
 	.map_io		= shannon_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_time	= sa1100_timer_init,
 	.init_machine	= shannon_init,
 	.init_late	= sa11x0_init_late,
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index 41e476e571d7..f40b07e25bca 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -396,6 +396,7 @@ MACHINE_START(SIMPAD, "Simpad")
 	.map_io		= simpad_map_io,
 	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
+	.handle_irq	= sa1100_handle_irq,
 	.init_late	= sa11x0_init_late,
 	.init_time	= sa1100_timer_init,
 	.restart	= sa11x0_restart,
-- 
1.8.3.1
