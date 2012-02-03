From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:35:32 +0000
Subject: [PATCH 13/17] ARM: sa11x0: neponset: place smc91x and sa1111
 resources in neponset device
In-Reply-To: <20120203193059.GF14129@n2100.arm.linux.org.uk>
References: <20120203193059.GF14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtOuy-0001CO-AV@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Complete the neponset device resources by covering the children's
memory resources in the parent neponset device.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/neponset.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index f4d5871..2451a38 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -179,6 +179,7 @@ static struct sa1111_platform_data sa1111_info = {
 static int __devinit neponset_probe(struct platform_device *dev)
 {
 	struct neponset_drvdata *d;
+	struct resource *sa1111_res, *smc91x_res;
 	struct resource sa1111_resources[] = {
 		DEFINE_RES_MEM(0x40000000, SZ_8K),
 		{ .flags = IORESOURCE_IRQ },
@@ -213,6 +214,13 @@ static int __devinit neponset_probe(struct platform_device *dev)
 	if (ret < 0)
 		goto err_alloc;
 
+	smc91x_res = platform_get_resource(dev, IORESOURCE_MEM, 1);
+	sa1111_res = platform_get_resource(dev, IORESOURCE_MEM, 2);
+	if (!smc91x_res || !sa1111_res) {
+		ret = -ENXIO;
+		goto err_alloc;
+	}
+
 	d = kzalloc(sizeof(*d), GFP_KERNEL);
 	if (!d) {
 		ret = -ENOMEM;
@@ -258,10 +266,13 @@ static int __devinit neponset_probe(struct platform_device *dev)
 	/* Disable GPIO 0/1 drivers so the buttons work on the Assabet */
 	NCR_0 = NCR_GP01_OFF;
 
+	sa1111_resources[0].parent = sa1111_res;
 	sa1111_resources[1].start = d->irq_base + NEP_IRQ_SA1111;
 	sa1111_resources[1].end = d->irq_base + NEP_IRQ_SA1111;
 	d->sa1111 = platform_device_register_full(&sa1111_devinfo);
 
+	smc91x_resources[0].parent = smc91x_res;
+	smc91x_resources[1].parent = smc91x_res;
 	smc91x_resources[2].start = d->irq_base + NEP_IRQ_SMC91X;
 	smc91x_resources[2].end = d->irq_base + NEP_IRQ_SMC91X;
 	d->smc91x = platform_device_register_full(&smc91x_devinfo);
@@ -331,6 +342,8 @@ static struct platform_driver neponset_device_driver = {
 
 static struct resource neponset_resources[] = {
 	DEFINE_RES_MEM(0x10000000, 0x08000000),
+	DEFINE_RES_MEM(0x18000000, 0x04000000),
+	DEFINE_RES_MEM(0x40000000, SZ_8K),
 	DEFINE_RES_IRQ(IRQ_GPIO25),
 };
 
-- 
1.7.4.4
