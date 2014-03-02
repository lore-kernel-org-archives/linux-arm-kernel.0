From: linux@baker-net.org.uk (Adam Baker)
Date: Sun, 02 Mar 2014 23:44:10 +0000
Subject: Device Tree file for Zyxel NSA320
In-Reply-To: <20140301103417.GK27832@lunn.ch>
References: <53112C83.9010700@baker-net.org.uk>
 <20140301103417.GK27832@lunn.ch>
Message-ID: <5313C24A.9070306@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/14 10:34, Andrew Lunn wrote:
> On Sat, Mar 01, 2014 at 12:40:35AM +0000, Adam Baker wrote:
>> Hi,
>>
>> I've been trying to get my Zyxel NSA320 working with kernel 3.14-rc1
>> and device tree. I've included on CC the two developers who produced
>> old style board files for the NSA310 / 320 in case you've already
>> looked at this.
>
> Hi Adam
>
> It is good to also CC the Marvell maintainers. I added them.
>

Thanks for that.

> First off, thanks for working on a new board.
>
>> I've developed a file (below) which is enough to get it to boot but
>> I've got a couple of outstanding issues that I'd appreciate some
>> advice on.
>
> Great. I will review it and try to help with your issues.
>
>> First, the USB ports aren't working. I presume this is because on
>> this board mpp21, instead of taking it's usual role as
>> MPP21_SATA0_ACTn is used as a control line for power to the USB
>> ports. My dmesg contains
>>
snip
>> so I suspect it has defaulted to the right mode but
>> /sys/kernel/debug/gpio says
>>
>>   gpio-21  (USB Power Off       ) out lo
>
> What is interesting is that it has the name. Some something is working
> here. What might help is turning on REGULATOR_DEBUG.

I'm now suspicious as to whether this actually works on NSA310. The 
regulator was named USB Power Off and was set to always-on. Hence USB 
Power Off was always enabled, i.e. USB was off. Changing the name 
(because having the word off in the name of a regulator doesn't make 
sense) and making it an active high regulator brings the USB to life.

Whilst debugging this issue I thought it would be helpful to be able to 
access the GPIO and pin multiplexing state from user space. I've 
therefore attached a small program I wrote to do that in case it is of 
use to others. It assumes the normal mapping of the processor I/O block 
to 0xf1000000.

>
>> The other issue I've found is that the Ethernet only works if I have
>> booted the original kernel at least once since the unit was powered
>> on. It does get the correct MAC address when it doesn't work. I'm
>> not sure what might be causing that other than that Ethernet from
>> uboot apparently only works if connected to a 1G switch.
>
> This sounds like a phy issue. You have it at address one. Does your
> u-boot have the commands:
>
> Marvell>> help phyRead
> phyRead  Phy_address Phy_offset.
>          Read the Phy register.
>
> What do you get with:
>
> phyRead 1 0
>

Yes, uboot does have that command but I can no longer reproduce the 
failure. I'll keep watching this in case it fails again.

>> Whilst writing this device tree file I have noticed that the
>> Ethernet node is missing from the NSA310 files. Unfortunately there
>> are 2 variants of the 310 and I've only ever seen one board setup
>> file that specifies the phy number and as that doesn't match the 320
>> I don't feel able to fix that without someone to test it.
>
> We can probably get somebody to test, if you can provide a patch.

Once I'm happy with the rest of the changes I'll add the Ethernet node 
to the nsa310 files and assume the phy number is 0 for both as that is 
the only value I can find in board setup files for the 310.

>
>> I do realise that when sending this as a proper patch you will need
>> a signed off by and you will need it sent via something other than
>> Thunderbird that can be relied upon not to mangle the patch.
>
> git send-email is the preferred method.
>

I'll use that once I get something that is fit to submit then

For now I'll answer your comments then attach the latest diff


>
> You have a mixture of tabs and space in this file. Please use tabs.
>
I'd fixed that then forgot to stage the change - sorry.


>> +			pmx_unknown: pmx-unknown {
>> +				marvell,pins = "mpp44";
>> +				marvell,function = "gpio";
>> +			};
>> +
>> +			pmx_btn_power: pmx-btn-power {
>> +				marvell,pins = "mpp46";
>> +				marvell,function = "gpio";
>> +			};
>> +		};
>
> These all look identical to nsa310. Maybe it makes sense to refactor
> kirkwood-nsa310.dts and place the common parts into a .dtsi file?
>
They were copy / pasted with just the one change I'd spotted at the time 
(esata is now hdd2) but I've since found some more differences. I'll 
refactor once I get to the bottom of what really is common.

