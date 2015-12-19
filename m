From: m.silentcreek@gmail.com (m.silentcreek at gmail.com)
Date: Sat, 19 Dec 2015 11:15:56 -0800 (PST)
Subject: BUG - Bananapi USB not working on Mainline
In-Reply-To: <2331a2bf-bcdc-4653-9098-65d263d57d1b@googlegroups.com>
References: <CAOP4N=_Ux0FPSRep7AfBVovd59LeDTbBjH=LBdfWDb6Mc3e=Fg@mail.gmail.com>
 <2331a2bf-bcdc-4653-9098-65d263d57d1b@googlegroups.com>
Message-ID: <f048f8d7-4031-4eba-b05f-780cbbcb8f51@googlegroups.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again,

Am Freitag, 18. Dezember 2015 21:22:43 UTC+1 schrieb m.sile... at gmail.com:
> I can confirm there is an issue with USB (not OTG) on the Bananapi in Linux 4.4-rc5. I just compiled and booted a 4.4-rc5 kernel image with a new dtb - or be more precise, I failed to boot it because the kernel couldn't mount the usb drives that I listed in my fstab. The defconfig I used was basically the same that I use for my 4.1.y kernels which is based on sunxi_defconfig but adds a lot more stuff like drivers, netfilter, etc (I merged the changes that happened in sunxi_defconfig between 4.1 and 4.4, though).
> 
> I haven't had the time yet to look into it further to bisect the issue. I also haven't tried any other kernel versions between 4.1.15 and 4.4-rc5, so I can't say when the problem slipped in. I just can say that there is an issue on my Lemaker Bananapi. The symptoms are the same as descrived by David. My usb drives don't seem the get power anymore once the kernel boots.
> 
> I'll try to find time to look into it in more detail over the weekend and provide configs and logs.
> 

so, I did some more testing. I took a second Lemaker Bananpi with two usb devices attached (a flash drive and a sd card reader) and compiled several kernel images along with their device tree blobs to figure out which version introduced the issue.

I tested linux 4.2, 4.3, 4.4-rc1 and 4.4-rc5. The U-Boot version used was 2015.10. I took the same defconfig for all builds. 

The break seems to have occured between 4.3 and 4.4-rc1, meaning that both 4.2 and 4.3 work fine, but with 4.4-rc1 and 4.4-rc5 the USB devices get turned off during boot.

The defconfig, full configs and the corresponding dmesg output for 4.3 (USB working) and 4.4-rc1 (USB *not* working) can be found here:
http://pastebin.com/HYwCGwcx (config 4.3)
http://pastebin.com/hbW7iLEh (dmesg 4.3)
http://pastebin.com/tKMSXMCW (config 4.4-rc1)
http://pastebin.com/g5NXw42t (dmesg 4.4-rc1)
http://pastebin.com/kW8MjcTq (defconfig, used for all builds)

What caught my eye here are these lines in the 4.4-rc1 dmesg output:
[    0.539619] usb0-vbus: disabling
[    0.539641] usb1-vbus: disabling
[    0.539664] usb2-vbus: disabling

When I submitted the patch to enable the regulators on Bananapi and tested the patch on some linux-next build at that time, I didn't see those in my kernel log. So maybe there was another change leading to that?

As David described as well, the LEDs on my flash drive and my card reader get turned on during the U-Boot phase. When the kernel is loading, they stay on (or keep blinking) with linux 4.3 and earlier. In 4.4-rc1 and later they both turn off, once the kernel is loading. 

Interesting enough, though, the power does not seem to be lost completly. Because if I unplug the card reader once linux 4.4-rc1 has fully booted, and plug it back in, the LED turns on again but the device does not show up in /dev/ and is not mountable. The flash drive stays dark even with this unplugging/plugging cycle.


Regards,

Timo
