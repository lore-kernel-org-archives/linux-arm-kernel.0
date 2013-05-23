From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 23 May 2013 15:30:54 +0200
Subject: [PATCH v2 6/6] arm: mvebu: support new bootloaders shipped by Marvell
In-Reply-To: <1369315854-32724-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369315854-32724-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369315854-32724-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Marvell platforms, the "internal registers" is a window of 1 MB of
the physical address space that contains all the registers for the
various peripherals of the SoC (timers, interrupt controllers, GPIO
controllers, Ethernet, etc.). The base address of this 1 MB window is
configurable, and this base address is configured using a register
that is itself part of this window.

All earlier families of Marvell EBU SoCs supported by Linux used
0xf1000000 as the base address of the internal registers window. For
some reason, early versions of the Marvell 370/XP platforms used
0xd0000000 as the base address. This base address is set up by the
bootloader. However, in order to keep as much physical address space
to address RAM below the 4 GB limit, Marvell had to switch the base
address of the internal registers window back to 0xf1000000.

All the new bootloaders shipped by Marvell remap those registers to
0xf1000000. This commit adapts the kernel Device Tree and other
definitions so that it can boot with such bootloaders.

However, since those changing are breaking the compatibility with old
bootloader (resulting in a kernel that crashes without displaying any
message), we have implement a temporary solution for users of an old
bootloader.

One particular bit of a CP15 register has been chosen to indicate
whether we use an old bootloader (setting the address at 0xd0000000)
or a new bootloader (setting the address at 0xf1000000). In the
->map_io() function, when the bit is already set, there is nothing to
do, we are already using a new bootloader and internal registers are
at 0xf1000000.

However, when the bit is not set, we do a static mapping of the
register area that allows to change the internal register address, we
change this address, and set this bit.

Note that this mechanism also needs cooperation from the earlyprintk
addruart handler (in arch/arm/include/debug/mvebu.S). This is where
things get complex: the CP15 bit that has been chosen gets reset to
zero at the first call to the 'wfi' instruction. So it cannot be used
during the entire life of the system. Instead, whenever the ->map_io()
function has switched to the internal register space to the new
address, it sets a global variable 'mvebu_switched_regs', which the
earlyprintk reads. If it's true, then the move has already been done
and there is no need to read the CP15 register. If
'mvebu_switched_regs' is false, we are before the register move, so we
need to read the CP15 bit to find out whether we're being booted from
an old bootloader (which mapped the register space at 0xd0000000) or a
new bootloader (which mapped the register space at 0xf1000000).

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi |    2 +-
 arch/arm/boot/dts/armada-370.dtsi    |    3 +-
 arch/arm/boot/dts/armada-xp-gp.dts   |    2 +-
 arch/arm/include/debug/mvebu.S       |   77 +++++++++++++++++++++++--
 arch/arm/mach-mvebu/armada-370-xp.c  |  105 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/armada-370-xp.h  |    2 +-
 6 files changed, 181 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 52a1f5e..95ec049 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -33,7 +33,7 @@
 		#size-cells = <1>;
 		compatible = "simple-bus";
 		interrupt-parent = <&mpic>;
