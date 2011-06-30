From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 30 Jun 2011 12:41:56 +0200
Subject: [PATCH 2/3] ARM mxs: adjust pwm resources to what the driver expects
In-Reply-To: <1309430517-23821-1-git-send-email-s.hauer@pengutronix.de>
References: <1309430517-23821-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1309430517-23821-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PWMs on i.MX23/28 have almost seperated register spaces
but share a common enable register. To reflect this register
a parent device to the PWMs which handles the enable register.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mxs/devices/platform-mxs-pwm.c |   32 +++++++++++++++++++++++--
 1 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mxs/devices/platform-mxs-pwm.c b/arch/arm/mach-mxs/devices/platform-mxs-pwm.c
index 680f5a9..36580b7 100644
--- a/arch/arm/mach-mxs/devices/platform-mxs-pwm.c
+++ b/arch/arm/mach-mxs/devices/platform-mxs-pwm.c
@@ -9,14 +9,40 @@
 #include <asm/sizes.h>
 #include <mach/devices-common.h>
 
+static struct platform_device *__init mxs_add_pwm_core(resource_size_t iobase)
+{
+	struct resource res = {
+		.flags = IORESOURCE_MEM,
+		.start = iobase,
+		.end = iobase + 0xff,
+	};
+
+	return mxs_add_platform_device("mxs-pwm-core", 0, &res, 1, NULL, 0);
+}
+
 struct platform_device *__init mxs_add_mxs_pwm(resource_size_t iobase, int id)
 {
+	struct resource *r;
+
+	static struct platform_device *pwm_core;
 	struct resource res = {
 		.flags = IORESOURCE_MEM,
+		.start = iobase + 0x10 + 0x20 * id,
+		.end = iobase + 0x10 + 0x20 * id + 0x1f,
 	};
 
-	res.start = iobase + 0x10 + 0x20 * id;
-	res.end = res.start + 0x1f;
+	if (!pwm_core) {
+		pwm_core = mxs_add_pwm_core(iobase);
+		if (!pwm_core)
+			return NULL;
+	}
+
+	r = platform_get_resource(pwm_core, IORESOURCE_MEM, 0);
+	if (!r)
+		return NULL;
+
+	res.parent = r;
 
-	return mxs_add_platform_device("mxs-pwm", id, &res, 1, NULL, 0);
+	return platform_device_register_resndata(&pwm_core->dev, "mxs-pwm",
+			id, &res, 1, NULL, 0);
 }
-- 
1.7.5.3
