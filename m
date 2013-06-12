From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 12 Jun 2013 15:39:05 -0700
Subject: [PATCH 13/14] ARM: AM33XX: hwmod data: irq,
 dma and addr info clean up
In-Reply-To: <79CD15C6BA57404B839C016229A409A83ECAF76E@DBDE04.ent.ti.com>
 (Vaibhav Hiremath's message of "Wed, 12 Jun 2013 06:00:12 +0000")
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com>
 <1369845494-30231-14-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.02.1306060355320.15042@utopia.booyaka.com>
 <87zjv2ooxi.fsf@linaro.org> <51B58FE9.5040309@ti.com>
 <877gi1ew3r.fsf@linaro.org> <51B6A43C.10301@ti.com>
 <79CD15C6BA57404B839C016229A409A83ECAF76E@DBDE04.ent.ti.com>
Message-ID: <87mwqvar92.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vaibhav,

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

[...]

> Paul/Kevin/Santosh,
>
> AM335x is booting up from Mainline, starting from v3.7, that?s where HWMOD data got merged to
> Mainline.
>
> We have discussed on this in the past as well, let me explain the issue here in detail
> again for everybody -

Thanks for the detail.

In my case, after more debug, it appears that where I was putting the
DTB in memory from u-boot was not working.   Using the addresses you
used gets things working again.  Thanks.

u-boot mainline (v2013.04) for BeagleBone has defaults that don't work
appear together:

U-Boot# printenv loadaddr
loadaddr=0x80200000
U-Boot# printenv fdtaddr
fdtaddr=0x80F80000

Changing fdtaddr around got things working again.  It's probably a good
idea to change the u-boot defaults to values that work, since that's a
likely starting point for people.

I'm now back to mainline booting well on both my original BeagleBone and
my BeagleBone black.

Thanks,

Kevin

> In case of Am335x we have only two possible options, as AM335x only boots up
> With DTB (Tested in BBB) -
>
> 1. Mainline u-boot + mainline Kernel:
> =====================================
>
> 1.a. Appended DTB method
> ------------------------
>
> Here you __must__ enabled below config options in order to get kernel booting,
>
> CONFIG_ARM_APPENDED_DTB=y
> CONFIG_ARM_ATAG_DTB_COMPAT=y
> CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
>
> And, I have used below command to append DTB to kernel image
>
> # cat arch/arm/boot/zImage arch/arm/boot/dts/am335x-bone.dtb >
> zImage-append && mkimage -A arm -O linux -T kernel -C none -a
> 0x80008000 -e 0x80008000 -n "Linux" -d zImage-append uImage-append
>
>
> I have attached complete log here with this mail for reference
> http://pastebin.com/82duFh78
>
>
> 1.b. Discrete DTB and uImage method:
> ------------------------------------
>
> Here you don?t need to enable any extra config options. Plain omap2plus_defconfig
> Should work without any issues.
>
> I have attached complete log here with this mail for reference
> http://pastebin.com/Nqr0PiwW
>
>
> 2. Older U-Boot (without DTB) + Mainline Kernel:
> ================================================
>
> This is same as #OPTION-1.a above.
>
>
> Thanks,
> Vaibhav
