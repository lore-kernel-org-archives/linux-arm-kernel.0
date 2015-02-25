From: ezequiel.garcia@imgtec.com (Ezequiel Garcia)
Date: Wed, 25 Feb 2015 08:45:14 -0300
Subject: [PATCH 2/7] soc: tegra: Move the fuse header to a separate directory
In-Reply-To: <1424864719-3390-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1424864719-3390-1-git-send-email-ezequiel.garcia@imgtec.com>
Message-ID: <1424864719-3390-3-git-send-email-ezequiel.garcia@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As preparation work for the introduction of an eFuse subsystem,
this commit moves Tegra's fuse header and fixes the includes
where needed.

Cc: Thierry Reding <treding@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 arch/arm/mach-tegra/cpuidle.c                     | 3 +--
 arch/arm/mach-tegra/flowctrl.c                    | 3 +--
 arch/arm/mach-tegra/hotplug.c                     | 2 +-
 arch/arm/mach-tegra/platsmp.c                     | 2 +-
 arch/arm/mach-tegra/pm.c                          | 2 +-
 arch/arm/mach-tegra/reset-handler.S               | 3 +--
 arch/arm/mach-tegra/reset.c                       | 3 +--
 arch/arm/mach-tegra/sleep-tegra30.S               | 3 +--
 arch/arm/mach-tegra/tegra.c                       | 2 +-
 drivers/ata/ahci_tegra.c                          | 2 +-
 drivers/clk/tegra/clk-periph-gate.c               | 3 +--
 drivers/clk/tegra/clk.c                           | 3 +--
 drivers/gpu/drm/nouveau/nouveau_platform.c        | 2 +-
 drivers/soc/tegra/fuse/fuse-tegra.c               | 2 +-
 drivers/soc/tegra/fuse/fuse-tegra20.c             | 3 +--
 drivers/soc/tegra/fuse/fuse-tegra30.c             | 3 +--
 drivers/soc/tegra/fuse/speedo-tegra114.c          | 3 +--
 drivers/soc/tegra/fuse/speedo-tegra124.c          | 3 +--
 drivers/soc/tegra/fuse/speedo-tegra20.c           | 3 +--
 drivers/soc/tegra/fuse/speedo-tegra30.c           | 3 +--
 drivers/soc/tegra/fuse/tegra-apbmisc.c            | 3 +--
 drivers/soc/tegra/pmc.c                           | 2 +-
 drivers/thermal/tegra_soctherm.c                  | 3 +--
 include/{soc/tegra/fuse.h => linux/efuse/tegra.h} | 0
 24 files changed, 23 insertions(+), 38 deletions(-)
 rename include/{soc/tegra/fuse.h => linux/efuse/tegra.h} (100%)

diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle.c
index 3165631..62b8086 100644
--- a/arch/arm/mach-tegra/cpuidle.c
+++ b/arch/arm/mach-tegra/cpuidle.c
@@ -21,11 +21,10 @@
  * more details.
  */
 
+#include <linux/efuse/tegra.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 
-#include <soc/tegra/fuse.h>
-
 #include "cpuidle.h"
 
 void __init tegra_cpuidle_init(void)
diff --git a/arch/arm/mach-tegra/flowctrl.c b/arch/arm/mach-tegra/flowctrl.c
index 475e783..623c820 100644
--- a/arch/arm/mach-tegra/flowctrl.c
+++ b/arch/arm/mach-tegra/flowctrl.c
@@ -19,14 +19,13 @@
  */
 
 #include <linux/cpumask.h>
