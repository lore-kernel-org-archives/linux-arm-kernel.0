From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Sat, 12 Dec 2009 18:06:17 +0100
Subject: [PATCH 4/4] regulator: mc13783 change to platform_driver_register.
In-Reply-To: <1260636976.2054.36.camel@climbing-alby>
References: <1260635829.2054.16.camel@climbing-alby>
	<1260636523.2054.28.camel@climbing-alby>
	<1260636819.2054.33.camel@climbing-alby>
	<1260636976.2054.36.camel@climbing-alby>
Message-ID: <1260637577.2054.43.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the instant when regulator driver is probed. 
To have a correct regulators initialisation (enable, disable and voltages 
selection), the driver must have access to mc13783 registers and so 
mc13783-core must be loaded before this.

With this patch mc13783_regulator_probe is called when mc13783-core
register the regulator subsystem.

Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---
 drivers/regulator/mc13783-regulator.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/mc13783-regulator.c b/drivers/regulator/mc13783-regulator.c
index ed78137..1ae9017 100644
--- a/drivers/regulator/mc13783-regulator.c
+++ b/drivers/regulator/mc13783-regulator.c
@@ -545,12 +545,12 @@ static struct platform_driver mc13783_regulator_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.remove		= __devexit_p(mc13783_regulator_remove),
+	.probe		= mc13783_regulator_probe,
 };
 
 static int __init mc13783_regulator_init(void)
 {
-	return platform_driver_probe(&mc13783_regulator_driver,
-			mc13783_regulator_probe);
+	return platform_driver_register(&mc13783_regulator_driver);
 }
 subsys_initcall(mc13783_regulator_init);
 
-- 
1.6.3.3
