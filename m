From: kuro2357509@gmail.com (Johann)
Date: Mon, 11 Jan 2016 16:43:23 +0000 (UTC)
Subject: [linux-pm] ARM hibernation / suspend-to-disk
References: <20130529081005.GA25561@hal> <51A6399D.4090606@ti.com>
 <20140128141458.GD8713@xo-6d-61-c0.localdomain>
 <20140128182245.18840.51279@capellas-linux>
 <loom.20140216T140206-196@post.gmane.org>
 <20140224215443.9748.65580@capellas-linux> <5312E46B.8020900@gmail.com>
 <531560aa.e7d5440a.0e5f.5f57@mx.google.com> <5315B328.9030306@gmail.com>
 <53166cef.43bd440a.2ff1.472e@mx.google.com>
Message-ID: <loom.20160111T162128-272@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian Capella <sebastian.capella <at> linaro.org> writes:

> 
> Quoting TonyHo (2014-03-04 03:04:08)
> > Hi Sebastian:
> >      Thank you. And I'm in Shanghai, it's not far from the Macao, 
both 
> > in China, ha.
> > The system can boot up normal now. And I want to make the 
hibernation, 
> > but error occurs. I want to save the hibernation image in 
> > /dev/mmcblk0p3(device id 179:3), and I configure this in menuconfig:
> > / # cat /sys/power/resume 179:3
> > When I echo a disk to /sys/power/state , it hints(partly log):
> > [ 49.426656] omap_uart 44e09000.serial: no wakeirq for uart0
> > [ 49.594385] PM: thaw of devices complete after 171.291 msecs
> > [ 49.661876] PM: Cannot find swap device, try swapon -a.
> > [ 49.667356] PM: Cannot get swap writer
> > [ 49.722677] Restarting tasks ... done. ash: write error: No such 
device
> > 
> > But I can find my device /dev/mmcblk0p3, and its size is about 2GB, 
and 
> > it's not mounted in system,it can be mounted with ext4 filesystem.
> > / # ls -l /dev/mmcblk*
> > brw-rw---- 1 0 0 179, 3 Jan 1 00:01 /dev/mmcblk0p3
> > 
> > It says cannot find swap device, but the CONFIG_SWAP=y is checked.
> > It seems I miss something?
> 
> Hi tony,
> 
> Two things are?missing:
> 
> 1) you must format the partition as swap using the mkswap command. 
?This can be
>    done on target or on your laptop. ?
> 
> 2) after booting, on target you have to add the swap to the system 
using the
>    swapon command. ?I usually do:
> 
>     swapon /dev/mmcblk0p3
> 
> If you want to do swapon -a you may have to modify the
> /etc/fstab or mnttab but I don't do it?this way. ?
> 
> Sebastian
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel <at> lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

Hi Sebastian ,tonyho ,Pavel ,Russ:

I want to build the kernel https://github.com/russdill/linux/commits/arm-
hibernation-am33xx-v3.12 to be used in BeagleBone black Rev C too, I 
watched all discussion between Sebastian and tonyho, but I still can't 
work fine.

Below is my question:
On 02/24/2014 22:54 , Sebastian Capella wrote:
> I use omap2plus_defconfig.  
> 
> I have been working with BeagleBone Black (bbb) for hibernation on 
this branch:
> 
> http://git.linaro.org/git-ro/people/sebastian.capella/linux.git 
hibernation_3.13_russMerge
> 
> I ran into a few minor issues on Russ' branch for bbb that I had to 
work
> around.  In the end it worked fine, but I know I had to add some 
entries
> in the dts files at least for it to work.

1. I can't find the branch: http://git.linaro.org/git-
ro/people/sebastian.capella/linux.git hibernation_3.13_russMerge

Does the repositories still working? Or where can I find it?

2. Because I can't use Sebastian's branch above, I still use Russ's 
branch(arm-hibernation-am33xx-v3.12),and I built zImage and am335x-
boneblack.dtb succesfully. When I boot beanglebone black using rootfs, 
it hints(partly log):
[    1.626927] tps65217 0-0024: TPS65217 ID 0xe version 1.2
[    1.632587] omap_i2c 44e0b000.i2c: bus 0 rev0.11 at 400 kHz
[    1.714583] davinci_mdio 4a101000.mdio: davinci mdio revision 1.6
[    1.721043] davinci_mdio 4a101000.mdio: detected phy mask fffffffe
[    1.730995] libphy: 4a101000.mdio: probed
[    1.735391] davinci_mdio 4a101000.mdio: phy[0]: device 
4a101000.mdio:00, driver SMSC LAN8710/LAN8720
[    1.745665] Random MACID = e6:ed:f5:55:73:33
[    1.756429] omap_rtc 44e3e000.rtc: setting system clock to 2000-01-01 
00:00:01 UTC (946684801)
[    1.770213] Waiting for root device /dev/mmcblk0p2...

I guess this problem is caused by device tree hasn't support mmc.

I want to ask how to add some entries in the dts files? or if there 
would be some modification to be done before compile russ's source code? 

Below is my operation:
1. Build russ's kernel branch:
$ git clone https://github.com/russdill/linux.git
$ git checkout arm-hibernation-am33xx-v3.12
$ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- omap2plus_defconfig
$ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- menuconfig
$ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- zImage dtbs -j4

2. Build russ's u-boot(https://github.com/russdill/u-
boot/tree/hibernation-v2013.10):
$make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- am335x_boneblack

Thank you very much!
