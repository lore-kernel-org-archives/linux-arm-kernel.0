From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 3 Nov 2017 22:03:49 +0100
Subject: Battery charging, battery status on Nokia N9, N950
Message-ID: <20171103210349.GA14071@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I'm fighting with battery status & battery charging on Nokia
N9/N950. https://elinux.org/N950 contains enough info to get battery
status (and below is first attempt at kernel implementation), but I'm
not sure what needs to be done to charge the battery (or at least
power phone from USB).

Any ideas?

Thanks,
							Pavel

commit ef0a23a4d522489c4aa7be114bbc1acb604b35b6
Author: Pavel <pavel@ucw.cz>
Date:   Fri Nov 3 21:34:53 2017 +0100

    Add support for bq27521 battery gauge.
    
    Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index 6fc1acc..b42a265 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -276,6 +276,26 @@
 
 &i2c2 {
 	clock-frequency = <400000>;
+
+	bq27521: bq27521 at 55 {
+		compatible = "ti,bq27521";
+		reg = <0x55>;
+	};
+
+
+	bq24153a at 6b {
+		compatible = "ti,bq24150a";
+ 		reg = <0x6b>;
+
+                ti,current-limit = <100>;
+ 		ti,weak-battery-voltage = <3400>;
+ 		ti,battery-regulation-voltage = <4000>; /* FIXME: 4200 */
+ 		ti,charge-current = <500>; /* FIXME: 650 */
+ 		ti,termination-current = <100>;
+
+		ti,resistor-sense = <68>;
+ 		ti,usb-charger-detection = <&twl_power>;
+	};
 };
 
 &i2c3 {
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index ed44439..4ab2bfc 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -381,6 +381,30 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
 		BQ27XXX_DM_REG_ROWS,
 	},
+	[BQ27521] = {				/* FIXME */
+		[BQ27XXX_REG_CTRL] = 0x02,
+		[BQ27XXX_REG_TEMP] = 0x0a,
+		[BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_VOLT] = 0x0c,
+		[BQ27XXX_REG_AI] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_FLAGS] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTE] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_NAC] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_FCC] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_CYCT] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_SOC] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_DCAP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_CTRL] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_CLASS] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_BLOCK] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_DATA] = INVALID_REG_ADDR,
+		[BQ27XXX_DM_CKSUM] = INVALID_REG_ADDR,
+	},
 	[BQ27530] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
 		[BQ27XXX_REG_TEMP] = 0x06,
@@ -700,6 +724,15 @@ static enum power_supply_property bq27520g4_battery_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
+static enum power_supply_property bq27521_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+};
+
 static enum power_supply_property bq27530_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -792,6 +825,7 @@ static struct {
 	BQ27XXX_PROP(BQ27520G2, bq27520g2_battery_props),
 	BQ27XXX_PROP(BQ27520G3, bq27520g3_battery_props),
 	BQ27XXX_PROP(BQ27520G4, bq27520g4_battery_props),
+	BQ27XXX_PROP(BQ27521, bq27521_battery_props),
 	BQ27XXX_PROP(BQ27530, bq27530_battery_props),
 	BQ27XXX_PROP(BQ27541, bq27541_battery_props),
 	BQ27XXX_PROP(BQ27545, bq27545_battery_props),
@@ -1529,6 +1563,7 @@ static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
 	case BQ27520G2:
 	case BQ27520G3:
 	case BQ27520G4:
+	case BQ27521:
 	case BQ27541:
 	case BQ27545:
 		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
@@ -1594,6 +1629,11 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 	bool has_ci_flag = di->chip == BQ27000 || di->chip == BQ27010;
 	bool has_singe_flag = di->chip == BQ27000 || di->chip == BQ27010;
 
+	if (di->chip == BQ27521) {
+		di->cache.flags = 0;
+		return;
+	}
+
 	cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
 	if ((cache.flags & 0xff) == 0xff)
 		cache.flags = -1; /* read error */
@@ -1792,11 +1832,14 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
 		return -ENODEV;
 
+	printk("bq27: get property %d\n", psp);
+
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
 		ret = bq27xxx_battery_status(di, val);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		printk("bq27: get voltage\n");
 		ret = bq27xxx_battery_voltage(di, val);
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
@@ -1998,8 +2041,12 @@ static int bq27xxx_battery_platform_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, di);
 
+	printk("bq27: probe\n");
 	di->dev = &pdev->dev;
 	di->chip = pdata->chip;
+	printk("bq27: probe chip %d\n", di->chip);
+	di->chip = BQ27521;
+	printk("bq27: probe chip %d\n", di->chip);	
 	di->name = pdata->name ?: dev_name(&pdev->dev);
 	di->bus.read = bq27xxx_battery_platform_read;
 
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index a597221..fd9b989 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -239,6 +239,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ "bq27520g2", BQ27520G2 },
 	{ "bq27520g3", BQ27520G3 },
 	{ "bq27520g4", BQ27520G4 },
+	{ "bq27521", BQ27521 },
 	{ "bq27530", BQ27530 },
 	{ "bq27531", BQ27530 },
 	{ "bq27541", BQ27541 },
@@ -269,6 +270,7 @@ static const struct of_device_id bq27xxx_battery_i2c_of_match_table[] = {
 	{ .compatible = "ti,bq27520g2" },
 	{ .compatible = "ti,bq27520g3" },
 	{ .compatible = "ti,bq27520g4" },
+	{ .compatible = "ti,bq27521" },
 	{ .compatible = "ti,bq27530" },
 	{ .compatible = "ti,bq27531" },
 	{ .compatible = "ti,bq27541" },
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 11e1168..1e80931 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -14,6 +14,7 @@ enum bq27xxx_chip {
 	BQ27520G2, /* bq27520G2 */
 	BQ27520G3, /* bq27520G3 */
 	BQ27520G4, /* bq27520G4 */
+	BQ27521, /* bq27521 */	
 	BQ27530, /* bq27530, bq27531 */
 	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
 	BQ27545, /* bq27545 */



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171103/bc22fcf5/attachment-0001.sig>
