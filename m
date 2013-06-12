From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Wed, 12 Jun 2013 06:00:12 +0000
Subject: [PATCH 13/14] ARM: AM33XX: hwmod data: irq, dma and addr info
 clean up
In-Reply-To: <51B6A43C.10301@ti.com>
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com>
 <1369845494-30231-14-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.02.1306060355320.15042@utopia.booyaka.com>
 <87zjv2ooxi.fsf@linaro.org> <51B58FE9.5040309@ti.com>
 <877gi1ew3r.fsf@linaro.org> <51B6A43C.10301@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83ECAF76E@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Vutla, Lokesh
> Sent: Tuesday, June 11, 2013 9:45 AM
> To: Kevin Hilman
> Cc: Paul Walmsley; Shilimkar, Santosh; tony at atomide.com; linux-arm-
> kernel at lists.infradead.org; linux-omap at vger.kernel.org; Hiremath,
> Vaibhav; R, Sricharan; Nayak, Rajendra
> Subject: Re: [PATCH 13/14] ARM: AM33XX: hwmod data: irq, dma and addr
> info clean up
> 
> Hi Kevin,
> On Monday 10 June 2013 10:33 PM, Kevin Hilman wrote:
> > Hi Lokesh,
> >
> > Lokesh Vutla <lokeshvutla@ti.com> writes:
> >
> >> Hi Kevin,
> >>
> >> On Friday 07 June 2013 03:57 AM, Kevin Hilman wrote:
> >>> Paul Walmsley <paul@pwsan.com> writes:
> >>>
> >>>> On Wed, 29 May 2013, Santosh Shilimkar wrote:
> >>>>
> >>>>> From: Vaibhav Hiremath <hvaibhav@ti.com>
> >>>>>
> >>>>> AM33XX only supports DT boot mode and with addition of
> >>>>> extracting module resources like, irq, dma and address space
> >>>>> from DT block, so now we can remove duplicate information from
> >>>>> hwmod data file.
> >>>>
> >>>> OK, guess I'll take your word for it that it all works.  The
> >>>> BeagleBone-white with appended DTB hasn't booted here since v3.7.
> >>>> And the BeagleBone-black with discrete DTB doesn't boot at all
> with
> >>>> current mainline, only with the TI vendor kernel & DTB...
> >>>
> >>> Anyone care to shed light on what's missing for BeagleBone boot
> with
> >>> mainline currently?
> >> I have tested BeagleBone boot with today's mainline bootloader and
> >> kernel. It boots perfectly fine.
> >
> > Can you post git trees + branch names (and/or commit IDs) and also
> > kernel config please?
> Following are the details:
> U-Boot:
> url: 			git://git.denx.de/u-boot.git
> branch :  	master
> config:		am335x_evm
> Top commit: 	"842033e pci: introduce CONFIG_PCI_INDIRECT_BRIDGE
> option"
> 
> Kernel:
> url:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-
> 2.6.git
> branch:		master
> config:		omap2plus_defocnfig
> dtb file:		am335x-bone.dtb
> Top commit:	"317ddd2 Linux 3.10-rc5" (On top of this I have a local
> patch for appending dtb)
> You can find the logs here: http://pastebin.com/vcBr0UhM
> 

Paul/Kevin/Santosh,

AM335x is booting up from Mainline, starting from v3.7, that?s where HWMOD data got merged to
Mainline.

We have discussed on this in the past as well, let me explain the issue here in detail
again for everybody -

In case of Am335x we have only two possible options, as AM335x only boots up
With DTB (Tested in BBB) -

1. Mainline u-boot + mainline Kernel:
=====================================

1.a. Appended DTB method
------------------------

Here you __must__ enabled below config options in order to get kernel booting,

CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y
CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y

And, I have used below command to append DTB to kernel image

# cat arch/arm/boot/zImage arch/arm/boot/dts/am335x-bone.dtb > zImage-append && mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 -n "Linux" -d zImage-append uImage-append


I have attached complete log here with this mail for reference
http://pastebin.com/82duFh78


1.b. Discrete DTB and uImage method:
------------------------------------

Here you don?t need to enable any extra config options. Plain omap2plus_defconfig
Should work without any issues.

I have attached complete log here with this mail for reference
http://pastebin.com/Nqr0PiwW


2. Older U-Boot (without DTB) + Mainline Kernel:
================================================

This is same as #OPTION-1.a above.


Thanks,
Vaibhav
