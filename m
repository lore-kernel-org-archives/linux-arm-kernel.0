From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 3 Feb 2011 18:31:10 +0100 (CET)
Subject: [PATCH] fix warning on pcm990
Message-ID: <Pine.LNX.4.64.1102031827380.21719@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio_bus_switch is provided by a I2C GPIO extension controller, so we have 
to use a sleeping version of gpio_set_value() with it.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
index 90820fa..19a9f49 100644
--- a/arch/arm/mach-pxa/pcm990-baseboard.c
+++ b/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -395,9 +395,9 @@ static int pcm990_camera_set_bus_param(struct soc_camera_link *link,
 	}
 
 	if (flags & SOCAM_DATAWIDTH_8)
-		gpio_set_value(gpio_bus_switch, 1);
+		gpio_set_value_cansleep(gpio_bus_switch, 1);
 	else
-		gpio_set_value(gpio_bus_switch, 0);
+		gpio_set_value_cansleep(gpio_bus_switch, 0);
 
 	return 0;
 }
