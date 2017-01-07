From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Sat, 7 Jan 2017 22:43:39 +0530
Subject: [PATCH RFC 2/2] ARM: nommu: remap exception base address to RAM
In-Reply-To: <20161213100226.GW14217@n2100.armlinux.org.uk>
References: <20161211131028.3019-1-afzal.mohd.ma@gmail.com>
 <20161211131255.3221-1-afzal.mohd.ma@gmail.com>
 <20161213100226.GW14217@n2100.armlinux.org.uk>
Message-ID: <20170107171339.GA5044@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 13, 2016 at 10:02:26AM +0000, Russell King - ARM Linux wrote:

> Is there really any need to do this in head.S ?  I believe it's
> entirely possible to do it later - arch/arm/mm/nommu.c:paging_init().

As memblock_reserve() for exception address was done before
paging_init(), seems it has to be done by arm_mm_memblock_reserve() in
arch/arm/mm/nommu.c, WIP patch follows, but not that happy -
conditional compilation's make it not so readable, still better to
see in C.

> Also, if the region setup for the vectors was moved as well, it would
> then be possible to check the ID registers to determine whether this
> is supported, and make the decision where to locate the vectors base
> more dynamically.

This would affect Cortex-R's, which is a bit concerning due to lack of
those platforms with me, let me try to get it right. Seems
translating __setup_mpu() altogether to C & installing at a later, but
suitable place might be better.

And feeling something strange about Cortex-R support in mainline,
don't know whether it boots out of the box, there are no Cortex-R cpu
compatibles in dts(i), but devicetree documentation documents it.
Still wrecking Cortex-R's could get counted as a regression as dts is
not considered Kernel. Looks like there is a Cortex-R mafia around
mainline ;)

> That leaves one pr_notice() call using the CONFIG_VECTORS_BASE
> constant...

Seems you want to completely kick out CONFIG_VECTORS_BASE.

Saw 2 interesting MMU cases,
1. in devicemaps_init(), if Hivecs is not set, it is being mapped to
virtual address zero, was wondering how MMU Kernel can handle
exceptions with zero address base (& still prints 0xffff0000 as vector
base)
2. One of the platform does a ioremap of CONFIG_VECTORS_BASE

Once i take care of the above, the ugly conditional compilation in
3/4th patch (@arch/arm/mm/init.c) of WIP patch series that follows
will be removed.

Please let know if you have any comments on the above.


Also !MMU Kernel could boot on 3 ARM v7-A platforms - AM335x Beagle
Bone (A8), AM437x IDK (A9) & Vybrid VF610 (on A5 core, note that it
has M4 core too) with same Kernel image*.

Vybrid did not need any platform specific tweaks, just 1/2th patch
(put in patch system as 8635/1) & WIP series over Vladimir's one,
while TI Sitara AMx3's needed one w.r.t remap.

Please bear my delay - to fill the stomach, work not on Linux and then
the vacations.

Regards
afzal

* Since initramfs was used, tty port had to be changed in initramfs
build for Vybrid, but Kernel except for above initramfs change, was
identical.
