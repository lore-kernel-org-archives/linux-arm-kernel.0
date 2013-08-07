From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:38:31 +0900
Subject: [GIT PULL 04/26] ARM: shmobile: r8a7778: cleanup registration of i2c
In-Reply-To: <cover.1375840527.git.horms+renesas@verge.net.au>
References: <cover.1375840527.git.horms+renesas@verge.net.au>
Message-ID: <1fd4eecd480b82e11900ae6a8f44d92efeb96004.1375840527.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

i2c-rcar driver which doesn't need platform data at the time of
registration can be registerd on SoC.
And, registering these drivers in the SoC code can avoid
unwanted device numbering issue.
(ex. the i2c3 device number will be i2c.0 if i2c3 only registered)
This patch registers it on SoC code as cleanup C code

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c          | 1 -
 arch/arm/mach-shmobile/include/mach/r8a7778.h | 1 -
 arch/arm/mach-shmobile/setup-r8a7778.c        | 6 +++++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 1c876ab..d7d3427 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -200,7 +200,6 @@ static void __init bockw_init(void)
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
 	r8a7778_add_ether_device(&ether_platform_data);
-	r8a7778_add_i2c_device(0);
 	r8a7778_add_hspi_device(0);
 
 	i2c_register_board_info(0, i2c0_devices,
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index aaa0544..9874511 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -23,7 +23,6 @@
 extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
-extern void r8a7778_add_i2c_device(int id);
 extern void r8a7778_add_hspi_device(int id);
 extern void r8a7778_add_dt_devices(void);
 
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index c585ee0..ce3b54d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -250,7 +250,7 @@ static struct resource i2c_resources[] __initdata = {
 	DEFINE_RES_IRQ(gic_iid(0x6d)),
 };
 
-void __init r8a7778_add_i2c_device(int id)
+static void __init r8a7778_register_i2c(int id)
 {
 	BUG_ON(id < 0 || id > 3);
 
@@ -308,6 +308,10 @@ void __init r8a7778_add_dt_devices(void)
 void __init r8a7778_add_standard_devices(void)
 {
 	r8a7778_add_dt_devices();
+	r8a7778_register_i2c(0);
+	r8a7778_register_i2c(1);
+	r8a7778_register_i2c(2);
+	r8a7778_register_i2c(3);
 }
 
 void __init r8a7778_init_late(void)
-- 
1.8.3.2
