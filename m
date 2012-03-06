From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue,  6 Mar 2012 14:46:43 -0500
Subject: [PATCH] ARM: pxa: fix regulator related build fail in
 magician_defconfig
Message-ID: <1331063203-21188-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 737f360d5bef5e01c6cfa755dca0b449a154c1e0 (linux-next)

  "regulator: Remove support for supplies specified by struct device"

deletes the field from the struct, but this platform was still trying
to set those fields.  Delete the assignments.

arch/arm/mach-pxa/magician.c:581: error: unknown field 'dev' specified in initializer
arch/arm/mach-pxa/magician.c:581: warning: initialization from incompatible pointer type
arch/arm/mach-pxa/magician.c:585: error: unknown field 'dev' specified in initializer
arch/arm/mach-pxa/magician.c:585: warning: initialization from incompatible pointer type

arch/arm/mach-pxa/hx4700.c:683: error: unknown field 'dev' specified in initializer
arch/arm/mach-pxa/hx4700.c:683: warning: initialization from incompatible pointer type
arch/arm/mach-pxa/hx4700.c:687: error: unknown field 'dev' specified in initializer
arch/arm/mach-pxa/hx4700.c:687: warning: initialization from incompatible pointer type

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index f2c23ea..76de30c 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -680,11 +680,9 @@ static struct platform_device power_supply = {
 
 static struct regulator_consumer_supply bq24022_consumers[] = {
 	{
-		.dev = &gpio_vbus.dev,
 		.supply = "vbus_draw",
 	},
 	{
-		.dev = &power_supply.dev,
 		.supply = "ac_draw",
 	},
 };
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 3d6baf9..bd0f86a 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -578,11 +578,9 @@ static struct platform_device power_supply = {
 
 static struct regulator_consumer_supply bq24022_consumers[] = {
 	{
-		.dev = &gpio_vbus.dev,
 		.supply = "vbus_draw",
 	},
 	{
-		.dev = &power_supply.dev,
 		.supply = "ac_draw",
 	},
 };
-- 
1.7.9.1
