From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon,  5 Mar 2012 18:12:02 -0500
Subject: [PATCH] ARM: pxa: fix build failure for regulator consumer in
 em-x270.c
Message-ID: <1330989122-6323-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 737f360d5bef5e01c6cfa755dca0b449a154c1e0 (linux-next)

  "regulator: Remove support for supplies specified by struct device"

caused this file to break, since it was still relying on the
device field to be present.  Strip them out here too.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
CC: Mark Brown <broonie@opensource.wolfsonmicro.com>

diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index d80c0ba..c8f3293 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -1083,20 +1083,19 @@ static void __init em_x270_userspace_consumers_init(void)
 }
 
 /* DA9030 related initializations */
-#define REGULATOR_CONSUMER(_name, _dev, _supply)			       \
+#define REGULATOR_CONSUMER(_name, _supply)			       \
 	static struct regulator_consumer_supply _name##_consumers[] = {	\
 		{							\
-			.dev = _dev,					\
 			.supply = _supply,				\
 		},							\
 	}
 
-REGULATOR_CONSUMER(ldo3, &em_x270_gps_userspace_consumer.dev, "vcc gps");
-REGULATOR_CONSUMER(ldo5, NULL, "vcc cam");
-REGULATOR_CONSUMER(ldo10, &pxa_device_mci.dev, "vcc sdio");
-REGULATOR_CONSUMER(ldo12, NULL, "vcc usb");
-REGULATOR_CONSUMER(ldo19, &em_x270_gprs_userspace_consumer.dev, "vcc gprs");
-REGULATOR_CONSUMER(buck2, NULL, "vcc_core");
+REGULATOR_CONSUMER(ldo3, "vcc gps");
+REGULATOR_CONSUMER(ldo5, "vcc cam");
+REGULATOR_CONSUMER(ldo10, "vcc sdio");
+REGULATOR_CONSUMER(ldo12, "vcc usb");
+REGULATOR_CONSUMER(ldo19, "vcc gprs");
+REGULATOR_CONSUMER(buck2, "vcc_core");
 
 #define REGULATOR_INIT(_ldo, _min_uV, _max_uV, _ops_mask)		\
 	static struct regulator_init_data _ldo##_data = {		\
-- 
1.7.9.1
