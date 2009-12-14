From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Mon, 14 Dec 2009 18:18:05 +0100
Subject: [PATCH 2/4] mfd: mc13783: When probing, unlock the mc13783 before
	subsystems initialisation.
In-Reply-To: <1260810776.2022.130.camel@climbing-alby>
References: <1260808880.2022.98.camel@climbing-alby>
	<1260810776.2022.130.camel@climbing-alby>
Message-ID: <1260811085.2022.135.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this, mc13783 subsystems drivers can configure the mc13783 chip
reading and writing registers.

Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mfd/mc13783-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/mc13783-core.c b/drivers/mfd/mc13783-core.c
index 3953297..185139e 100644
--- a/drivers/mfd/mc13783-core.c
+++ b/drivers/mfd/mc13783-core.c
@@ -629,6 +629,8 @@ err_revision:
 	}
 	/* This should go away (END) */
 
+	mc13783_unlock(mc13783);
+
 	if (pdata->flags & MC13783_USE_ADC)
 		mc13783_add_subdevice(mc13783, "mc13783-adc");
 
@@ -651,8 +653,6 @@ err_revision:
 	if (pdata->flags & MC13783_USE_TOUCHSCREEN)
 		mc13783_add_subdevice(mc13783, "mc13783-ts");
 
-	mc13783_unlock(mc13783);
-
 	return 0;
 }
 
-- 
1.6.3.3
