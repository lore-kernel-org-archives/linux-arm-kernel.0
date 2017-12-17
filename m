From: w@1wt.eu (Willy Tarreau)
Date: Sun, 17 Dec 2017 13:05:03 +0100
Subject: pxa3xx_nand times out in 4.14 with JFFS2
Message-ID: <20171217120503.GA3323@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I recently bought a Linksys WRT1900ACS which hosts an Armada 385 and a
NAND flash. While I could get OpenWRT to work flawlessly on it using
kernel 4.4, mainline 4.14.6 fails with a lot of such messages :

    pxa3xx-nand f10d0000.flash: Wait time out!!!

Looking a bit closer, I found that it was triggered by my boot scripts
detecting the JFFS2 signature (0x1985) and trying to mount mtdblock5. But
under openwrt's kernel this partition mounts pretty fine.

I tried to read both /dev/mtd5 and /dev/mtdblock5 it using cat then dd
and got no issue either, so it seems that JFFS2 triggers a specific
operation causing the flash (or driver) to fail. By the way, here's the
device identification :

[    0.638155] pxa3xx-nand f10d0000.flash: This platform can't do DMA on this device
[    0.644661] nand: device found, Manufacturer ID: 0x01, Chip ID: 0xf1
[    0.649732] nand: AMD/Spansion S34ML01G2
[    0.652369] nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
[    0.658662] pxa3xx-nand f10d0000.flash: ECC strength 16, ECC step size 2048

I found a few threads on the net where people were changing the timeout
in the driver, and OpenWRT has this larger timeout, so naturally I thought
it was the way to fix it and I tried, but surprizingly nothing changed at
all.

I found a long troubleshooting session in the list's archives where
CONFIG_PREEMPT had to be enabled to work around the problem here :

   https://patchwork.ozlabs.org/patch/566837/

So I tried to enable it as well but it didn't change anything for me.

I enabled Robert's readl/writel debug traces and have added some messages
at the entrance and exit of every single function in the driver to try to
spot a bit more of it. I've placed the traces there :

   http://1wt.eu/wrt1900acs/

(Please note that the config above doesn't have PREEMPT enabled but it
matches the kernel used to produce the dumps there). Also you'll notice
in the config that I added the out-of-tree mwlwifi driver; I did it late
in the evening after I spent my whole day trying to fix the NAND issue,
so it's irrelevant. However if some prefer that I re-run traces without
it I will.

I purposely split the trace in two steps : one before trying to mount the
JFFS2 fs, and the second one during and after the mount attempt. I also
took another trace with JFFS2 debuging enabled in case that helps.

I noticed that timeouts always occur after such a sequence :

  > pxa3xx_nand_irq:845
  pxa3xx-nand f10d0000.flash: pxa3xx_nand_irq():854 nand_readl(0x0014) = 0x2
  < pxa3xx_nand_irq:932
  < pxa3xx_nand_irq:933
  > pxa3xx_nand_irq_thread:829
  > handle_data_pio:728
  > drain_fifo:693
  < drain_fifo:723
  > drain_fifo:693
  < drain_fifo:723
  < handle_data_pio:761
  pxa3xx-nand f10d0000.flash: pxa3xx_nand_irq_thread():833 nand_writel(0x6, 0x0014)
  < pxa3xx_nand_irq_thread:835

So in short we enter pxa3xx_nand_irq, read register 0x0014 and find 2,
then later we enter pxa3xx_nand_irq_thread(), handle_data_pio(), leave
it, and issue a nand_writel() to register 0x0014 and leave
pxa3xx_nand_irq_thread(). And@this point we wait till the timeout
strikes (apparently the CHIP_DELAY_TIMEOUT since I'm observing 2 seconds
and that's what it's set to).

Interestingly, this morning I left the machine hung like this and came
back 20 minutes later to find that mtdblock5 had finally been successfully
mounted (1322 seconds later precisely). I don't know if something suddenly
decided to work, or if an operation is performed 650 times and waits for
this 2 second timeout for each operation. I've left it running again to
see if it happens again.

I have not tested 4.15-rc3 on it yet, though the only change to the
driver is irrelevant to this issue. I also didn't go back to older
kernels as I'm not sure when this machine was supposed to start to be
supported (the DTS came in 4.12 but given that people started to complain
about the timeout in openwrt's 4.4, it's not clear).

At this point I'm out of ideas so if anyone wants me to test specific
config options to report more info, or to test patches, they're welcome!
There's no emergency for me to get this machine to work properly, it's
expected to replace my current one, but only once it works, so in the
mean time it's more of a development platform lying on my desk :-)

Thanks,
Willy
