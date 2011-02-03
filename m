From: mboards@prograde.net (Michael Cashwell)
Date: Thu, 3 Feb 2011 07:52:58 -0500
Subject: PXA270 Random Hangs at Low Core Freq
In-Reply-To: <201102031404.02387.anarsoul@gmail.com>
References: <471CD45F-4531-4C87-B292-411CE519D0A5@prograde.net>
	<AANLkTi=Y-JYQ_eZ4EdNirPrm_xkiduSZP19BPWckP2iW@mail.gmail.com>
	<A6E7D305-39A1-42B3-8A2B-0D2CDBBE5EEE@prograde.net>
	<201102031404.02387.anarsoul@gmail.com>
Message-ID: <B43F6614-5BE3-4C9A-849E-5E8D4C189DF5@prograde.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Feb 3, 2011, at 7:04 AM, Vasily Khoruzhick wrote:

> On Tuesday 26 October 2010 20:06:36 Michael Cashwell wrote:
> 
>> Voltage slewing is an area I had been working on. The TPS65023 driver has some problems (like failing to actually command a voltage change!). I'm going to submit patches for this but it's not involved in the problem as it's disabled in my kernel config. The Verdex Pro PMIC is strapped to come out of reset at a core voltage of 1.55VDC (verified on a scope). That's high enough to support all core speeds.
> 
> Hi, Michael, can you share your patches for TPS65023?

Sure! Happy to. It applies cleanly at least up to 2.6.35.7 which is what I'm actually currently using.

There's certainly room for improvement given the ugly udelay() but at least it works. (My main idea for improvement would be to actually do the math to calculate the voltage delta and wait only the needed time rather than the full-swing worst case.)

-Mike

diff -Nurp linux-2.6.33.2/drivers/regulator/tps65023-regulator.c linux-2.6.33.2-arm-gum-MOD/drivers/regulator/tps65023-regulator.c
--- linux-2.6.33.2/drivers/regulator/tps65023-regulator.c	2010-04-01 19:02:33.000000000 -0400
+++ linux-2.6.33.2-arm-gum-MOD/drivers/regulator/tps65023-regulator.c	2010-05-12 13:57:27.000000000 -0400
@@ -126,6 +126,7 @@ struct tps_pmic {
 	struct regulator_dev *rdev[TPS65023_NUM_REGULATOR];
 	const struct tps_info *info[TPS65023_NUM_REGULATOR];
 	struct mutex io_lock;
+	int last_core_index;
 };
 
 static inline int tps_65023_read(struct tps_pmic *tps, u8 reg)
@@ -325,7 +326,7 @@ static int tps65023_dcdc_set_voltage(str
 {
 	struct tps_pmic *tps = rdev_get_drvdata(dev);
 	int dcdc = rdev_get_id(dev);
-	int vsel;
+	int i, data, vsel;
 
 	if (dcdc != TPS65023_DCDC_1)
 		return -EINVAL;
@@ -346,11 +347,63 @@ static int tps65023_dcdc_set_voltage(str
 			break;
 	}
 
-	/* write to the register in case we found a match */
+	/* it's an error if no acceptable entry was found */
 	if (vsel == tps->info[dcdc]->table_len)
 		return -EINVAL;
-	else
-		return tps_65023_reg_write(tps, TPS65023_REG_DEF_CORE, vsel);
+
+	/* set new target voltage index */
+	data = tps_65023_reg_write(tps, TPS65023_REG_DEF_CORE, vsel);
+	if (data < 0)
+		return data;
+
+	/* read CTRL2 */
+	data = tps_65023_reg_read(tps, TPS65023_REG_CON_CTRL2);
+	if (data < 0)
+		return data;
+
+	/* error if GO bit is still set from a previous op */
+	if (data & BIT(7))
+		return -EIO;
+
+	/* set the GO bit while preserving only the discharge enables */
+	data = BIT(7) | (data & 7);
+
+	data = tps_65023_reg_write(tps, TPS65023_REG_CON_CTRL2, data);
+	if (data < 0)
+		return data;
+
+	/* and if we're raising the voltage, wait for the PMIC to process it.
+	otherwise we return too soon and the CPU frequency increase that's
+	likely being paired with this step up in voltage could happen before
+	the voltage actually increases. this can cause core failures. */
+
+	if (vsel > tps->last_core_index) {
+		/* first, wait for the PMIC to clear the GO bit.
+		that indicates the voltage slew has started. */
+		i = 4;	/* in practice, one read seems to be enough */
+		do {
+			i--;
+			data = tps_65023_reg_read(tps, TPS65023_REG_CON_CTRL2);
+			if (data < 0)
+				return data;
+		} while (i && (data & BIT(7)));
+
+		if (i == 0)
+			return -EIO;
+
+		/* it would be nice if the PMIC provided an indication for
+		when slewing is complete. but alas, no. so we wait long
+		enough to cover the worst-case.
+		slewing 550mV@the default rate of 14.4mV/uS is about
+		40uS. but that's just the setpoint slew. full output
+		regulation takes even longer due to filter caps. */
+		udelay(100);
+	}
+	
+	/* note the new index for next time. */
+	tps->last_core_index = vsel;
+
+	return 0;
 }
 
 static int tps65023_ldo_get_voltage(struct regulator_dev *dev)
