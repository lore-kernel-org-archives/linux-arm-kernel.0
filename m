From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 17 Aug 2015 09:34:11 +0200
Subject: ARM: sunxi: Experiences NAND flash
In-Reply-To: <55C9E7B4.9090906@schinagl.nl>
References: <55C9E7B4.9090906@schinagl.nl>
Message-ID: <20150817093411.4ff853c4@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oliver,

Sorry for the late reply (I was in vacation for the last 2 weeks)

On Tue, 11 Aug 2015 14:16:52 +0200
Olliver Schinagl <oliver+list@schinagl.nl> wrote:

> Hello everybody,
> 
> We are working with Boris and Roy's patch series on getting the NAND 
> flash chip working on Olimex OLinuXino Lime2 boards. Initially, 
> everything looks fine, but we noticed that occasionally (after 
> power/cycle or power cut) ubi fails to mount the partition. It is not 
> something easily enough to reproduce, but it has failed on 5 boards out 
> of 30 we have.

I remember warning you about that problem before: MLC NANDs are not as
reliable as SLC ones (please read my presentation about MLC support in
Linux [1]). I also remember recommending using an SLC chip if you were
tight on time to avoid dealing with all these MLC related problems, but
you decided to go for the MLC solution.

Back to your problem now, what you're seeing here is probably caused by
interrupted PROGRAM operations on paired pages (page 17, 18 and 26 to 32
of my presentation for more information).

> 
> U-boot reports the following:
> UBI: default fastmap pool size: 100
> UBI: default fastmap WL pool size: 25
> UBI: attaching mtd1 to ubi0
> UBI: scanning is finished
> UBI init error 22
> Error reading superblock on volume 'ubi:boot' errno=-19!
> ubifsmount - mount UBIFS volume
> 
> whereas the linux kernel booted from sd card gives:
> ubiattach /dev/ubi_ctrl -m 0
> [  100.560704] ubi0: default fastmap pool size: 8
> [  100.565186] ubi0: default fastmap WL pool size: 4
> [  100.570100] ubi0: attaching mtd0
> [  100.590469] ubi0: scanning is finished
> [  100.594732] ubi0 error: ubi_read_volume_table: the layout volume was 
> not found
> [  100.602675] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd0, 
> error -22
> ubiattach: error!: cannot attach mtd0
>             error 22 (Invalid argument)
> 
> The u-boot version we are using is a few months out of date
> U-Boot 2015.07-rc2-g2540c39 (Aug 04 2015 - 16:09:02 +0200) Allwinner 
> Technology
> arm-none-eabi-gcc (4.8.4-1+11-1) 4.8.4 20141219 (release)
> GNU ld (2.25-5+5+b1) 2.25
> 
> but the kernel is fairly up to date:
> 4.2.0-rc4-opinicus-g8ec3671
> 
> 
> Now I know that the mtd stuff is all very new and all very untested, 
> what I am curious about is a) have other people actually tried the mtd 
> stuff on Allwinner hardware, and b) has anybody encountered this issue 
> as well?

Yes we did. So far we're using the NAND in SLC mode to address this
problem. It seems to work, but you also loose half the NAND capacity.

> 
> It's not something very easily reproducible (toggling a machine on/off 
> repeatedly did not trigger it yet) but it does happen.

I managed to reproduce it by faking a power cut directly in the NAND
core code (by sending a RESET command to the NAND chip in the middle of
a program operation), and I can confirm SLC mode address the problem.

Anyway, remember that MLC NANDs have other sources of unreliability
(e.g the unstable bits problem).

Best Regards,

Boris


[1]http://events.linuxfoundation.org/sites/events/files/slides/brezillon-mlc-nand_0.pdf

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
