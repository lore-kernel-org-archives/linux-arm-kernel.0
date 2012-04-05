From: gfm@funxed.com (George McBay)
Date: Thu, 5 Apr 2012 10:30:43 -0700
Subject: question about i.mx21ads support
Message-ID: <CAEqTKjUyiA_fCfboifSXXj-h_B6rGQpAM9nGnen=0mKi-w=J9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm attempting to revive an old i.mx21ads board (Freescale dev board,
M9328MX21ADS Rev E) with a newish Linux kernel but haven't had yet had
luck getting a build after version 3.1.10 to boot successfully.  Given
the age of this platform, it seems entirely plausible that nobody is
actually runtime testing against this board, though I suppose it may
also come down to something specific in my board revision.

My basic question is, is anyone able to successfully boot a kernel
version higher than 3.1.10 on a Freescale imx21ads board?   While I
know this isn't a general support list, it seems like one of the most
likely places to find someone who might be doing this.

In my experience thus far versions up to 3.2.14 boot somewhat but
throw an Oops on drivers/mtd/maps/physmap.c:141.  In the loop where
that occurs my board is reporting one device named physmap-flash.0 and
on the newer builds the info->map[0] structure looks like this:

info->map[0].name: physmap-flash.0
info->map[0].phys: 0xc8000000
info->map[0].size: 0x2000000
info->map[0].bankwidth: 0x4
info->map[0].set_vpp: 0xc0171070
info->map[0].pfow_base: 0x0
info->map[0].map_priv_1: 0xc032a618
info->map[0].virt: 0xc5000000

On older kernels which work that struct looks similar, but the set_vpp
member points to NULL (I haven't done much linux kernel hacking, so I
still have some poking around to do to figure out what this even
points to):

info->map[0].set_vpp: 0x0

As of 3.3-rc1 or so, after the merge-down to imx_v4_v5_defconfig as
opposed to the old mx21_defconfig the kernel
hangs prior to displaying anything to serial.

In my tests across the various kernel versions I've been disabling
NAND support in the kernel build and flashing to NOR on this board.

I intent to continue to digging into the code the determine what the
issues are, but I think it may be helpful to know if anyone is
successfully booting these newer kernels on this platform to help
narrow the issue down to a specific revision or config set.

I may end up just using the older version, but in that case I'm going
to have to backport some of the device support that was put into the
newer kernels (for CS89x0 ethernet, SDHC, etc)

Thanks in advance for any pointers and thanks for all the work put
into the arm SoC kernels.