-		ranges = <0          0 0xd0000000 0x0100000 /* internal registers */
+		ranges = <0          0 0xf1000000 0x0100000 /* internal registers */
 			  0xe0000000 0 0xe0000000 0x8100000 /* PCIe */>;
 
 		internal-regs {
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index aee2b18..030e425 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -29,8 +29,9 @@
 	};
 
 	soc {
-		ranges = <0          0xd0000000 0x0100000 /* internal registers */
+		ranges = <0          0xf1000000 0x0100000 /* internal registers */
 			  0xe0000000 0xe0000000 0x8100000 /* PCIe */>;
+
 		internal-regs {
 			system-controller at 18200 {
 				compatible = "marvell,armada-370-xp-system-controller";
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 3ee63d1..8fb1679 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -39,7 +39,7 @@
 	};
 
 	soc {
-		ranges = <0          0 0xd0000000 0x100000
+		ranges = <0          0 0xf1000000 0x100000
 			  0xf0000000 0 0xf0000000 0x1000000>;
 
 		internal-regs {
diff --git a/arch/arm/include/debug/mvebu.S b/arch/arm/include/debug/mvebu.S
index df191af..ec875c4 100644
--- a/arch/arm/include/debug/mvebu.S
+++ b/arch/arm/include/debug/mvebu.S
@@ -5,20 +5,85 @@
  *
  * Lior Amsalem <alior@marvell.com>
  * Gregory Clement <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
 
-#define ARMADA_370_XP_REGS_PHYS_BASE	0xd0000000
-#define ARMADA_370_XP_REGS_VIRT_BASE	0xfec00000
+#define ARMADA_370_XP_UART_PHYS_BASE_OLD	0xd0012000
+#define ARMADA_370_XP_UART_PHYS_BASE_NEW	0xf1012000
+#define ARMADA_370_XP_UART_VIRT_BASE_OLD	0xfec12000
+#define ARMADA_370_XP_UART_VIRT_BASE_NEW	0xfea12000
 
 	.macro	addruart, rp, rv, tmp
-	ldr	\rp, =ARMADA_370_XP_REGS_PHYS_BASE
-	ldr	\rv, =ARMADA_370_XP_REGS_VIRT_BASE
-	orr	\rp, \rp, #0x00012000
-	orr	\rv, \rv, #0x00012000
+
+#ifndef ZIMAGE
+	/*
+	 * This loads the value of mvebu_switched_regs. We need a
+	 * little bit of gymnastic here to handle the fact that the
+	 * addruart code is duplicated in different places, and called
+	 * sometimes with the MMU disabled, sometimes the MMU enabled.
+	 *
+	 * Notice that when this earlyprintk code is linked into the
+	 * kernel decompressor (i.e ZIMAGE is defined), this code isn't
+	 * compiled. The reason is because the global mvebu_switched_regs
+	 * variable is not available in the decompressor code. At this
+	 * early stage, we simply test the CP15 bit (below) to know where
+	 * the internal registers are.
+	 */
+	adr	\rp, addruart_switched_regs_\@
+	ldr	\rv, [\rp]
+	sub	\rv, \rv, \rp
+	ldr	\rp, [\rp, #4]
+	sub	\tmp, \rp, \rv
+	ldr	\rp, [\tmp, #0]
+	cmp	\rp, #0
+
+	/* If we have already switched, then use the new register
+	   address */
+	bne	addruart_new_\@
+#endif
+
+	/*
+	 * We haven't switched the register location, so test the CP15
+	 * register bit to find whether we are:
+	 * - with an old bootloader setting the base address to
+	 *   0xd0000000
+	 * - with a new bootloader that has already set the
+	 *   base address to 0xf1000000
+	 * We adapt the physical address returned depending on the
+	 * value of this bit, but also the virtual address, because we
+	 * can't remap the old physical address and the new physical
+	 * address at the same location.
+	 */
+	mrc	p15, 0, \tmp, c5, c0, 0
+	and	\tmp, \tmp, #(1 << 11)
+	cmp	\tmp, #0
+	bne	addruart_new_\@
+
+addruart_old_\@:
+	ldr	\rp, =ARMADA_370_XP_UART_PHYS_BASE_OLD
+	ldr	\rv, =ARMADA_370_XP_UART_VIRT_BASE_OLD
+	b	addruart_out_\@
+addruart_new_\@:
+	ldr	\rp, =ARMADA_370_XP_UART_PHYS_BASE_NEW
+	ldr	\rv, =ARMADA_370_XP_UART_VIRT_BASE_NEW
+	b	addruart_out_\@
+
+#ifndef ZIMAGE
+	/*
+	 * Global variable mvebu_switched_regs not visible in the
+	 * decompressor code
+	 */
+	.align
+addruart_switched_regs_\@:
+	.long	.
+	.long	mvebu_switched_regs
+#endif
+
+addruart_out_\@:
 	.endm
 
 #define UART_SHIFT	2
diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index c1c0556..752eedd 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -28,8 +28,113 @@
 #include "common.h"
 #include "coherency.h"
 
+/*
+ * Note on the internal register address.
+ *
+ * On Marvell platforms, the "internal registers" is a window of 1 MB
+ * of the physical address space that contains all the registers for
+ * the various peripherals of the SoC (timers, interrupt controllers,
+ * GPIO controllers, Ethernet, etc.). The base address of this 1 MB
+ * window is configurable, and this base address is configured using a
+ * register that is itself part of this window.
+ *
+ * All earlier families of Marvell EBU SoCs supported by Linux used
+ * 0xf1000000 as the base address of the internal registers
+ * window. For some reason, early versions of the Marvell 370/XP
+ * platforms used 0xd0000000 as the base address. This base address is
+ * set up by the bootloader. However, in order to keep as much
+ * physical address space to address RAM below the 4 GB limit, we had
+ * to switch the base address of the internal registers window back to
+ * 0xf1000000, and we wanted to achieve that without breaking existing
+ * platforms, where the bootloader was initially setting the base
+ * address to 0xd0000000. So the kernel is responsible for switching
+ * to 0xf1000000 when needed.
+ *
+ * One particular bit of a CP15 register has been chosen to indicate
+ * whether we use an old bootloader (setting the address at
+ * 0xd0000000) or a new bootloader (setting the address at
+ * 0xf1000000). In the ->map_io() function, when the bit is already
+ * set, there is nothing to do, we are already using a new bootloader
+ * and internal registers are at 0xf1000000.
+ *
+ * However, when the bit is not set, we do a static mapping of the
+ * register area that allows to change the internal register address
+ * and we change this address.
+ *
+ * Once those steps are done, we set a global variable,
+ * mvebu_switched_regs, that tells the earlyprintk code how to
+ * behave. Note that this mechanism also needs cooperation from the
+ * earlyprintk addruart handler (in arch/arm/include/debug/mvebu.S).
+ */
+
+#define NEW_INTERNAL_REGS_ADDR  0xf1000000
+#define OLD_INTERNAL_REGS_ADDR  0xd0000000
+#define MBUS_OLD_PHYS_ADDR      (OLD_INTERNAL_REGS_ADDR + 0x20000)
+#define MBUS_OLD_VIRT_ADDR      0xfe9ff000
+#define  MBUS_INTERNAL_REGS_ADDR      0x80
+
+/*
+ * We really want this variable to be part of the .data section,
+ * because it gets accessed by the earlyprintk code before BSS gets
+ * initialized to zero. This variable indicates whether the switch to
+ * the new register has taken place or not. It is needed because the
+ * CP15 bit used by the bootloader to tell the kernel where the
+ * registers are mapped is cleared to 0 at the first 'wfi'
+ * instruction. So we can't use it for the entire life of the system,
+ * and we instead use this boolean to indicate to the earlyprintk code
+ * that the switch has occured and it doesn't need to look at the CP15
+ * bit anymore.
+ */
+unsigned int __section(.data) mvebu_switched_regs = 0;
+
+/*
+ * Detect if we're running an old bootloader that has set the physical
+ * base address of internal registers to 0xd0000000
+ */
+static int armada_370_xp_has_old_bootloader(void)
+{
+	u32 val;
+	asm volatile("mrc p15, 0, %0, c5, c0, 0" : "=r"(val));
+	return !(val & BIT(11));
+}
+
 static void __init armada_370_xp_map_io(void)
 {
+	if (armada_370_xp_has_old_bootloader()) {
+		struct map_desc desc;
+		void __iomem *mbus = IOMEM(MBUS_OLD_VIRT_ADDR);
+
+		desc.virtual = MBUS_OLD_VIRT_ADDR;
+		desc.pfn     = __phys_to_pfn(MBUS_OLD_PHYS_ADDR);
+		desc.length  = PAGE_SIZE;
+		desc.type    = MT_DEVICE;
+
+		/*
+		 * Map the area that contains the registers that
+		 * allows to change the base address of internal
+		 * registers.
+		 */
+		iotable_init(&desc, 1);
+
+		/*
+		 * Change the physical base address of the
+		 * registers. From now on, and until
+		 * debug_ll_io_init() is called below, it is not
+		 * possible to do any print, because using earlyprintk
+		 * would lead to memory writes to the old internal
+		 * registers, which would hang the CPU.
+		 */
+		writel(NEW_INTERNAL_REGS_ADDR, mbus + MBUS_INTERNAL_REGS_ADDR);
+	}
+
+	/*
+	 * Either the registers have been switched by the above code,
+	 * or the bootloader had already set the register space at the
+	 * right location. In both cases, tell the earlyprintk code it
+	 * can now use the new location.
+	 */
+	mvebu_switched_regs = 1;
+
 	debug_ll_io_init();
 }
 
diff --git a/arch/arm/mach-mvebu/armada-370-xp.h b/arch/arm/mach-mvebu/armada-370-xp.h
index 585e147..ff9adc4 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.h
+++ b/arch/arm/mach-mvebu/armada-370-xp.h
@@ -15,7 +15,7 @@
 #ifndef __MACH_ARMADA_370_XP_H
 #define __MACH_ARMADA_370_XP_H
 
-#define ARMADA_370_XP_REGS_PHYS_BASE	0xd0000000
+#define ARMADA_370_XP_REGS_PHYS_BASE	0xf1000000
 
 /* These defines can go away once mvebu-mbus has a DT binding */
 #define ARMADA_370_XP_MBUS_WINS_BASE    (ARMADA_370_XP_REGS_PHYS_BASE + 0x20000)
-- 
1.7.9.5
