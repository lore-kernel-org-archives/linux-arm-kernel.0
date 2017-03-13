From: broonie@kernel.org (Mark Brown)
Date: Mon, 13 Mar 2017 16:57:00 +0000
Subject: Applied "regulator: pfuze100-regulator: add coin support" to the
 regulator tree
In-Reply-To: <20170309141443.20564-1-george.mccollister@gmail.com>
Message-ID: <E1cnTHI-0004o3-VJ@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: pfuze100-regulator: add coin support

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c6182ac96096f35c7216e4e6a3c64c7374dadeb7 Mon Sep 17 00:00:00 2001
From: George McCollister <george.mccollister@gmail.com>
Date: Thu, 9 Mar 2017 08:14:43 -0600
Subject: [PATCH] regulator: pfuze100-regulator: add coin support

Add support for PF0200 coin cell/super capacitor charger which works as
a current limited voltage source via the LICELL pin. When VIN goes below
a certain threshold LICELL is used to provide power for VSNVS which is
usually used to hold up secure non-volatile storage and the real-time
clock on the SoC.

Signed-off-by: George McCollister <george.mccollister@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/regulator/pfuze100.txt     |  8 +++++++-
 drivers/regulator/pfuze100-regulator.c             | 24 ++++++++++++++++++++++
 include/linux/regulator/pfuze100.h                 |  1 +
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/pfuze100.txt b/Documentation/devicetree/bindings/regulator/pfuze100.txt
index 9b40db88f637..444c47831a40 100644
--- a/Documentation/devicetree/bindings/regulator/pfuze100.txt
+++ b/Documentation/devicetree/bindings/regulator/pfuze100.txt
@@ -13,7 +13,7 @@ Required child node:
   --PFUZE100
   sw1ab,sw1c,sw2,sw3a,sw3b,sw4,swbst,vsnvs,vrefddr,vgen1~vgen6
   --PFUZE200
-  sw1ab,sw2,sw3a,sw3b,swbst,vsnvs,vrefddr,vgen1~vgen6
+  sw1ab,sw2,sw3a,sw3b,swbst,vsnvs,vrefddr,vgen1~vgen6,coin
   --PFUZE3000
   sw1a,sw1b,sw2,sw3,swbst,vsnvs,vrefddr,vldo1,vldo2,vccsd,v33,vldo3,vldo4
 
@@ -205,6 +205,12 @@ Example 2: PFUZE200
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 			};
+
+			coin_reg: coin {
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
 		};
 	};
 
diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index cb18b5c4f2db..716abcc834c8 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -40,6 +40,7 @@
 #define PFUZE100_REVID		0x3
 #define PFUZE100_FABID		0x4
 
+#define PFUZE100_COINVOL	0x1a
 #define PFUZE100_SW1ABVOL	0x20
 #define PFUZE100_SW1CVOL	0x2e
 #define PFUZE100_SW2VOL		0x35
@@ -81,6 +82,10 @@ static const int pfuze100_vsnvs[] = {
 	1000000, 1100000, 1200000, 1300000, 1500000, 1800000, 3000000,
 };
 
+static const int pfuze100_coin[] = {
+	2500000, 2700000, 2800000, 2900000, 3000000, 3100000, 3200000, 3300000,
+};
+
 static const int pfuze3000_sw2lo[] = {
 	1500000, 1550000, 1600000, 1650000, 1700000, 1750000, 1800000, 1850000,
 };
@@ -230,6 +235,23 @@ static struct regulator_ops pfuze100_swb_regulator_ops = {
 		.stby_mask = 0x20,	\
 	}
 
+#define PFUZE100_COIN_REG(_chip, _name, base, mask, voltages)	\
+	[_chip ## _ ##  _name] = {	\
+		.desc = {	\
+			.name = #_name,	\
+			.n_voltages = ARRAY_SIZE(voltages),	\
+			.ops = &pfuze100_swb_regulator_ops,	\
+			.type = REGULATOR_VOLTAGE,	\
+			.id = _chip ## _ ## _name,	\
+			.owner = THIS_MODULE,	\
+			.volt_table = voltages,	\
+			.vsel_reg = (base),	\
+			.vsel_mask = (mask),	\
+			.enable_reg = (base),	\
+			.enable_mask = 0x8,	\
+		},	\
+	}
+
 #define PFUZE3000_VCC_REG(_chip, _name, base, min, max, step)	{	\
 	.desc = {	\
 		.name = #_name,	\
@@ -317,6 +339,7 @@ static struct pfuze_regulator pfuze200_regulators[] = {
 	PFUZE100_VGEN_REG(PFUZE200, VGEN4, PFUZE100_VGEN4VOL, 1800000, 3300000, 100000),
 	PFUZE100_VGEN_REG(PFUZE200, VGEN5, PFUZE100_VGEN5VOL, 1800000, 3300000, 100000),
 	PFUZE100_VGEN_REG(PFUZE200, VGEN6, PFUZE100_VGEN6VOL, 1800000, 3300000, 100000),
+	PFUZE100_COIN_REG(PFUZE200, COIN, PFUZE100_COINVOL, 0x7, pfuze100_coin),
 };
 
 static struct pfuze_regulator pfuze3000_regulators[] = {
@@ -371,6 +394,7 @@ static struct of_regulator_match pfuze200_matches[] = {
 	{ .name = "vgen4",	},
 	{ .name = "vgen5",	},
 	{ .name = "vgen6",	},
+	{ .name = "coin",	},
 };
 
 /* PFUZE3000 */
diff --git a/include/linux/regulator/pfuze100.h b/include/linux/regulator/pfuze100.h
index 70c6c66c5bcf..e0ccf46f66cf 100644
--- a/include/linux/regulator/pfuze100.h
+++ b/include/linux/regulator/pfuze100.h
@@ -48,6 +48,7 @@
 #define PFUZE200_VGEN4		10
 #define PFUZE200_VGEN5		11
 #define PFUZE200_VGEN6		12
+#define PFUZE200_COIN		13
 
 #define PFUZE3000_SW1A		0
 #define PFUZE3000_SW1B		1
-- 
2.11.0
