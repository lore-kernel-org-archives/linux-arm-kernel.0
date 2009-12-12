From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Sat, 12 Dec 2009 17:53:39 +0100
Subject: [PATCH 2/4] mfd: mc13783: When probing, unlock the mc13783 before
	subsystems initialisation.
In-Reply-To: <1260636523.2054.28.camel@climbing-alby>
References: <1260635829.2054.16.camel@climbing-alby>
	<1260636523.2054.28.camel@climbing-alby>
Message-ID: <1260636819.2054.33.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this, mc13783 subsystems drivers can configure the mc13783 chip
reading and writing registers.

Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---
 drivers/mfd/mc13783-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/mc13783-core.c b/drivers/mfd/mc13783-core.c
index aa1f79a..35dcc2a 100644
--- a/drivers/mfd/mc13783-core.c
+++ b/drivers/mfd/mc13783-core.c
@@ -631,6 +631,8 @@ err_revision:
 	}
 	/* This should go away (END) */
 
+	mc13783_unlock(mc13783);
+
 	if (pdata->flags & MC13783_USE_ADC)
 		mc13783_add_subdevice(mc13783, "mc13783-adc");
 
@@ -653,8 +655,6 @@ err_revision:
 	if (pdata->flags & MC13783_USE_TOUCHSCREEN)
 		mc13783_add_subdevice(mc13783, "mc13783-ts");
 
-	mc13783_unlock(mc13783);
-
 	return 0;
 }
 
-- 
1.6.3.3
