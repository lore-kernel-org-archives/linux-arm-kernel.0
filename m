From: steveb@workware.net.au (Steve Bennett)
Date: Tue, 23 Mar 2010 22:58:00 +1000
Subject: [PATCH] USB: gadget: pxa25x: support additional IXP425 steppings
In-Reply-To: <20100323092059.GA4439@n2100.arm.linux.org.uk>
References: <7FC3F153-EB1C-42AC-A5D7-119BCCB8C237@workware.net.au>
	<20100323093009.ms6zgeh5w44k40g4@v1539.ncsrv.de>
	<5EB8CA3A-5EB4-4F98-B83F-5B1228CCD73C@workware.net.au>
	<20100323092059.GA4439@n2100.arm.linux.org.uk>
Message-ID: <CDBB3FAC-22FA-43F8-ADD1-FC8C57ABCD1E@workware.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/03/2010, at 7:20 PM, Russell King - ARM Linux wrote:

> On Tue, Mar 23, 2010 at 06:37:36PM +1000, Steve Bennett wrote:
>> Russell, is there something stopping us going with your patch?
> 
> Nothing really - only lack of motivation and sufficient reason to make
> the change.
> 
>> Does it just need some updating/testing?
> 
> After a year, it certainly will do.

OK. Your patch and Hendrik's are largely independent.
If I update Hendrik's patch will that do?
Something like this:

diff --git a/drivers/usb/gadget/pxa25x_udc.c b/drivers/usb/gadget/pxa25x_udc.c
index be5fb34..b63b65c 100644
--- a/drivers/usb/gadget/pxa25x_udc.c
+++ b/drivers/usb/gadget/pxa25x_udc.c
@@ -2096,39 +2096,11 @@ static struct pxa25x_udc memory = {
 #endif /* !CONFIG_USB_PXA25X_SMALL */
 };
 
-#define CP15R0_VENDOR_MASK	0xffffe000
-
-#if	defined(CONFIG_ARCH_PXA)
-#define CP15R0_XSCALE_VALUE	0x69052000	/* intel/arm/xscale */
-
-#elif	defined(CONFIG_ARCH_IXP4XX)
-#define CP15R0_XSCALE_VALUE	0x69054000	/* intel/arm/ixp4xx */
-
-#endif
-
 #define CP15R0_PROD_MASK	0x000003f0
-#define PXA25x			0x00000100	/* and PXA26x */
-#define PXA210			0x00000120
-
 #define CP15R0_REV_MASK		0x0000000f
-
 #define CP15R0_PRODREV_MASK	(CP15R0_PROD_MASK | CP15R0_REV_MASK)
 
 #define PXA255_A0		0x00000106	/* or PXA260_B1 */
-#define PXA250_C0		0x00000105	/* or PXA26x_B0 */
-#define PXA250_B2		0x00000104
-#define PXA250_B1		0x00000103	/* or PXA260_A0 */
-#define PXA250_B0		0x00000102
-#define PXA250_A1		0x00000101
-#define PXA250_A0		0x00000100
-
-#define PXA210_C0		0x00000125
-#define PXA210_B2		0x00000124
-#define PXA210_B1		0x00000123
-#define PXA210_B0		0x00000122
-#define IXP425_A0		0x000001c1
-#define IXP425_B0		0x000001f1
-#define IXP465_AD		0x00000200
 
 /*
  *	probe - binds to the platform device
@@ -2137,42 +2109,24 @@ static int __init pxa25x_udc_probe(struct platform_device *pdev)
 {
 	struct pxa25x_udc *dev = &memory;
 	int retval, vbus_irq, irq;
-	u32 chiprev;
 
-	/* insist on Intel/ARM/XScale */
-	asm("mrc%? p15, 0, %0, c0, c0" : "=r" (chiprev));
-	if ((chiprev & CP15R0_VENDOR_MASK) != CP15R0_XSCALE_VALUE) {
-		pr_err("%s: not XScale!\n", driver_name);
-		return -ENODEV;
-	}
+#if defined(CONFIG_ARCH_PXA)
+	if (cpu_is_pxa210() || cpu_is_pxa25x()) {
+		if ((read_cpuid_id() & CP15R0_PRODREV_MASK) == PXA255_A0)
+			dev->has_cfr = 1;
+		/* PXA250_A0/A1 "not released"; ep 13, 15 unusable */
+		/* PXA21x/PXA25x with stepping < C0: OUT-DMA is broken ... */
+	} else {
 
-	/* trigger chiprev-specific logic */
-	switch (chiprev & CP15R0_PRODREV_MASK) {
-#if	defined(CONFIG_ARCH_PXA)
-	case PXA255_A0:
-		dev->has_cfr = 1;
-		break;
-	case PXA250_A0:
-	case PXA250_A1:
-		/* A0/A1 "not released"; ep 13, 15 unusable */
-		/* fall through */
-	case PXA250_B2: case PXA210_B2:
-	case PXA250_B1: case PXA210_B1:
-	case PXA250_B0: case PXA210_B0:
-		/* OUT-DMA is broken ... */
-		/* fall through */
-	case PXA250_C0: case PXA210_C0:
-		break;
-#elif	defined(CONFIG_ARCH_IXP4XX)
-	case IXP425_A0:
-	case IXP425_B0:
-	case IXP465_AD:
+#elif defined(CONFIG_ARCH_IXP4XX)
+	if (cpu_is_ixp42x() || cpu_is_ixp43x() || cpu_is_ixp46x())
 		dev->has_cfr = 1;
-		break;
+	else {
+
+#else
+	{
 #endif
-	default:
-		pr_err("%s: unrecognized processor: %08x\n",
-			driver_name, chiprev);
+		pr_err("%s: unrecognized processor\n", driver_name);
 		/* iop3xx, ixp4xx, ... */
 		return -ENODEV;
 	}



Steve
--
?Web: Embedded Web Framework - http://uweb.workware.net.au/
