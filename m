From: afzal@ti.com (Afzal Mohammed)
Date: Fri, 19 Oct 2012 15:29:31 +0530
Subject: [PATCH v4 2/5] ARM: davinci: remove rtc kicker release
In-Reply-To: <cover.1350633036.git.afzal@ti.com>
References: <cover.1350633036.git.afzal@ti.com>
Message-ID: <53f02e0eb0c5142e47c9398eb00da0520a442745.1350633036.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rtc-omap driver is now capable of handling kicker mechanism,
hence remove kicker handling at platform level, instead
provide proper device name so that driver can handle kicker
mechanism by itself

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Acked-by: Sekhar Nori <nsekhar@ti.com>
---

v2:
 Use device name da830-rtc instead of am1808-rtc

 arch/arm/mach-davinci/devices-da8xx.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index bd2f72b..2d25b24 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -674,7 +674,7 @@ static struct resource da8xx_rtc_resources[] = {
 };
 
 static struct platform_device da8xx_rtc_device = {
-	.name           = "omap_rtc",
+	.name           = "da830-rtc",
 	.id             = -1,
 	.num_resources	= ARRAY_SIZE(da8xx_rtc_resources),
 	.resource	= da8xx_rtc_resources,
@@ -683,17 +683,6 @@ static struct platform_device da8xx_rtc_device = {
 int da8xx_register_rtc(void)
 {
 	int ret;
-	void __iomem *base;
-
-	base = ioremap(DA8XX_RTC_BASE, SZ_4K);
-	if (WARN_ON(!base))
-		return -ENOMEM;
-
-	/* Unlock the rtc's registers */
-	__raw_writel(0x83e70b13, base + 0x6c);
-	__raw_writel(0x95a4f1e0, base + 0x70);
-
-	iounmap(base);
 
 	ret = platform_device_register(&da8xx_rtc_device);
 	if (!ret)
-- 
1.7.12
