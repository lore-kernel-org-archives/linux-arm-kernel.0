From: rbernd@gmail.com (Bernd)
Date: Tue, 11 Dec 2012 01:43:28 +0100
Subject: Your kernel patches for the Marvell Mirabox
In-Reply-To: <20121210140202.GI21694@titan.lakedaemon.net>
References: <50C4AC68.7090709@gmail.com>
 <20121210140202.GI21694@titan.lakedaemon.net>
Message-ID: <50C681B0.4030801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

Thanks for your explanations on the dtb. I tried it but it didn't work
for me:

1. Turns out that mvebu_defconfig has the right settings already:

CONFIG_ARM_APPENDED_DTB=y

and, for enabling early debug messages:

CONFIG_DEBUG_LL=y
CONFIG_DEBUG_MVEBU_UART=y
CONFIG_DEBUG_LL_INCLUDE="debug/mvebu.S"
CONFIG_EARLY_PRINTK=y

2. So this is what I am using to build the kernel:

$ make ARCH=arm mvebu_defconfig
$ make -j4 ARCH=arm CROSS_COMPILE=../arm-2012.09/bin/arm-none-eabi- zImage
$ make ARCH=arm CROSS_COMPILE=../arm-2012.09/bin/arm-none-eabi-
armada-370-mirabox.dtb
$ cat arch/arm/boot/armada-370-mirabox.dtb >> arch/arm/boot/zImage
$ make ARCH=arm CROSS_COMPILE=../arm-2012.09/bin/arm-none-eabi- uImage

That builds a legacy uImage which, the way I understand your
explanations, hides the dtb from my old u-boot but the kernel will find
it anyway:

$ mkimage -l arch/arm/boot/uImage
Image Name:   Linux-3.7.0-rc7-00250-g0c0029c
Created:      Tue Dec 11 01:13:13 2012
Image Type:   ARM Linux Kernel Image (uncompressed)
Data Size:    1885555 Bytes = 1841.36 kB = 1.80 MB
Load Address: fffffff2
Entry Point:  fffffff2

3. My host distro doesn't have the uboot-tools in the package
repository, but I downloaded the most current uboot distribution
ftp://ftp.denx.de/pub/u-boot/u-boot-2012.10.tar.bz2 and now use the
mkimage tool produced by 'make tools', just to be sure I am not using a
broken mkimage.

4. In u-boot, I've set bootargs to:

Marvell>> printenv bootargs
bootargs=console=ttyS0,115200 root=/dev/sdb2 rootdelay=2 rootfstype=ext4
earlyprintk=serial,uart0,115200

so earlyprintk is set on the kernel command line.

5. When booting the kernel via tftp, I get:
--------------------------------------------
Marvell>> tftpboot 0x6400000 uImage3.7.0-rc7mirabox ; bootm 0x6400000
phyaddr= 0
Using egiga0 device
TFTP from server 192.168.1.10; our IP address is 192.168.1.138
Filename 'uImage3.7.0-rc7mirabox'.
Load address: 0x6400000
Loading: #################################################################
################################################################
done
Bytes transferred = 1885619 (1cc5b3 hex)
## Booting kernel from Legacy Image at 06400000 ...
   Image Name:   Linux-3.7.0-rc7-00250-g0c0029c
   Created:      2012-12-11   0:13:13 UTC
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1885555 Bytes =  1.8 MB
   Load Address: fffffff2
   Entry Point:  fffffff2
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

--------------------------------------------

No debug messages and the box hangs.

When that failed, I tried to set in addition the configuration parameters

CONFIG_ARM_ATAG_DTB_COMPAT=y
CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y

and rebuilt the kernel, but got the same result.

Any idea?

Cheers,

Bernd


On 2012-12-10 15:02, Jason Cooper wrote:
> On Sun, Dec 09, 2012 at 04:21:12PM +0100, Bernd wrote:
>> Hello Jason,
> 
> Hi Bernd!
> 
>> If you don't take questions about your patches by direct email, could
>> you point me to a mailing list which is more appropriate for asking such
>> a question?
> 
> I prefer including, at a minimum, the Linux ARM Kernel mailinglist in
> the discussion.  I've included it in the CC: now.  Adding my address to
> the To: or CC: helps it stand out from the crowd, so no problem there.
> 
>> If you do take questions about it, here is what I did:
>>
>> I got the kernel source from
>>
>> git://github.com/MISL-EBU-System-SW/mainline-public.git
>>
>> commit 0c0029cb1806601430692d48c130a17302a18225, where Olof Johannson
>> merged your changes for initial Mirabox support on top of Linus
>> Torvalds' 3.7-rc7.
>>
>> I built the kernel using the cross toolchain for ARM EABI from
>> https://sourcery.mentor.com/GNUToolchain/release2322?lite=arm and
>> uboot-mkimage from
>> http://rapidlibrary.com/files/uboot-mkimage-0-4-tar-gz_ulzywyzvfni89on.html:
> 
> Most linux distro's I've seen include a 'uboot-tools' or 'uboot-utils'
> that you can install via the package manager.  No need to pull it from
> unknown places.
> 
>> $ make ARCH=arm mvebu_defconfig
>> $ make -j4 ARCH=arm CROSS_COMPILE=../arm-2012.09/bin/arm-none-eabi- uImage
> 
> Here's the problem.  The stock u-boot installed by the manufacturer
> doesn't support devicetree.  It uses the old method of handing the
> kernel a mach_type number to tell the kernel which board init it should
> call.  'boardid' in the u-boot environment.
> 
> The new method is to hand the kernel an address where the dtb (device
> tree blob) was loaded into RAM.
> 
> You have two choices, upgrade u-boot (sizeable task), or use a developer
> configuration option included in the kernel, CONFIG_ARM_APPENDED_DTB.
> Once set, you need to make a zImage, append
> arch/arm/boot/armada-<board>.dtb to the zImage, then turn the zImage
> into a uImage.
> 
> In u-boot you'll need to change the boardid environment variable to
> 0xffffffff, which needs to be in unsigned integer notation, 4294967295.
> 
> In general, you'll want to enable CONFIG_EARLY_PRINTK, and make sure
> earlyprintk is in your kernel command line options.
> 
> hth,
> 
> Jason.
