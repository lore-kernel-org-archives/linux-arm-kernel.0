From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Mon, 14 Dec 2009 18:53:35 +0100
Subject: [PATCH 4/4] regulator: mc13783-regulator: correct the probing time.
In-Reply-To: <1260811598.2022.144.camel@climbing-alby>
References: <1260808880.2022.98.camel@climbing-alby>
	<1260810776.2022.130.camel@climbing-alby>
	<1260811085.2022.135.camel@climbing-alby>
	<1260811598.2022.144.camel@climbing-alby>
Message-ID: <1260813215.2022.171.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the mc13783-regulator driver is built in kernel, probing it during
the regulator subsystem initialisation result in a fault.

That is because regulator subsystem is planned to be initialised very early
in the boot process, before the mfd subsystem initialisation.

The mc12783-regulator probing process need to access to the mc13783-core
functionality to read/write mc13783 registers and so must be called after
the mc13783-core driver initialisation.

The way to do this is to let the kernel probe the mc13783-regulator driver when 
mc13783-core register his regulator subdevice.

Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---
 drivers/regulator/mc13783-regulator.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/mc13783-regulator.c b/drivers/regulator/mc13783-regulator.c
index 3d5d349..a40e35a 100644
--- a/drivers/regulator/mc13783-regulator.c
+++ b/drivers/regulator/mc13783-regulator.c
@@ -509,12 +509,12 @@ static struct platform_driver mc13783_regulator_driver = {
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
