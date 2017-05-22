From: angus@akkea.ca (Angus Ainslie)
Date: Sun, 21 May 2017 22:52:32 -0600
Subject: CHIPPro NAND issue with 4.12 rc1
In-Reply-To: <20170521074535.4a4ba6dd@bbrezillon>
References: <399ea126f3b18071fbe46bfc9787df6b@www.akkea.ca>
 <20170520171418.4e8a47e0@bbrezillon>
 <6f3cefa6c54776f82160ed8954f4d0d4@www.akkea.ca>
 <20170521074535.4a4ba6dd@bbrezillon>
Message-ID: <c3cdc21db2d80daed6281d7cfaeba165@www.akkea.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-05-20 23:45, Boris Brezillon wrote:
> Le Sat, 20 May 2017 15:24:06 -0600,
> Angus Ainslie <angus@akkea.ca> a ?crit :
> 
>> On 2017-05-20 09:14, Boris Brezillon wrote:
>> > Le Sat, 20 May 2017 08:49:04 -0600,
>> > Angus Ainslie <angus@akkea.ca> a ?crit :
>> >
>> >> Hi All,
>> >>
>> >> I'm trying to boot a CHIPPro with the stock 4.12 rc1 kernel. If I make
>> >> no modifications to the sun5i-gr8-chip-pro.dtb the kernel boots but
>> >> can't find the root partition.
>> >>
>> >> So I added the partitions to the dts file
>> >>
>> >> diff --git a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
>> >> b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
>> >> index c55b11a..0e61e6b 100644
>> >> --- a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
>> >> +++ b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
>> >> @@ -146,6 +146,32 @@
>> >>                  reg = <0>;
>> >>                  allwinner,rb = <0>;
>> >>                  nand-ecc-mode = "hw";
>> >> +    nand-on-flash-bbt;
>> >> +
>> >> +    spl at 0 {
>> >> +      label = "SPL";
>> >> +      reg = /bits/ 64 <0x0 0x400000>;
>> >> +    };
>> >> +
>> >> +    spl-backup at 400000 {
>> >> +      label = "SPL.backup";
>> >> +      reg = /bits/ 64 <0x400000 0x400000>;
>> >> +    };
>> >> +
>> >> +    u-boot at 800000 {
>> >> +      label = "U-Boot";
>> >> +      reg = /bits/ 64 <0x800000 0x400000>;
>> >> +    };
>> >> +
>> >> +    env at c00000 {
>> >> +      label = "env";
>> >> +      reg = /bits/ 64 <0xc00000 0x400000>;
>> >> +    };
>> >> +
>> >> +    rootfs at 1000000 {
>> >> +      label = "rootfs";
>> >> +      reg = /bits/ 64 <0x1000000 0x1f000000>;
>> >> +    };
>> >>          };
>> >>   };
>> >>
>> >> and now the kernel finds the partition but it times out trying to
>> >> mount
>> >> it. It seems to be something in the dts files because if I use the
>> >> ntc-gr8-crumb.dts from the ntc 4.4.30 kernel then the system boots all
>> >> the way to userland.
>> >
>> > Hm, that's weird. Just changing the dtb makes it work? Did you try to
>> > dump both dtbs and figure out what else changes?
>> >
>> 
>> Yeah I thought it was weird too. I was thinking that maybe the pin 
>> muxes
>> were getting changed and the rb net or the interrupt net was getting
>> changed to a different function.
>> 
>> I did decompile to 2 dtb's and I couldn't find many differences. They
>> were mostly around some pull ups and drive strength for some of the 
>> NAND
>> and i2c pins. I tried adding those changes and it still didn't work so 
>> I
>> went back to the minimal set of changes to reproduce the bug.
>> 
>> > Also, I wonder how the NAND is correctly detected without this patch
>> > [1].
>> >
>> 
>> 
>> That patch seems to be in my 4.12-rc1 kernel, I have a definition for
>> the TC58NVG2S0H.
>> 
>> >>
>> >> [    7.130000] ubi0: scanning is finished
>> >> [    7.150000] ubi0: attached mtd4 (name "rootfs", size 496 MiB)
>> >> [    7.160000] ubi0: PEB size: 262144 bytes (256 KiB), LEB size:
>> >> 258048
>> >> bytes
>> >> [    7.170000] ubi0: min./max. I/O unit sizes: 4096/4096, sub-page
>> >> size
>> >> 1024
>> >> [    7.180000] ubi0: VID header offset: 1024 (aligned 1024), data
>> >> offset: 4096
>> >> [    7.190000] ubi0: good PEBs: 1977, bad PEBs: 7, corrupted PEBs: 0
>> >> [    7.200000] ubi0: user volume: 1, internal volumes: 1, max. volumes
>> >> count: 128
>> >> [    7.210000] ubi0: max/mean erase counter: 3/1, WL threshold: 4096,
>> >> image sequence number: 1444477407
>> >> [    7.220000] ubi0: available PEBs: 1, total reserved PEBs: 1976,
>> >> PEBs
>> >> reserved for bad PEB handling: 33
>> >
>> > UBI attach works...
>> >
>> >> [    7.240000] hctosys: unable to open rtc device (rtc0)
>> >> [    7.250000] vcc3v0: disabling
> 
> Interestingly, it starts failing after the core disables all unused
> regulators. Not sure this is related but that's worth having a look.
> 
> I looked at the schematics and it seems VCC-3V3 (which is powering the
> NAND chip) is enabled with the EXTEN pin of the AXP209 [1]. I don't 
> know
> if this pin is controlled by Linux, but maybe you can dump register
> 0x12 and check if EXTEN is set to 1.
> 

