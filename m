From: oliver+list@schinagl.nl (Olliver Schinagl)
Date: Tue, 11 Aug 2015 14:16:52 +0200
Subject: ARM: sunxi: Experiences NAND flash
Message-ID: <55C9E7B4.9090906@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everybody,

We are working with Boris and Roy's patch series on getting the NAND 
flash chip working on Olimex OLinuXino Lime2 boards. Initially, 
everything looks fine, but we noticed that occasionally (after 
power/cycle or power cut) ubi fails to mount the partition. It is not 
something easily enough to reproduce, but it has failed on 5 boards out 
of 30 we have.

U-boot reports the following:
UBI: default fastmap pool size: 100
UBI: default fastmap WL pool size: 25
UBI: attaching mtd1 to ubi0
UBI: scanning is finished
UBI init error 22
Error reading superblock on volume 'ubi:boot' errno=-19!
ubifsmount - mount UBIFS volume

whereas the linux kernel booted from sd card gives:
ubiattach /dev/ubi_ctrl -m 0
[  100.560704] ubi0: default fastmap pool size: 8
[  100.565186] ubi0: default fastmap WL pool size: 4
[  100.570100] ubi0: attaching mtd0
[  100.590469] ubi0: scanning is finished
[  100.594732] ubi0 error: ubi_read_volume_table: the layout volume was 
not found
[  100.602675] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd0, 
error -22
ubiattach: error!: cannot attach mtd0
            error 22 (Invalid argument)

The u-boot version we are using is a few months out of date
U-Boot 2015.07-rc2-g2540c39 (Aug 04 2015 - 16:09:02 +0200) Allwinner 
Technology
arm-none-eabi-gcc (4.8.4-1+11-1) 4.8.4 20141219 (release)
GNU ld (2.25-5+5+b1) 2.25

but the kernel is fairly up to date:
4.2.0-rc4-opinicus-g8ec3671


Now I know that the mtd stuff is all very new and all very untested, 
what I am curious about is a) have other people actually tried the mtd 
stuff on Allwinner hardware, and b) has anybody encountered this issue 
as well?

It's not something very easily reproducible (toggling a machine on/off 
repeatedly did not trigger it yet) but it does happen.

Olliver
