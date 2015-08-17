From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 17 Aug 2015 11:03:22 +0200
Subject: ARM: sunxi: Experiences NAND flash
In-Reply-To: <55D19BAE.5000204@nimrod-online.com>
References: <55C9E7B4.9090906@schinagl.nl> <20150817093411.4ff853c4@bbrezillon>
 <55D19BAE.5000204@nimrod-online.com>
Message-ID: <20150817110322.1fa7d24c@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roy,

On Mon, 17 Aug 2015 09:30:38 +0100
Roy Spliet <seven@nimrod-online.com> wrote:

> Hello,
> 
> Reply in-line
> 
> Op 17-08-15 om 08:34 schreef Boris Brezillon:
> > Hi Oliver,
> >
> > Sorry for the late reply (I was in vacation for the last 2 weeks)
> >
> > On Tue, 11 Aug 2015 14:16:52 +0200
> > Olliver Schinagl <oliver+list@schinagl.nl> wrote:
> >
> >> Hello everybody,
> >>
> >> We are working with Boris and Roy's patch series on getting the NAND
> >> flash chip working on Olimex OLinuXino Lime2 boards. Initially,
> >> everything looks fine, but we noticed that occasionally (after
> >> power/cycle or power cut) ubi fails to mount the partition. It is not
> >> something easily enough to reproduce, but it has failed on 5 boards out
> >> of 30 we have.
> > I remember warning you about that problem before: MLC NANDs are not as
> > reliable as SLC ones (please read my presentation about MLC support in
> > Linux [1]). I also remember recommending using an SLC chip if you were
> > tight on time to avoid dealing with all these MLC related problems, but
> > you decided to go for the MLC solution.
> >
> > Back to your problem now, what you're seeing here is probably caused by
> > interrupted PROGRAM operations on paired pages (page 17, 18 and 26 to 32
> > of my presentation for more information).
> In his defence; we looked at it, and from what we could tell it is not 
> possible to find an affordable SLC chip that the Allwinner A10/A20 
> BootROM would even boot from. In general, chips below 8K page size 
> require 64-bit EEC strength to operate, which in turn required more OOB 
> area than any chip would provide. This limitation is in my opinion a 
> design fault from AllWinners side and I hope that their future SoCs can 
> boot with more relaxed EEC settings to facilitate for cheap SLC chips, 
> but right now there is nothing we can do to change that situation.

Hm, according to this table [1], it also tries the 64bit/512bytes
scheme, which should fit in most SLC NANDs (if you have a NAND with 2k
+ 64byte pages, and you only use 512 bytes per page it leaves 1600 bytes
for your ECC data).
This being said, supporting this kind of layout in Linux can be
complicated: I remember we (Roy and I) tried to patch the nand part code
to tweak the data/oob repartition for this case, but we didn't manage
to get it to work.

> >> U-boot reports the following:
> >> UBI: default fastmap pool size: 100
> >> UBI: default fastmap WL pool size: 25
> >> UBI: attaching mtd1 to ubi0
> >> UBI: scanning is finished
> >> UBI init error 22
> >> Error reading superblock on volume 'ubi:boot' errno=-19!
> >> ubifsmount - mount UBIFS volume
> >>
> >> whereas the linux kernel booted from sd card gives:
> >> ubiattach /dev/ubi_ctrl -m 0
> >> [  100.560704] ubi0: default fastmap pool size: 8
> >> [  100.565186] ubi0: default fastmap WL pool size: 4
> >> [  100.570100] ubi0: attaching mtd0
> >> [  100.590469] ubi0: scanning is finished
> >> [  100.594732] ubi0 error: ubi_read_volume_table: the layout volume was
> >> not found
> >> [  100.602675] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd0,
> >> error -22
> >> ubiattach: error!: cannot attach mtd0
> >>              error 22 (Invalid argument)
> >>
> >> The u-boot version we are using is a few months out of date
> >> U-Boot 2015.07-rc2-g2540c39 (Aug 04 2015 - 16:09:02 +0200) Allwinner
> >> Technology
> >> arm-none-eabi-gcc (4.8.4-1+11-1) 4.8.4 20141219 (release)
> >> GNU ld (2.25-5+5+b1) 2.25
> >>
> >> but the kernel is fairly up to date:
> >> 4.2.0-rc4-opinicus-g8ec3671
> >>
> >>
> >> Now I know that the mtd stuff is all very new and all very untested,
> >> what I am curious about is a) have other people actually tried the mtd
> >> stuff on Allwinner hardware, and b) has anybody encountered this issue
> >> as well?
> > Yes we did. So far we're using the NAND in SLC mode to address this
> > problem. It seems to work, but you also loose half the NAND capacity.
> So as requested by someone else: how exactly does that work? Can we just 
> give your NAND driver a mapping between shared pages and instruct it to 
> ignore half, or does the driver require some serious patchery?

I only have a prototype for this SLC mode, and the code is available
here [2].
In short, the NAND core layer checks for SLC mode activation, and if it
is activated it only exposes half the erase block capacity.
This also requires some chip specific code to enable/disable the SLC
mode and adjust the row/column addresses before passing them to the
controller driver.
Note that SLC mode can be enabled by partitions, which let us declare
the SPL partition in MLC mode so that BROM can still load the SPL.

Best Regards,

Boris

[1]http://linux-sunxi.org/NAND#More_information_on_BROM_NAND
[2]https://github.com/NextThingCo/CHIP-linux/tree/nextthing/4.2/chip-nand-slc-mode

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