>> +			pcf8563: pcf8563 at 51 {
>> +				compatible = "pcf8563";
>
> Please put a vendor name in the compatible string. So it should be
> "nxp,pcf8563". We have only just started to enforce this, and lots of
> existing files need fixing.
>
done

My biggest outstanding issue is now with the GPIO pins that are not used 
in any of the setup files I have seen. Running my pin state monitor with 
the vendor kernel I can see that that configures some of the unused 
pins, 43, 45 and 49 as GPIO inputs. Currently 43 ends up configured as a 
TDM input which isn't too bad, 45 ends up configured as TDM I/O and 49 
ends up configured as GPIO output which ought to be fixed as it will 
increase power consumption if nothing else. It seems the 
marvell,function in the pinctrl is ignored if the pin isn't used. Is 
there a good way to fix that?

I've located a driver at http://pastebin.com/3LNtYZSD that claims to be 
able to use some of the other unused pins to talk to a temperature 
sensor and also uses these pins to configure the response to power on 
after a power failure so I guess that needs adding eventually too.


diff --git a/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi 
b/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
index aa78c2d..63e1b6f 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
@@ -7,7 +7,7 @@
  	ocp at f1000000 {
  		pinctrl: pinctrl at 10000 {

-			pmx_usb_power_off: pmx-usb-power-off {
+			pmx_usb_power: pmx-usb-power {
  				marvell,pins = "mpp21";
  				marvell,function = "gpio";
  			};
@@ -47,17 +47,18 @@
  		compatible = "simple-bus";
  		#address-cells = <1>;
  		#size-cells = <0>;
-		pinctrl-0 = <&pmx_usb_power_off>;
+		pinctrl-0 = <&pmx_usb_power>;
  		pinctrl-names = "default";

-		usb0_power_off: regulator at 1 {
+		usb0_power: regulator at 1 {
  			compatible = "regulator-fixed";
  			reg = <1>;
-			regulator-name = "USB Power Off";
+			regulator-name = "USB Power";
  			regulator-min-microvolt = <5000000>;
  			regulator-max-microvolt = <5000000>;
  			regulator-always-on;
  			regulator-boot-on;
+			enable-active-high;
  			gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;
  		};
  	};
diff --git a/arch/arm/boot/dts/kirkwood-nsa320.dts 
b/arch/arm/boot/dts/kirkwood-nsa320.dts
new file mode 100644
index 0000000..43f1e1d
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-nsa320.dts
@@ -0,0 +1,252 @@
+/dts-v1/;
+
+/* Device tree file for the Zyxel NSA 320 NAS box.
+   Based upon the board setup file created by Peter Schildmann */
+
+#include "kirkwood-nsa310-common.dtsi"
+
+/ {
+	model = "Zyxel NSA320";
+	compatible = "zyxel,nsa320", "marvell,kirkwood-88f6281", 
"marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+	};
+
+	mbus {
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+		};
+	};
+
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+			pinctrl-names = "default";
+
+			/* SATA Activity and Present pins are not connected */
+			pmx_sata0: pmx-sata0 {
+				marvell,pins ;
+				marvell,function = "sata0";
+			};
+
+			pmx_sata1: pmx-sata1 {
+				marvell,pins ;
+				marvell,function = "sata1";
+			};
+
+			pmx_led_hdd2_green: pmx-led-hdd2-green {
+				marvell,pins = "mpp12";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_hdd2_red: pmx-led-hdd2-red {
+				marvell,pins = "mpp13";
+				marvell,function = "gpio";
+			};
+
+			pmx_mcu_data: pmx-mcu-data {
+				marvell,pins = "mpp14";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_usb_green: pmx-led-usb-green {
+				marvell,pins = "mpp15";
+				marvell,function = "gpio";
+			};
+
+			pmx_mcu_clk: pmx-mcu-clk {
+				marvell,pins = "mpp16";
+				marvell,function = "gpio";
+			};
+
+			pmx_mcu_act: pmx-mcu-act {
+				marvell,pins = "mpp17";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_sys_green: pmx-led-sys-green {
+				marvell,pins = "mpp28";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_sys_orange: pmx-led-sys-orange {
+				marvell,pins = "mpp29";
+				marvell,function = "gpio";
+			};
+
+			pmx_btn_reset: pmx-btn-reset {
+				marvell,pins = "mpp36";
+				marvell,function = "gpio";
+			};
+
+			pmx_btn_copy: pmx-btn-copy {
+				marvell,pins = "mpp37";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_copy_green: pmx-led-copy-green {
+				marvell,pins = "mpp39";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_copy_red: pmx-led-copy-red {
+				marvell,pins = "mpp40";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_hdd1_green: pmx-led-hdd1-green {
+				marvell,pins = "mpp41";
+				marvell,function = "gpio";
+			};
+
+			pmx_led_hdd1_red: pmx-led-hdd1-red {
+				marvell,pins = "mpp42";
+				marvell,function = "gpio";
+			};
+
+			pmx_htp: pmx-htp {
+				marvell,pins = "mpp43";
+				marvell,function = "gpio";
+			};
+
+			pmx_buzzer: pmx-buzzer {
+				marvell,pins = "mpp44";
+				marvell,function = "gpio";
+			};
+
+			pmx_vid_b1: pmx-vid-b1 {
+				marvell,pins = "mpp45";
+				marvell,function = "gpio";
+			};
+
+			pmx_btn_power: pmx-btn-power {
+				marvell,pins = "mpp46";
+				marvell,function = "gpio";
+			};
+
+			pmx_power_resume_data: pmx-power-resume-data {
+				marvell,pins = "mpp47";
+				marvell,function = "gpio";
+			};
+
+			pmx_power_resume_clk: pmx-power-resume-clk {
+				marvell,pins = "mpp49";
+				marvell,function = "gpio";
+			};
+		};
+
+		i2c at 11000 {
+			status = "okay";
+
+			pcf8563: pcf8563 at 51 {
+				compatible = "nxp,pcf8563";
+				reg = <0x51>;
+			};
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pmx_btn_reset &pmx_btn_copy &pmx_btn_power>;
+		pinctrl-names = "default";
+
+		button at 1 {
+			label = "Power Button";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		};
+		button at 2 {
+			label = "Copy Button";
+			linux,code = <KEY_COPY>;
+			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
+		};
+		button at 3 {
+			label = "Reset Button";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_hdd2_green &pmx_led_hdd2_red
+			     &pmx_led_usb_green
+			     &pmx_led_sys_green &pmx_led_sys_orange
+			     &pmx_led_copy_green &pmx_led_copy_red
+			     &pmx_led_hdd1_green &pmx_led_hdd1_red
+			     &pmx_buzzer>;
+		pinctrl-names = "default";
+
+		green-sys {
+			label = "nsa320:green:sys";
+			gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
+		};
+		orange-sys {
+			label = "nsa320:orange:sys";
+			gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>;
+		};
+		green-hdd1 {
+			label = "nsa320:green:hdd1";
+			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
+		};
+		red-hdd1 {
+			label = "nsa320:red:hdd1";
+			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+		};
+		green-hdd2 {
+			label = "nsa320:green:hdd2";
+			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
+		};
+		red-hdd2 {
+			label = "nsa320:red:hdd2";
+			gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
+		};
+		green-usb {
+			label = "nsa320:green:usb";
+			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
+		};
+		green-copy {
+			label = "nsa320:green:copy";
+			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		};
+		red-copy {
+			label = "nsa320:red:copy";
+			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+		};
+	};
+	beeper: beeper {
+		compatible = "gpio-beeper";
+		gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+	};
+
+	/* The following pins are currently not assigned to a driver,
+	   some of them should be configured as inputs.
+	pinctrl-0 = <&pmx_mcu_data &pmx_mcu_clk &pmx_mcu_act
+		     &pmx_htp &pmx_vid_b1
+		     &pmx_power_resume_data &pmx_power_resume_clk>; */
+};
+
+&mdio {
+	status = "okay";
+	ethphy0: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
+
+&eth0 {
+	status = "okay";
+	ethernet0-port at 0 {
+		phy-handle = <&ethphy0>;
+	};
+};

-------------- next part --------------
A non-text attachment was scrubbed...
Name: kw-gpio.c
Type: text/x-csrc
Size: 2035 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140302/cf487a73/attachment.bin>
