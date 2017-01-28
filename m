From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 28 Jan 2017 23:33:32 +0100
Subject: [PATCH 12/22 v2] ARM: gemini: DT for the Cortina Gemini SoC platforms
Message-ID: <20170128223332.25098-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds initial and compulsory device tree support to the
Gemini ARMv4 platform.

We are selecting a bunch of "absolute minimals" for getting a working
system up with just device tree:

- We select USE_OF for natural reasons or nothing works.

- We select CLKSRC_OF and GEMINI_TIMER so we get timekeeping from
  the clocksource.

- We select GPIO_GEMINI because these are used as irqchips, and
  for a generic driver it is not reasonable for those to have to
  select every possible irqchip in the world to work, the platform
  should simply provide the available irqchips.

- We select a UART that can be exprected to work with
  SERIAL_OF_PLATFORM which is the name for an 8250 OF-probed
  serial port.

- We select the syscon-based reset controller: it's not fun when
  "reboot" doesn't work because of Kconfig, so we just select
  POWER_RESET and POWER_RESET_SYSCON.

- We perhaps a bit controversiallt select ARM_APPENDED_DTB, because
  this platform is using the ancient RedBoot, and can *NOT* be
  expected to upgrade its bootloaders. Appended device tree is
  simply how these devices have to work with device tree.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Just use CONFIG_DEBUG_UART_PHYS / CONFIG_DEBUG_UART_VIRT directly
  in the iomap, works like a charm and saves more hardcoded constants.
  We have to add an ifedf for debugging but that should be fine.
---
 arch/arm/Kconfig                |  8 ++++++++
 arch/arm/mach-gemini/Makefile   |  2 +-
 arch/arm/mach-gemini/board-dt.c | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-gemini/board-dt.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 63e61bf5aab0..b4a42d599e2c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -355,11 +355,19 @@ config ARM_SINGLE_ARMV7M
 
 config ARCH_GEMINI
 	bool "Cortina Systems Gemini"
+	select ARM_APPENDED_DTB # Old Redboot bootloaders deployed
 	select CLKSRC_MMIO
+	select CLKSRC_OF
 	select CPU_FA526
+	select GEMINI_TIMER
 	select GENERIC_CLOCKEVENTS
+	select GPIO_GEMINI
 	select GPIOLIB
 	select MULTI_IRQ_HANDLER
+	select POWER_RESET
+	select POWER_RESET_SYSCON
+	select SERIAL_OF_PLATFORM
+	select USE_OF
 	help
 	  Support for the Cortina Systems Gemini family SoCs
 
diff --git a/arch/arm/mach-gemini/Makefile b/arch/arm/mach-gemini/Makefile
index 7963a77be637..11f07fb6ec3d 100644
--- a/arch/arm/mach-gemini/Makefile
+++ b/arch/arm/mach-gemini/Makefile
@@ -4,7 +4,7 @@
 
 # Object file lists.
 
-obj-y			:= irq.o mm.o time.o devices.o gpio.o idle.o reset.o
+obj-y			:= irq.o mm.o time.o devices.o gpio.o idle.o reset.o board-dt.o
 
 # Board-specific support
 obj-$(CONFIG_MACH_NAS4220B)	+= board-nas4220b.o
diff --git a/arch/arm/mach-gemini/board-dt.c b/arch/arm/mach-gemini/board-dt.c
new file mode 100644
index 000000000000..208ea99cdc47
--- /dev/null
+++ b/arch/arm/mach-gemini/board-dt.c
@@ -0,0 +1,38 @@
+/*
+ * Gemini Device Tree boot support
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#ifdef CONFIG_DEBUG_GEMINI
+/* This is needed for LL-debug/earlyprintk/debug-macro.S */
+static struct map_desc gemini_io_desc[] __initdata = {
+	{
+		.virtual = CONFIG_DEBUG_UART_VIRT,
+		.pfn = __phys_to_pfn(CONFIG_DEBUG_UART_PHYS),
+		.length = SZ_4K,
+		.type = MT_DEVICE,
+	},
+};
+
+static void __init gemini_map_io(void)
+{
+	iotable_init(gemini_io_desc, ARRAY_SIZE(gemini_io_desc));
+}
+#else
+#define gemini_map_io NULL
+#endif
+
+static const char *gemini_board_compat[] = {
+	"cortina,gemini",
+	NULL,
+};
+
+DT_MACHINE_START(GEMINI_DT, "Gemini (Device Tree)")
+	.map_io		= gemini_map_io,
+	.dt_compat	= gemini_board_compat,
+MACHINE_END
-- 
2.9.3
