From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  6 Sep 2016 16:06:22 +0200
Subject: [PATCH 3/4] ARM: orion5x: avoid NO_IRQ in orion_ge00_switch_init
In-Reply-To: <20160906140623.2853066-1-arnd@arndb.de>
References: <20160906140623.2853066-1-arnd@arndb.de>
Message-ID: <20160906140623.2853066-3-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit 5be9fc23cdb4 ("ARM: orion5x: fix legacy orion5x IRQ numbers"),
IRQ zero is no longer a valid interrupt on Orion5x, so we can use the
normal convention of using '0' to indicate an invalid interrupt, rather
than the deprecated NO_IRQ constant

My first approach was to pass a pointer to the resource into
orion_ge00_switch_init(), but it seemed to just add complexity
for no good.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c | 2 +-
 arch/arm/mach-orion5x/wnr854t-setup.c        | 2 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c     | 2 +-
 arch/arm/plat-orion/common.c                 | 7 +++----
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
index c742e7b40b0d..8df5cb8263a2 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
@@ -120,7 +120,7 @@ static void __init rd88f5181l_fxo_init(void)
 	 */
 	orion5x_ehci0_init();
 	orion5x_eth_init(&rd88f5181l_fxo_eth_data);
-	orion5x_eth_switch_init(&rd88f5181l_fxo_switch_plat_data, NO_IRQ);
+	orion5x_eth_switch_init(&rd88f5181l_fxo_switch_plat_data, 0);
 	orion5x_uart0_init();
 
 	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
index 4e1e5c8f6111..5e929d5e5a23 100644
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ b/arch/arm/mach-orion5x/wnr854t-setup.c
@@ -124,7 +124,7 @@ static void __init wnr854t_init(void)
 	 * Configure peripherals.
 	 */
 	orion5x_eth_init(&wnr854t_eth_data);
-	orion5x_eth_switch_init(&wnr854t_switch_plat_data, NO_IRQ);
+	orion5x_eth_switch_init(&wnr854t_switch_plat_data, 0);
 	orion5x_uart0_init();
 
 	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
index 61e9027ef224..826ca94ef248 100644
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
@@ -210,7 +210,7 @@ static void __init wrt350n_v2_init(void)
 	 */
 	orion5x_ehci0_init();
 	orion5x_eth_init(&wrt350n_v2_eth_data);
-	orion5x_eth_switch_init(&wrt350n_v2_switch_plat_data, NO_IRQ);
+	orion5x_eth_switch_init(&wrt350n_v2_switch_plat_data, 0);
 	orion5x_uart0_init();
 
 	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 7b9b70785a54..30328e92ca58 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -489,11 +489,10 @@ void __init orion_ge00_switch_init(struct dsa_platform_data *d, int irq)
 {
 	int i;
 
-	if (irq != NO_IRQ) {
-		orion_switch_resources[0].start = irq;
-		orion_switch_resources[0].end = irq;
+	orion_switch_resources[0].start = irq;
+	orion_switch_resources[0].end = irq;
+	if (irq)
 		orion_switch_device.num_resources = 1;
-	}
 
 	d->netdev = &orion_ge00.dev;
 	for (i = 0; i < d->nr_chips; i++)
-- 
2.9.0
