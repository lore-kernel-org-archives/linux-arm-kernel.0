From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 19 Jan 2012 19:05:10 +0100
Subject: [PATCH 1/3] ARM: at91/tclib: take iomem size from resource
In-Reply-To: <1326996312-9244-1-git-send-email-nicolas.ferre@atmel.com>
References: <1326996312-9244-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <a311afe3c46da62f7a1e82d2fa933e24ad4eef7e.1326995849.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Requesting iomem region and ioremaping is now done using
the resource size specified instead of a constant value.

Each <SoC>_device.c file is modified accordingly to reflect
actual user interface size.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91sam9260_devices.c |    4 ++--
 arch/arm/mach-at91/at91sam9g45_devices.c |    4 ++--
 drivers/misc/atmel_tclib.c               |   17 +++++++++--------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 642ccb6..ea66087 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -641,7 +641,7 @@ void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
 static struct resource tcb0_resources[] = {
 	[0] = {
 		.start	= AT91SAM9260_BASE_TCB0,
-		.end	= AT91SAM9260_BASE_TCB0 + SZ_16K - 1,
+		.end	= AT91SAM9260_BASE_TCB0 + SZ_256 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -671,7 +671,7 @@ static struct platform_device at91sam9260_tcb0_device = {
 static struct resource tcb1_resources[] = {
 	[0] = {
 		.start	= AT91SAM9260_BASE_TCB1,
-		.end	= AT91SAM9260_BASE_TCB1 + SZ_16K - 1,
+		.end	= AT91SAM9260_BASE_TCB1 + SZ_256 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 96e2adc..545bbe9 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -957,7 +957,7 @@ void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data) {}
 static struct resource tcb0_resources[] = {
 	[0] = {
 		.start	= AT91SAM9G45_BASE_TCB0,
-		.end	= AT91SAM9G45_BASE_TCB0 + SZ_16K - 1,
+		.end	= AT91SAM9G45_BASE_TCB0 + SZ_256 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -978,7 +978,7 @@ static struct platform_device at91sam9g45_tcb0_device = {
 static struct resource tcb1_resources[] = {
 	[0] = {
 		.start	= AT91SAM9G45_BASE_TCB1,
-		.end	= AT91SAM9G45_BASE_TCB1 + SZ_16K - 1,
+		.end	= AT91SAM9G45_BASE_TCB1 + SZ_256 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
index 4bcfc37..7a6512a 100644
--- a/drivers/misc/atmel_tclib.c
+++ b/drivers/misc/atmel_tclib.c
@@ -9,10 +9,6 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 
-/* Number of bytes to reserve for the iomem resource */
-#define ATMEL_TC_IOMEM_SIZE	256
-
-
 /*
  * This is a thin library to solve the problem of how to portably allocate
  * one of the TC blocks.  For simplicity, it doesn't currently expect to
@@ -48,6 +44,7 @@ struct atmel_tc *atmel_tc_alloc(unsigned block, const char *name)
 	struct atmel_tc		*tc;
 	struct platform_device	*pdev = NULL;
 	struct resource		*r;
+	size_t			size;
 
 	spin_lock(&tc_list_lock);
 	list_for_each_entry(tc, &tc_list, node) {
@@ -61,11 +58,15 @@ struct atmel_tc *atmel_tc_alloc(unsigned block, const char *name)
 		goto fail;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	r = request_mem_region(r->start, ATMEL_TC_IOMEM_SIZE, name);
 	if (!r)
 		goto fail;
 
-	tc->regs = ioremap(r->start, ATMEL_TC_IOMEM_SIZE);
+	size = resource_size(r);
+	r = request_mem_region(r->start, size, name);
+	if (!r)
+		goto fail;
+
+	tc->regs = ioremap(r->start, size);
 	if (!tc->regs)
 		goto fail_ioremap;
 
@@ -76,7 +77,7 @@ out:
 	return tc;
 
 fail_ioremap:
-	release_mem_region(r->start, ATMEL_TC_IOMEM_SIZE);
+	release_mem_region(r->start, size);
 fail:
 	tc = NULL;
 	goto out;
@@ -96,7 +97,7 @@ void atmel_tc_free(struct atmel_tc *tc)
 	spin_lock(&tc_list_lock);
 	if (tc->regs) {
 		iounmap(tc->regs);
-		release_mem_region(tc->iomem->start, ATMEL_TC_IOMEM_SIZE);
+		release_mem_region(tc->iomem->start, resource_size(tc->iomem));
 		tc->regs = NULL;
 		tc->iomem = NULL;
 	}
-- 
1.7.5.4
