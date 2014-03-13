From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Mar 2014 17:59:53 +0900
Subject: [PATCH v4 10/19] ARM: shmobile: marzen-reference: Move clock and OF
 device initialisation into board code
In-Reply-To: <1394701202-25823-1-git-send-email-horms+renesas@verge.net.au>
References: <1394701202-25823-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1394701202-25823-11-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the clock initialisation and OF device population from
SoC to board code. This is in keeping with the pattern used by Lager.
And the clock portion is part of decoupling clock initialisation
from SoC code in preparation for moving to the common clock framework.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen-reference.c | 3 +++
 arch/arm/mach-shmobile/setup-r8a7779.c          | 4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 2773936..c22e5c2 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -19,6 +19,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/of_platform.h>
 #include <mach/r8a7779.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
@@ -27,7 +28,9 @@
 
 static void __init marzen_init(void)
 {
+	r8a7779_clock_init();
 	r8a7779_add_standard_devices_dt();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	r8a7779_init_irq_extpin_dt(1); /* IRQ1 as individual interrupt */
 }
 
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index f28b8c7..3471a9b 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -784,12 +784,8 @@ void __init r8a7779_init_delay(void)
 
 void __init r8a7779_add_standard_devices_dt(void)
 {
-	/* clocks are setup late during boot in the case of DT */
-	r8a7779_clock_init();
-
 	platform_add_devices(r8a7779_devices_dt,
 			     ARRAY_SIZE(r8a7779_devices_dt));
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 #define MODEMR		0xffcc0020
-- 
1.8.5.2
