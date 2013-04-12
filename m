From: tim@krieglstein.org (Tim Sander)
Date: Sat, 13 Apr 2013 01:28:17 +0200
Subject: devicetree pinmuxing on beaglebone
Message-ID: <201304130128.17892.tim@krieglstein.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

I have a patched kernel with devicetree support. The kernel version i got 
running was 3.8.4. Unfortunatly with loads of patches.
After searching hours* for the right settings for pinmux in devicetree
i came up with the following fragment which i tried to drop into the end of 
am335x-bone.dts:

/ {
fragment at 0 {
   target = <&am33xx_pinmux>;
   __overlay__ {
      wind_pins:pinctrl-single,pins = <
         0x000  0x27      /* gpmc_ad0 = ad0 = P8-25 = gpio1_0|input, no 
pullup, gpio mux  */
         0x004  0x27      /* gpmc_ad1 = ad1 = P8-24 = gpio1_1|input, no 
pullup, gpio mux  */
         0x008  0x27      /* gpmc_ad2 = ad2 = P8-5 = gpio1_2|input, no pullup, 
gpio mux  */
         0x00c  0x27      /* gpmc_ad3 = ad3 = P8-6 = gpio1_3|input, no pullup, 
gpio mux  */
         0x020  0x27      /* gpmc_ad8  = ehrpwm2A = P8_19 = gpio0 22|input, no 
pullup, gpio mux */
      >;
   };
};
};

I am not sure if the offsets/values are correct (see below) but the dtc 
compiled without error. But i don't think it does any value checking?
But booting this thing i could not see any changes in the debugfs 
representation of the pinmux driver. Any ideas why these pinmux changes don't 
change up?

Thanks
Tim



*First the pinmux is not described in the kernel documentation for the 
beaglebone. It took me quite a while to figure out that there was an magic 
offset to of 0x800 to the first value. This was caused by a stupid 
documentation for the am3359 chip reference where page 811 (9.3.50) only 
states all functions for all mux register and refers to Table 9-10. This table 
contains the offset but the names are not very descriptive and the register 
description is empty ("?$%*!). But it says to look at the device datasheet. 
The device datasheet then says nothing about muxing but refers to a s****** 
windows tool. Please fixup the documentation TI.  
