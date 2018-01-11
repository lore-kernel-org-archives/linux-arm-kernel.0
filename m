From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Thu, 11 Jan 2018 23:24:17 +0100
Subject: [PATCH v3 0/7] Marvell NAND controller rework with ->exec_op()
In-Reply-To: <87efmwb8bj.fsf@belgarion.home>
References: <20180109103637.23798-1-miquel.raynal@free-electrons.com>
 <20180111122751.4bd74366@bbrezillon>
 <87efmwb8bj.fsf@belgarion.home>
Message-ID: <20180111232417.4aa86075@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On Thu, 11 Jan 2018 18:42:56 +0100
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Boris Brezillon <boris.brezillon@free-electrons.com> writes:
> 
> Hi Boris and Miquel,
> 
> > So, here is the plan: since the driver has been tested on various
> > mvebu platforms and is known to work fine on these platforms, I'd
> > like to queue the driver and the patch modifying mvebu defconfigs
> > (patches 1 to 4) for 4.16.
> That's all right.
> 
> > I'll leave other patches for 4.17, which means I'd like remaining
> > bugs to be fixed during the 4.16 release cycle so that we can
> > eventually get rid of the old driver. That's really important to me
> > that we don't keep both drivers around for too long, because my
> > previous experience showed that, when you have 2 drivers for the
> > same HW, people don't switch to the new one until they're forced to
> > do it.
> >
> > Robert, are you fine with this approach? What about the tests you
> > were doing? Did you make any progress? Did you find other issues?
> So far, with the latest branch from Miquel of tip commit 12b9e62c851c
> ("ARM64: dts: marvell: use reworked NAND controller driver on Armada
> 8K"), the bad blocks issue is still there, ie :
>  - the old pxa3xx driver doesn't see any bad block and mounts the
> ext2/ubifs correctly
>  - barebox doesn't see any bad block
>  - marvell_nand sees all (or most all) blocks as bad with
> "flash_bbt=0" in platform data, which is very surprising
> 
> I'm really surprised that in your tests on the cm_x300, in a
> platform_data setup (ie. not device-tree setup), you're not seeing
> these errors ...

I have no problems with the cm_x300 board (using platform data) but
there is one big difference: the bootloader. You are using Barebox
while I am using U-Boot.

Please pull this branch which is for testing purpose [1].

There are two "HACK"s:
1/ Dump the timing registers: this is to see how Barebox does
initialize these registers. I will put these values back into my setup
and see how the board reacts.
2/ Dump the OOB area while reading. This is to see why the driver
declares all blocks as bad.

Can you please run this branch first?

Then, can you please:
- boot the old driver
- dump both NDTR[0|1] registers that should be well initialized
- boot the new driver with the values previously retrieved (you can
  assign these values where exactly HACK 1/ adds the printk's).


Thank you,
Miqu?l

[1]
https://github.com/miquelraynal/linux/commits/marvell/nand-next/nfc-pxa-bug
