From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Wed, 3 Feb 2016 18:50:11 +0200
Subject: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
In-Reply-To: <56B1A654.1060905@gmail.com>
References: <568D5F54.7040900@gmail.com> <20160107180700.GN12777@atomide.com>
 <568EDC8D.7070205@gmail.com> <20160108022619.GS12777@atomide.com>
 <568F4596.8020206@gmail.com> <20160108075913.GN11364@pali>
 <569052FE.1040008@gmail.com> <20160121091437.GT7192@pali>
 <56B077D4.3030902@gmail.com> <20160202233911.GB19432@atomide.com>
 <20160203000045.GE19432@atomide.com> <56B1A654.1060905@gmail.com>
Message-ID: <56B22FC3.3050900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On  3.02.2016 09:03, Ivaylo Dimitrov wrote:
>
>
> I will play a bit more with omap2plus_defconfig here in attempt to make
> it boot, to see if I can recreate the issue.
>

ok, what I did here is:

- zImage

git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
git checkout omap-for-v4.5/fixes-rc1
make omap2plus_defconfig
make -j4 zImage
make omap3-n900.dtb
cat arch/arm/boot/zImage arch/arm/boot/dts/omap3-n900.dtb > zImage

- flashed maemo rootfs

sudo flasher-3.5 -f -F RX-51_2009SE_20.2010.36-2_PR_COMBINED_MR0_ARM.bin 
--flash-only=rootfs -R

- booted to maemo and powered the device off

sudo flasher-3.5 -k zImage  -l -b"init=/sbin/preinit ubi.mtd=rootfs 
root=ubi0:rootfs rootfstype=ubifs rootflags=bulk_read,no_chk_data_crc rw 
mtdoops.mtddev=log  omapfb_vram=7M omapfb.mode=lcd:848x480-16 
nokia-modem.pm=0"

There was nothing on the screen, but backlight was on. I removed the 
battery after ~30 seconds.

At this point maemo is no longer bootable. Booting fb-console enabled 
stock kernel 
(http://mohammadag.xceleo.org/public/maemo/kernels/framebuffer/) via 
flasher3.5:

sudo flasher-3.5 -k zImage-fb-omap1-pr13 -l -b

produces http://46.249.74.23/maemo/onenend/stock/ .

Booting 4.5-rc1 kernel from https://github.com/pali/linux-n900, with 
HWMOD_INIT_NO_RESET restored and your "onenand fix" patch reverted (so 
to not introduce additional corruption), via flasher3.5:

sudo flasher-3.5 -k zImage  -l -b"init=/sbin/preinit ubi.mtd=rootfs 
root=ubi0:rootfs rootfstype=ubifs rootflags=bulk_read,no_chk_data_crc rw 
mtdoops.mtddev=log  omapfb_vram=7M omapfb.mode=lcd:848x480-16 
nokia-modem.pm=0"

results in http://46.249.74.23/maemo/onenend/linux-n900/ .

note - don't try to play the videos in the browser, download them first 
instead, at least FF doesn't want to play videos captured by N900 :)

Regards,
Ivo