+#include <linux/efuse/tegra.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 
-#include <soc/tegra/fuse.h>
-
 #include "flowctrl.h"
 
 static u8 flowctrl_offset_halt_cpu[] = {
diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index 6fc71f1..0d55820 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -9,11 +9,11 @@
  */
 
 #include <linux/clk/tegra.h>
+#include <linux/efuse/tegra.h>
 #include <linux/kernel.h>
 #include <linux/smp.h>
 
 #include <soc/tegra/common.h>
-#include <soc/tegra/fuse.h>
 
 #include <asm/smp_plat.h>
 
diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
index b450866..2c65404 100644
--- a/arch/arm/mach-tegra/platsmp.c
+++ b/arch/arm/mach-tegra/platsmp.c
@@ -15,13 +15,13 @@
 #include <linux/clk/tegra.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/efuse/tegra.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/jiffies.h>
 #include <linux/smp.h>
 
-#include <soc/tegra/fuse.h>
 #include <soc/tegra/pmc.h>
 
 #include <asm/cacheflush.h>
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index b0f48a3..7089444 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -20,6 +20,7 @@
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
 #include <linux/delay.h>
+#include <linux/efuse/tegra.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -27,7 +28,6 @@
 #include <linux/spinlock.h>
 #include <linux/suspend.h>
 
-#include <soc/tegra/fuse.h>
 #include <soc/tegra/pm.h>
 #include <soc/tegra/pmc.h>
 
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 71be4af..318fbcc 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -14,11 +14,10 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/efuse/tegra.h>
 #include <linux/init.h>
 #include <linux/linkage.h>
 
-#include <soc/tegra/fuse.h>
-
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
 
diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index 894c5c4..7fb3030 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -16,11 +16,10 @@
 
 #include <linux/bitops.h>
 #include <linux/cpumask.h>
+#include <linux/efuse/tegra.h>
 #include <linux/init.h>
 #include <linux/io.h>
 
-#include <soc/tegra/fuse.h>
-
 #include <asm/cacheflush.h>
 #include <asm/firmware.h>
 #include <asm/hardware/cache-l2x0.h>
diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 5d8d13a..e8c8946 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -14,10 +14,9 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/efuse/tegra.h>
 #include <linux/linkage.h>
 
-#include <soc/tegra/fuse.h>
-
 #include <asm/asm-offsets.h>
 #include <asm/assembler.h>
 #include <asm/cache.h>
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 914341b..b216403 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 #include <linux/clk/tegra.h>
 #include <linux/dma-mapping.h>
+#include <linux/efuse/tegra.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/irqchip.h>
@@ -35,7 +36,6 @@
 #include <linux/sys_soc.h>
 #include <linux/usb/tegra_usb_phy.h>
 
-#include <soc/tegra/fuse.h>
 #include <soc/tegra/pmc.h>
 
 #include <asm/hardware/cache-l2x0.h>
diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 3a62eb2..cbd4b43 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -19,6 +19,7 @@
 
 #include <linux/ahci_platform.h>
 #include <linux/errno.h>
+#include <linux/efuse/tegra.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -26,7 +27,6 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
-#include <soc/tegra/fuse.h>
 #include <soc/tegra/pmc.h>
 
 #include "ahci.h"
diff --git a/drivers/clk/tegra/clk-periph-gate.c b/drivers/clk/tegra/clk-periph-gate.c
index 0aa8830..8df474c 100644
--- a/drivers/clk/tegra/clk-periph-gate.c
+++ b/drivers/clk/tegra/clk-periph-gate.c
@@ -20,8 +20,7 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/err.h>
-
-#include <soc/tegra/fuse.h>
+#include <linux/efuse/tegra.h>
 
 #include "clk.h"
 
diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index 9ddb754..02b2694 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -14,14 +14,13 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/efuse/tegra.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/of.h>
 #include <linux/clk/tegra.h>
 #include <linux/reset-controller.h>
 
-#include <soc/tegra/fuse.h>
-
 #include "clk.h"
 
 #define CLK_OUT_ENB_L			0x010
diff --git a/drivers/gpu/drm/nouveau/nouveau_platform.c b/drivers/gpu/drm/nouveau/nouveau_platform.c
index dc5900b..719f8a6 100644
--- a/drivers/gpu/drm/nouveau/nouveau_platform.c
+++ b/drivers/gpu/drm/nouveau/nouveau_platform.c
@@ -20,6 +20,7 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/efuse/tegra.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -27,7 +28,6 @@
 #include <linux/of.h>
 #include <linux/reset.h>
 #include <linux/regulator/consumer.h>
-#include <soc/tegra/fuse.h>
 #include <soc/tegra/pmc.h>
 
 #include "nouveau_drm.h"
diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index c0d660f..5e6656d 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/efuse/tegra.h>
 #include <linux/kobject.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
@@ -24,7 +25,6 @@
 #include <linux/io.h>
 
 #include <soc/tegra/common.h>
-#include <soc/tegra/fuse.h>
 
 #include "fuse.h"
 
diff --git a/drivers/soc/tegra/fuse/fuse-tegra20.c b/drivers/soc/tegra/fuse/fuse-tegra20.c
index 5eff6f0..08ce2fb 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra20.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra20.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/efuse/tegra.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/dmaengine.h>
@@ -29,8 +30,6 @@
 #include <linux/platform_device.h>
 #include <linux/random.h>
 
-#include <soc/tegra/fuse.h>
-
 #include "fuse.h"
 
 #define FUSE_BEGIN	0x100
diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index 4d2f71b..574d7a9 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/efuse/tegra.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -25,8 +26,6 @@
 #include <linux/platform_device.h>
 #include <linux/random.h>
 
-#include <soc/tegra/fuse.h>
-
 #include "fuse.h"
 
 #define FUSE_BEGIN	0x100
diff --git a/drivers/soc/tegra/fuse/speedo-tegra114.c b/drivers/soc/tegra/fuse/speedo-tegra114.c
index 2a6ca03..8a4c9f1 100644
--- a/drivers/soc/tegra/fuse/speedo-tegra114.c
+++ b/drivers/soc/tegra/fuse/speedo-tegra114.c
@@ -16,10 +16,9 @@
 
 #include <linux/bug.h>
 #include <linux/device.h>
+#include <linux/efuse/tegra.h>
 #include <linux/kernel.h>
 
-#include <soc/tegra/fuse.h>
-
 #include "fuse.h"
 
 #define CORE_PROCESS_CORNERS	2
diff --git a/drivers/soc/tegra/fuse/speedo-tegra124.c b/drivers/soc/tegra/fuse/speedo-tegra124.c
index 4636238..0dd8c04 100644
--- a/drivers/soc/tegra/fuse/speedo-tegra124.c
+++ b/drivers/soc/tegra/fuse/speedo-tegra124.c
@@ -15,11 +15,10 @@
  */
 
 #include <linux/device.h>
+#include <linux/efuse/tegra.h>
 #include <linux/kernel.h>
 #include <linux/bug.h>
 
-#include <soc/tegra/fuse.h>
-
 #include "fuse.h"
 
 #define CPU_PROCESS_CORNERS	2
diff --git a/drivers/soc/tegra/fuse/speedo-tegra20.c b/drivers/soc/tegra/fuse/speedo-tegra20.c
index eff1b63..09b40ab 100644
--- a/drivers/soc/tegra/fuse/speedo-tegra20.c
+++ b/drivers/soc/tegra/fuse/speedo-tegra20.c
@@ -16,10 +16,9 @@
 
 #include <linux/bug.h>
 #include <linux/device.h>
+#include <linux/efuse/tegra.h>
 #include <linux/kernel.h>
 
-#include <soc/tegra/fuse.h>
-
 #include "fuse.h"
 
 #define CPU_SPEEDO_LSBIT		20
diff --git a/drivers/soc/tegra/fuse/speedo-tegra30.c b/drivers/soc/tegra/fuse/speedo-tegra30.c
index b17f0dc..65331d0 100644
--- a/drivers/soc/tegra/fuse/speedo-tegra30.c
+++ b/drivers/soc/tegra/fuse/speedo-tegra30.c
@@ -16,10 +16,9 @@
 
 #include <linux/bug.h>
 #include <linux/device.h>
+#include <linux/efuse/tegra.h>
 #include <linux/kernel.h>
 
-#include <soc/tegra/fuse.h>
-
 #include "fuse.h"
 
 #define CORE_PROCESS_CORNERS	1
diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index 3bf5aba..31de5f8 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -15,13 +15,12 @@
  *
  */
 
+#include <linux/efuse/tegra.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/io.h>
 
-#include <soc/tegra/fuse.h>
-
 #include "fuse.h"
 
 #define APBMISC_BASE	0x70000800
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index c956395..d901e4e 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -33,9 +33,9 @@
 #include <linux/reset.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
+#include <linux/efuse/tegra.h>
 
 #include <soc/tegra/common.h>
-#include <soc/tegra/fuse.h>
 #include <soc/tegra/pmc.h>
 
 #define PMC_CNTRL			0x0
diff --git a/drivers/thermal/tegra_soctherm.c b/drivers/thermal/tegra_soctherm.c
index 9197fc0..daec2e7 100644
--- a/drivers/thermal/tegra_soctherm.c
+++ b/drivers/thermal/tegra_soctherm.c
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/efuse/tegra.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -27,8 +28,6 @@
 #include <linux/reset.h>
 #include <linux/thermal.h>
 
-#include <soc/tegra/fuse.h>
-
 #define SENSOR_CONFIG0				0
 #define SENSOR_CONFIG0_STOP			BIT(0)
 #define SENSOR_CONFIG0_TALL_SHIFT		8
diff --git a/include/soc/tegra/fuse.h b/include/linux/efuse/tegra.h
similarity index 100%
rename from include/soc/tegra/fuse.h
rename to include/linux/efuse/tegra.h
-- 
2.3.0
