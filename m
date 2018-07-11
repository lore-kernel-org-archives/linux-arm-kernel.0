From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 11 Jul 2018 10:02:18 +0200
Subject: Vibrations on Droid 4?
In-Reply-To: <20180710161123.azym6sbboriuj4yc@earth.universe>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
Message-ID: <20180711080218.GA21225@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Its parent is gpio at 4805d000 , and that one seems to be present.
> > 
> > user at devuan:/sys/bus/platform/devices$ ls 4805d000.gpio
> > driver				       driver_override  gpio
> > gpiochip5  modalias  of_node  power  subsystem  uevent
> 
> Sorry, something went wrong with merging this. The parent
> of ti,omap-dmtimer-pwm and pwm-vibrator should be / and
> not gpio6.

Ok, got it to probe... after dts fix and adding EPROBE_DEFFER to
driver.

Still can't get it to actually vibrate. 

user at devuan:/sys/bus/platform/drivers/pwm-vibrator/vibrator$ sudo fftest /dev/input/event3
Force feedback test program.
HOLD FIRMLY YOUR WHEEL OR JOYSTICK TO PREVENT DAMAGES

Device /dev/input/event3 opened
Features:
  * Absolute axes: 
    [00 00 00 00 00 00 00 00 ]
  * Relative axes: 
    [00 00 ]
  * Force feedback effects types: Periodic, Rumble, Gain, 
    Force feedback periodic effects: Square, Triangle, Sine, 
    [00 00 00 00 00 00 00 00 00 00 03 07 01 00 00 00 ]
  * Number of simultaneous effects: 16

Setting master gain to 75% ... OK
Uploading effect #0 (Periodic sinusoidal) ... OK (id 0)
Uploading effect #1 (Constant) ... Error: Invalid argument
Uploading effect #2 (Spring) ... Error: Invalid argument
Uploading effect #3 (Damper) ... Error: Invalid argument
Uploading effect #4 (Strong rumble, with heavy motor) ... OK (id 1)
Uploading effect #5 (Weak rumble, with light motor) ... OK (id 2)
Enter effect number, -1 to exit
5
Now Playing: Weak Rumble
Enter effect number, -1 to exit

0
Now Playing: Sine vibration
Enter effect number, -1 to exit
5
Now Playing: Weak Rumble
Enter effect number, -1 to exit
^C



diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index 45305e8..c27fc87 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -159,13 +159,7 @@
 
 		dais = <&mcbsp2_port>, <&mcbsp3_port>;
 	};
-};
-
-&dss {
-	status = "okay";
-};
 
-&gpio6 {
 	pwm8: dmtimer-pwm-8 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&vibrator_direction_pin>;
@@ -192,7 +186,10 @@
 		pwm-names = "enable", "direction";
 		direction-duty-cycle-ns = <10000000>;
 	};
+};
 
+&dss {
+	status = "okay";
 };
 
 &dsi1 {
diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 665da3c..debeb70 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -265,7 +271,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	timer_pdata = dev_get_platdata(&timer_pdev->dev);
 	if (!timer_pdata) {
 		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
-		ret = -EINVAL;
+		ret = -EPROBE_DEFER;
 		goto put;
 	}
 


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180711/babf08ad/attachment.sig>
