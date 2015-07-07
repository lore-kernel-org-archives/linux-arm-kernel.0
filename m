From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  7 Jul 2015 16:10:16 +0200
Subject: [PATCH/RFC 10/11] ARM: shmobile: rcar-gen2: Use syscon to configure
 the CPG
In-Reply-To: <1436278217-20522-1-git-send-email-geert+renesas@glider.be>
References: <1436278217-20522-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1436278217-20522-11-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the R-Car Gen2 CPG clock driver rely on syscon to read the Mode
Monitoring Register (MODEMR), instead of passing the register value
directly.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/Kconfig           | 1 +
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 26a036c3ab522128..37faf6e18d26344f 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -23,6 +23,7 @@ config ARCH_RCAR_GEN2
 	select SYS_SUPPORTS_SH_CMT
 	select PCI_DOMAINS if PCI
 	select HAVE_ARM_ARCH_TIMER
+	select MFD_SYSCON
 
 config ARCH_RMOBILE
 	bool
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 570d6bd3784f7464..7a845f4829081cd9 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -15,6 +15,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/clk-provider.h>
 #include <linux/clk/shmobile.h>
 #include <linux/clocksource.h>
 #include <linux/device.h>
@@ -125,7 +126,7 @@ void __init rcar_gen2_timer_init(void)
 
 	iounmap(base);
 
-	rcar_gen2_clocks_init(mode);
+	of_clk_init(NULL);
 	clocksource_of_init();
 }
 
-- 
1.9.1
