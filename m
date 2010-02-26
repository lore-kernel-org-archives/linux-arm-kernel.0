From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 27 Feb 2010 08:36:03 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267200044.14703.31.camel@e102109-lin.cambridge.arm.com>
References: <Pine.LNX.4.44L0.1002241100190.2436-100000@iolanthe.rowland.org>
	<1267046036.23523.1693.camel@pasglop>
	<1267200044.14703.31.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1267220163.23523.1806.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-02-26 at 16:00 +0000, Catalin Marinas wrote:
> > I'm surprised that usb-storage has an issue here. It shouldn't
> afaik,
> > since it's just a SCSI driver (or not anymore ?) and the BIO or
> > filesystems handle things there no ? I haven't seen a single call to
> > flush_dcache_page() in any of drivers/scsi, drivers/ata or
> drivers/ide
> > when I looked...
> 
> The BIO or filesystem code don't call flush_dcache_page() either (well
> some do like cramfs or jffs but they decompress the data received from
> the block device). 

That's weird... that would mean that all existing PIO IDE or SCSI is
broken etc... Including I$/D$ cache coherency on powerpc and more. That
surprises me :-)

On an older kernel tree here:

$ grep -r flush_dcache_page fs | wc -l
118

So maybe that's where things need fixing ?

Cheers,
Ben.
