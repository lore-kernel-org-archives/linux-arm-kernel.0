From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Thu,  8 Mar 2012 17:06:06 -0500
Subject: [PATCH] ARM: pxa: fix build failure for regulator consumer in
 em-x270.c
In-Reply-To: <CAP=VYLp-weNj35OHtmZ6pf5-t7OUxWREeu8r5sSOLhFYu0CppQ@mail.gmail.com>
References: <CAP=VYLp-weNj35OHtmZ6pf5-t7OUxWREeu8r5sSOLhFYu0CppQ@mail.gmail.com>
Message-ID: <1331244366-6147-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 737f360d5bef5e01c6cfa755dca0b449a154c1e0 (linux-next)

  "regulator: Remove support for supplies specified by struct device"

caused this file to break, since it was still relying on the
device field to be present.  Update them to use the new dev_name
entries instead.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

[v2: replace dev with dev_name instead of just deleting dev.
 Note however there is dev_name overlap; not sure if that matters? ]

diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index c1b65da..0ffc100 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -1083,19 +1083,19 @@ static void __init em_x270_userspace_consumers_init(void)
 }
 
 /* DA9030 related initializations */
-#define REGULATOR_CONSUMER(_name, _dev, _supply)			       \
+#define REGULATOR_CONSUMER(_name, _dev_name, _supply)		        \
 	static struct regulator_consumer_supply _name##_consumers[] = {	\
 		{							\
-			.dev = _dev,					\
+			.dev_name = _dev_name,				\
 			.supply = _supply,				\
 		},							\
 	}
 
-REGULATOR_CONSUMER(ldo3, &em_x270_gps_userspace_consumer.dev, "vcc gps");
+REGULATOR_CONSUMER(ldo3, "reg-userspace-consumer", "vcc gps");
 REGULATOR_CONSUMER(ldo5, NULL, "vcc cam");
-REGULATOR_CONSUMER(ldo10, &pxa_device_mci.dev, "vcc sdio");
+REGULATOR_CONSUMER(ldo10, "pxa2xx-mci", "vcc sdio");
 REGULATOR_CONSUMER(ldo12, NULL, "vcc usb");
-REGULATOR_CONSUMER(ldo19, &em_x270_gprs_userspace_consumer.dev, "vcc gprs");
+REGULATOR_CONSUMER(ldo19, "reg-userspace-consumer", "vcc gprs");
 REGULATOR_CONSUMER(buck2, NULL, "vcc_core");
 
 #define REGULATOR_INIT(_ldo, _min_uV, _max_uV, _ops_mask)		\
-- 
1.7.9.1
