From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Thu,  8 Mar 2012 16:34:54 -0500
Subject: [PATCH] ARM: pxa: fix regulator related build fail in
 magician_defconfig
In-Reply-To: <1331084814.11802.YahooMailClassic@web29012.mail.ird.yahoo.com>
References: <1331084814.11802.YahooMailClassic@web29012.mail.ird.yahoo.com>
Message-ID: <1331242494-3157-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 737f360d5bef5e01c6cfa755dca0b449a154c1e0 (linux-next)

  "regulator: Remove support for supplies specified by struct device"

deletes the field from the struct, but this platform was still trying
to set those fields.  Convert them to use the REGULATOR_SUPPLY macro.

arch/arm/mach-pxa/magician.c:581: error: unknown field 'dev' specified in initializer
arch/arm/mach-pxa/magician.c:581: warning: initialization from incompatible pointer type
arch/arm/mach-pxa/magician.c:585: error: unknown field 'dev' specified in initializer
arch/arm/mach-pxa/magician.c:585: warning: initialization from incompatible pointer type

arch/arm/mach-pxa/hx4700.c:683: error: unknown field 'dev' specified in initializer
arch/arm/mach-pxa/hx4700.c:683: warning: initialization from incompatible pointer type
arch/arm/mach-pxa/hx4700.c:687: error: unknown field 'dev' specified in initializer
arch/arm/mach-pxa/hx4700.c:687: warning: initialization from incompatible pointer type

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[v3: fix arg2 in REGULATOR_SUPPLY to have correct names ]

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index f2c23ea..b6a338b 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -679,14 +679,8 @@ static struct platform_device power_supply = {
  */
 
 static struct regulator_consumer_supply bq24022_consumers[] = {
-	{
-		.dev = &gpio_vbus.dev,
-		.supply = "vbus_draw",
-	},
-	{
-		.dev = &power_supply.dev,
-		.supply = "ac_draw",
-	},
+	REGULATOR_SUPPLY("vbus_draw", "gpio-vbus"),
+	REGULATOR_SUPPLY("ac_draw", "pda-power"),
 };
 
 static struct regulator_init_data bq24022_init_data = {
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 3d6baf9..1a18e63 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -577,14 +577,8 @@ static struct platform_device power_supply = {
  */
 
 static struct regulator_consumer_supply bq24022_consumers[] = {
-	{
-		.dev = &gpio_vbus.dev,
-		.supply = "vbus_draw",
-	},
-	{
-		.dev = &power_supply.dev,
-		.supply = "ac_draw",
-	},
+	REGULATOR_SUPPLY("vbus_draw", "gpio-vbus"),
+	REGULATOR_SUPPLY("ac_draw", "pda-power"),
 };
 
 static struct regulator_init_data bq24022_init_data = {
-- 
1.7.9.1
