From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 10 Dec 2012 09:02:02 -0500
Subject: Your kernel patches for the Marvell Mirabox
In-Reply-To: <50C4AC68.7090709@gmail.com>
References: <50C4AC68.7090709@gmail.com>
Message-ID: <20121210140202.GI21694@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 09, 2012 at 04:21:12PM +0100, Bernd wrote:
> Hello Jason,

Hi Bernd!

> If you don't take questions about your patches by direct email, could
> you point me to a mailing list which is more appropriate for asking such
> a question?

I prefer including, at a minimum, the Linux ARM Kernel mailinglist in
the discussion.  I've included it in the CC: now.  Adding my address to
the To: or CC: helps it stand out from the crowd, so no problem there.

> If you do take questions about it, here is what I did:
> 
> I got the kernel source from
> 
> git://github.com/MISL-EBU-System-SW/mainline-public.git
> 
> commit 0c0029cb1806601430692d48c130a17302a18225, where Olof Johannson
> merged your changes for initial Mirabox support on top of Linus
> Torvalds' 3.7-rc7.
> 
> I built the kernel using the cross toolchain for ARM EABI from
> https://sourcery.mentor.com/GNUToolchain/release2322?lite=arm and
> uboot-mkimage from
> http://rapidlibrary.com/files/uboot-mkimage-0-4-tar-gz_ulzywyzvfni89on.html:

Most linux distro's I've seen include a 'uboot-tools' or 'uboot-utils'
that you can install via the package manager.  No need to pull it from
unknown places.

> $ make ARCH=arm mvebu_defconfig
> $ make -j4 ARCH=arm CROSS_COMPILE=../arm-2012.09/bin/arm-none-eabi- uImage

Here's the problem.  The stock u-boot installed by the manufacturer
doesn't support devicetree.  It uses the old method of handing the
kernel a mach_type number to tell the kernel which board init it should
call.  'boardid' in the u-boot environment.

The new method is to hand the kernel an address where the dtb (device
tree blob) was loaded into RAM.

You have two choices, upgrade u-boot (sizeable task), or use a developer
configuration option included in the kernel, CONFIG_ARM_APPENDED_DTB.
Once set, you need to make a zImage, append
arch/arm/boot/armada-<board>.dtb to the zImage, then turn the zImage
into a uImage.

In u-boot you'll need to change the boardid environment variable to
0xffffffff, which needs to be in unsigned integer notation, 4294967295.

In general, you'll want to enable CONFIG_EARLY_PRINTK, and make sure
earlyprintk is in your kernel command line options.

hth,

Jason.