I didn't manage to dump the register but I did go in and turn vcc3v0 and 
vcc3v3 to regulator-always-on and added another change from the 
ntc-gr8-crumb dts file to couple the two 3v3 regulators.

diff --git a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts 
b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
index c55b11a..6744e78 100644
--- a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
+++ b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
@@ -83,6 +83,18 @@
                 pinctrl-0 = <&wifi_reg_on_pin_chip_pro>;
                 reset-gpios = <&pio 1 10 GPIO_ACTIVE_LOW>; /* PB10 */
         };
+
+  /*
+  * Both LDO3 and LDO4 are used in parallel to power up the
+  * WiFi/BT Chip.
+  */
+  vcc_wifi: wifi_reg {
+    compatible = "coupled-voltage-regulator";
+    regulator-name = "vcc-wifi";
+    vin0-supply = <&reg_ldo3>;
+    vin1-supply = <&reg_ldo4>;
+  };
+
  };

  &codec {
@@ -128,7 +140,7 @@
  &mmc0 {
         pinctrl-names = "default";
         pinctrl-0 = <&mmc0_pins_a>;
-       vmmc-supply = <&reg_vcc3v3>;
+       vmmc-supply = <&vcc_wifi>;
         mmc-pwrseq = <&mmc0_pwrseq>;
         bus-width = <4>;
         non-removable;
@@ -146,6 +158,32 @@
                 reg = <0>;
                 allwinner,rb = <0>;
                 nand-ecc-mode = "hw";
+    nand-on-flash-bbt;
+
+    spl at 0 {
+      label = "SPL";
+      reg = /bits/ 64 <0x0 0x400000>;
+    };
+
+    spl-backup at 400000 {
+      label = "SPL.backup";
+      reg = /bits/ 64 <0x400000 0x400000>;
+    };
+
+    u-boot at 800000 {
+      label = "U-Boot";
+      reg = /bits/ 64 <0x800000 0x400000>;
+    };
+
+    env at c00000 {
+      label = "env";
+      reg = /bits/ 64 <0xc00000 0x400000>;
+    };
+
+    rootfs at 1000000 {
+      label = "rootfs";
+      reg = /bits/ 64 <0x1000000 0x1f000000>;
+    };
         };
  };
diff --git a/arch/arm/boot/dts/sunxi-common-regulators.dtsi 
b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
index ce5c53e..c2078fb 100644
--- a/arch/arm/boot/dts/sunxi-common-regulators.dtsi
+++ b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
@@ -123,6 +123,7 @@
                 regulator-name = "vcc3v0";
                 regulator-min-microvolt = <3000000>;
                 regulator-max-microvolt = <3000000>;
+    regulator-always-on;
         };

         reg_vcc3v3: vcc3v3 {
@@ -130,6 +131,7 @@
                 regulator-name = "vcc3v3";
                 regulator-min-microvolt = <3300000>;
                 regulator-max-microvolt = <3300000>;
+    regulator-always-on;
         };

         reg_vcc5v0: vcc5v0 {





With those changes to the regulators I no longer get the messages about 
the 3v0 being disabled but I still get the timeouts.


[    5.690000] hub 2-0:1.0: USB hub found
[    5.700000] hub 2-0:1.0: 1 port detected
[    5.700000] usb_phy_generic usb_phy_generic.0.auto: 
usb_phy_generic.0.auto supply vcc not found, using dummy regulator
[    5.720000] musb-hdrc musb-hdrc.1.auto: MUSB HDRC host driver
[    5.730000] musb-hdrc musb-hdrc.1.auto: new USB bus registered, 
assigned bus number 3
[    5.740000] hub 3-0:1.0: USB hub found
[    5.750000] hub 3-0:1.0: 1 port detected
[    5.760000] using random self ethernet address
[    5.760000] using random host ethernet address
[    5.770000] usb0: HOST MAC 42:44:eb:6b:73:54
[    5.780000] usb0: MAC aa:58:90:ec:b0:0c
[    5.780000] g_cdc gadget: CDC Composite Gadget, version: King 
Kamehameha Day 2008
[    5.790000] g_cdc gadget: g_cdc ready
[    5.800000] ubi0: attaching mtd4
[    6.340000] g_cdc gadget: high-speed config #1: CDC Composite (ECM + 
ACM)
[    7.070000] ubi0: scanning is finished
[    7.080000] ubi0: attached mtd4 (name "rootfs", size 496 MiB)
[    7.090000] ubi0: PEB size: 262144 bytes (256 KiB), LEB size: 258048 
bytes
[    7.100000] ubi0: min./max. I/O unit sizes: 4096/4096, sub-page size 
1024
[    7.110000] ubi0: VID header offset: 1024 (aligned 1024), data 
offset: 4096
[    7.120000] ubi0: good PEBs: 1977, bad PEBs: 7, corrupted PEBs: 0
[    7.130000] ubi0: user volume: 1, internal volumes: 1, max. volumes 
count: 128
[    7.140000] ubi0: max/mean erase counter: 3/1, WL threshold: 4096, 
image sequence number: 1444477407
[    7.160000] ubi0: available PEBs: 1, total reserved PEBs: 1976, PEBs 
reserved for bad PEB handling: 33
[    7.170000] hctosys: unable to open rtc device (rtc0)
[    7.180000] ALSA device list:
[    7.180000]   #0: sun4i-codec
[    7.190000] ubi0: background thread "ubi_bgt0d" started, PID 51
[    8.240000] sunxi_nand 1c03000.nand: wait interrupt timedout
[    9.240000] sunxi_nand 1c03000.nand: wait interrupt timedout
[   10.250000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
