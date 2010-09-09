From: ww-ml@gmx.de (Wolfgang Wegner)
Date: Thu, 9 Sep 2010 18:21:35 +0200
Subject: Kirkwood PCI(e) write performance and DMA engine support for
	copy_{to, from}_user?
In-Reply-To: <20100908083558.GA3393@debian-wegner1.datadisplay.de>
References: <20100906100244.GA6897@debian-wegner1.datadisplay.de>
	<20100906140347.GA24522@n2100.arm.linux.org.uk>
	<20100906141444.GD6897@debian-wegner1.datadisplay.de>
	<AANLkTimqiAuv9XiU55VBxfPO6HZXCs5d9pshS3XDwsFc@mail.gmail.com>
	<AANLkTi=Mgzw9m+KiyzG7sHqD=mv1Q6WZXqMn_s_+p6Oq@mail.gmail.com>
	<20100907161156.GA3625@debian-wegner1.datadisplay.de>
	<alpine.LFD.2.00.1009071443360.19366@xanadu.home>
	<20100908083558.GA3393@debian-wegner1.datadisplay.de>
Message-ID: <20100909162135.GA3524@debian-wegner1.datadisplay.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 08, 2010 at 10:35:58AM +0200, Wolfgang Wegner wrote:
> 
> Using your assembler code, I get almost double throughput (0.035s->
> 0.018s, meaning around 466 MBytes/s) for RAM and a system lockup
> for my PCI device. Hmm...
> 
> I will now set up some eval boards to see if I get an "off-the-shelf"
> framebuffer with a stock PCI graphics card up and running for a
> comparison.

The only memory-mapped PCI device I managed to get to run in the
PCIe->PCI bridge eval board was the FPGA evaluation board, together
with the manufacturer-supplied evaluation code. (The PCI
graphics cards were either too old (5V) or ATI-based, whose
driver seems to have been "improved" resulting in failure
without a BIOS. *sigh*)

With the FPGA evaluation board I get:
- around 38 MBytes/second with Nicolas' inline assembly code
- around 6 MBytes/second with any other C code (mmapped) as
  well as write() via dd

Regardless of using ioremap_{wc,nocache,cached} and
pgprot_writecombine/pgprot_noncached.

So the main problem seems to be either our board implementation
of the PCIe->PCI bridge or the FPGA. However, I am still wondering
how a framebuffer-based application can attain reasonable performance,
as (to my understanding) in most of the cases using such an
throughput-optimized assembly code will not be possible.

On a side note: can anybody give a hint how to enable
ASYNC_CORE/ASYNC_MEMCPY? I see the options in crypto/async_tx/Kconfig
but can not find them via menuconfig? I would still like to try
using the DMA engine for transferring complete frames...

Regards,
Wolfgang

PS: another PCI device I tried via the PCIe->PCI bridge was
    a Intel 82574L GBit NIC, which was able to reach >600MBit/s
    throughput when tested with netio or netperf
