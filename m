From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:58:16 +0000
Subject: [PATCH 11/20] ARM: sa1111: provide a generic way to prevent devices
 from registering
In-Reply-To: <20120203195419.GH14129@n2100.arm.linux.org.uk>
References: <20120203195419.GH14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPGy-00044F-Gy@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms don't want certain devices to be registered, because,
eg, the interface is not wired.  Provide a way for platforms to
prevent various devices from being registered via a devid bitmask in
the platform data.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/sa1111.c               |    7 ++-----
 arch/arm/include/asm/hardware/sa1111.h |    1 +
 arch/arm/mach-pxa/lubbock.c            |    1 +
 arch/arm/mach-sa1100/badge4.c          |    1 +
 arch/arm/mach-sa1100/jornada720.c      |    1 +
 arch/arm/mach-sa1100/neponset.c        |    1 +
 6 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 4bdf1bb..17694cf 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -833,11 +833,8 @@ __sa1111_probe(struct device *me, struct resource *mem, int irq)
 	g_sa1111 = sachip;
 
 	has_devs = ~0;
-	if (machine_is_assabet() || machine_is_jornada720() ||
-	    machine_is_badge4())
-		has_devs &= ~SA1111_DEVID_PS2_MSE;
-	else
-		has_devs &= ~SA1111_DEVID_SAC;
+	if (pd)
+		has_devs &= ~pd->disable_devs;
 
 	for (i = 0; i < ARRAY_SIZE(sa1111_devices); i++)
 		if (sa1111_devices[i].devid & has_devs)
diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/hardware/sa1111.h
index 37ad29d..74afe20 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -584,6 +584,7 @@ void sa1111_set_sleep_io(struct sa1111_dev *sadev, unsigned int bits, unsigned i
 
 struct sa1111_platform_data {
 	int	irq_base;	/* base for cascaded on-chip IRQs */
+	unsigned disable_devs;
 	void	*data;
 	int	(*enable)(void *, unsigned);
 	void	(*disable)(void *, unsigned);
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 6ebd276..6bb3f47 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -223,6 +223,7 @@ static struct resource sa1111_resources[] = {
 
 static struct sa1111_platform_data sa1111_info = {
 	.irq_base	= LUBBOCK_SA1111_IRQ_BASE,
+	.disable_devs	= SA1111_DEVID_SAC,
 };
 
 static struct platform_device sa1111_device = {
diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index d8492499..8fb80f0 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -66,6 +66,7 @@ static void badge4_sa1111_disable(void *data, unsigned devid)
 
 static struct sa1111_platform_data sa1111_info = {
 	.irq_base	= IRQ_BOARD_END,
+	.disable_devs	= SA1111_DEVID_PS2_MSE,
 	.enable		= badge4_sa1111_enable,
 	.disable	= badge4_sa1111_disable,
 };
diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index ee121d6..dcd6d02 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -211,6 +211,7 @@ static struct resource sa1111_resources[] = {
 
 static struct sa1111_platform_data sa1111_info = {
 	.irq_base	= IRQ_BOARD_END,
+	.disable_devs	= SA1111_DEVID_PS2_MSE,
 };
 
 static u64 sa1111_dmamask = 0xffffffffUL;
diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index b4fa53a..b40a719 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -242,6 +242,7 @@ static struct resource sa1111_resources[] = {
 
 static struct sa1111_platform_data sa1111_info = {
 	.irq_base	= IRQ_BOARD_END,
+	.disable_devs	= SA1111_DEVID_PS2_MSE,
 };
 
 static u64 sa1111_dmamask = 0xffffffffUL;
-- 
1.7.4.4
