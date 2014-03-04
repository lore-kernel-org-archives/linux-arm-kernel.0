From: tonyho.profession@gmail.com (TonyHo)
Date: Tue, 04 Mar 2014 19:04:08 +0800
Subject: [linux-pm] ARM hibernation / suspend-to-disk
In-Reply-To: <531560aa.e7d5440a.0e5f.5f57@mx.google.com>
References: <20130529081005.GA25561@hal> <51A6399D.4090606@ti.com>
 <20140128141458.GD8713@xo-6d-61-c0.localdomain>
 <20140128182245.18840.51279@capellas-linux>
 <loom.20140216T140206-196@post.gmane.org>
 <20140224215443.9748.65580@capellas-linux> <5312E46B.8020900@gmail.com>
 <531560aa.e7d5440a.0e5f.5f57@mx.google.com>
Message-ID: <5315B328.9030306@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian:
     Thank you. And I'm in Shanghai, it's not far from the Macao, both 
in China, ha.
The system can boot up normal now. And I want to make the hibernation, 
but error occurs. I want to save the hibernation image in 
/dev/mmcblk0p3(device id 179:3), and I configure this in menuconfig:
/ # cat /sys/power/resume 179:3
When I echo a disk to /sys/power/state , it hints(partly log):
[ 49.426656] omap_uart 44e09000.serial: no wakeirq for uart0
[ 49.594385] PM: thaw of devices complete after 171.291 msecs
[ 49.661876] PM: Cannot find swap device, try swapon -a.
[ 49.667356] PM: Cannot get swap writer
[ 49.722677] Restarting tasks ... done. ash: write error: No such device

But I can find my device /dev/mmcblk0p3, and its size is about 2GB, and 
it's not mounted in system,it can be mounted with ext4 filesystem.
/ # ls -l /dev/mmcblk*
brw-rw---- 1 0 0 179, 3 Jan 1 00:01 /dev/mmcblk0p3

It says cannot find swap device, but the CONFIG_SWAP=y is checked.
It seems I miss something?
On 03/04/2014 01:12 PM, Sebastian Capella wrote:
> Quoting tonyho (2014-03-01 23:57:31)
>> Now I have try to booting you hibernation_3.13_russMerge branch kernel
>> from uboot(Version 2013-10) in BBB, and I don't know how to build the dtb.
>> I have built the uImage using:
>> 1. make ARCH=arm CROSS_COMPILE=/media/work/BBB/tools/arm-2010.09/bin/arm-
>> none-linux-gnueabi- omap2plus_defconfig && make ARCH=arm
>> CROSS_COMPILE=/media/work/BBB/tools/arm-2010.09/bin/arm-none-linux-gnueabi-
>> uImage LOADADDR=0x80008000
> Hi Tony, you'll want to do:
> make ARCH=arm CROSS_COMPILE=/media/work/BBB/tools/arm-2010.09/bin/arm- dtbs
>
> This will generate dtb files in arch/arm/boot/dts/
>
>  From there, you must take the correct dtb file and include it in your
> u-boot.
>
> You'll have to point the bootup to the dtb image you load.
>
>> 2. And I load the uImage using the ext4load from TF card?
>> (1)ext4load mmc 0:2 80007f00 /boot/uImage
>> (2)and 'iminfo 0x80007f00' hints image is OK.
>> (3)The Kernel Command Line is 'init=/linuxrc console=ttyO0,115200n8
>> run_hardware_tests root=/dev/mmcblk0p2 ro rootfstype=ext4 rootwait' and
>> I select the 'Always use the default kernel command line'
>> and the configuration has been verified in other version linux kernel
>> source code.
>> (4)But when I 'bootm 80007f00', it just print the 'Starting kernel ...'
> This is what you expect when it can't find the dtb image, as the dtb is
> required to boot.
>
>> and nothing more. And the USERLED0-3 in BBB are off.
>> 3. I guess this is caused by I haven't load a dts to memory
>> (1)Can you tell me how to build the dtb? Like 'make XXX.dtb/dts'?
>> (2)And which dtb should be loaded into memory? What the address should
>> be load for the dtb files?
> If you're using beaglebone black, use am335x-boneblack.dtb
>
> The load address is tricky a bit, the answer is it depends on where you
> have room.
>
> I'm probably not much help here.
>
>> 4. I use the busybox to be the rootfs, and it test OK. I prepare add a
>> resume command to /sys/power/resume in inittab. Should this work?
> For now, probably just get everything booting.  If you can, use an
> initrd or initramfs and boot it there.  Once you mount rootfs really on
> the SD card, it's too late as you'll corrupt your filesystem.
>
> Sorry about my delayed responses.  I'm in Macao at the Linaro Connect,
> but will check emails from time to time.
>
> Thanks,
>
> Sebastian
