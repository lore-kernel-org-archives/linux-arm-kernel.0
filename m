From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 19 Mar 2013 00:10:12 +0900
Subject: [PATCH 02/03] ARM: shmobile: APE6EVM PFC support
In-Reply-To: <20130318150953.28231.73454.sendpatchset@w520>
References: <20130318150953.28231.73454.sendpatchset@w520>
Message-ID: <20130318151012.28231.95680.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Start using the r8a73a4 PFC on the APE6EVM board
and configure the SCIFA0 console signals using
the PFC.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against "next" renesas.git 811689afc214564c4a5f238ecf4d8bdc0e52b615
 
 Depends on the following two series:
 [PATCH 00/04] ARM: shmobile: r8a73a4 SoC support V2
 [PATCH 00/02] sh-pfc: Initial r8a73a4 PFC support

 arch/arm/mach-shmobile/Kconfig         |    1 +
 arch/arm/mach-shmobile/board-ape6evm.c |    7 +++++++
 2 files changed, 8 insertions(+)

--- 0009/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-03-18 22:12:56.000000000 +0900
@@ -82,6 +82,7 @@ config MACH_AG5EVM
 config MACH_APE6EVM
 	bool "APE6EVM board"
 	depends on ARCH_R8A73A4
+	select ARCH_REQUIRE_GPIOLIB
 	select USE_OF
 
 config MACH_MACKEREL
--- 0009/arch/arm/mach-shmobile/board-ape6evm.c
+++ work/arch/arm/mach-shmobile/board-ape6evm.c	2013-03-18 22:05:03.000000000 +0900
@@ -18,6 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/kernel.h>
@@ -30,6 +31,12 @@
 static void __init ape6evm_add_standard_devices(void)
 {
 	r8a73a4_clock_init();
+	r8a73a4_pinmux_init();
+
+	/* SCIFA0 console */
+	gpio_request(GPIO_FN_SCIFA0_TXD, NULL);
+	gpio_request(GPIO_FN_SCIFA0_RXD, NULL);
+
 	r8a73a4_add_standard_devices();
 }
 
