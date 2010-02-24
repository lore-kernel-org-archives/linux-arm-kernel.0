From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 24 Feb 2010 16:50:38 -0500 (EST)
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267046036.23523.1693.camel@pasglop>
Message-ID: <Pine.LNX.4.44L0.1002241641370.1253-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Feb 2010, Benjamin Herrenschmidt wrote:

> I'm surprised that usb-storage has an issue here. It shouldn't afaik,
> since it's just a SCSI driver (or not anymore ?)

It still is.  There's also the ub driver, which is a non-SCSI block 
device driver for some of the same devices handled by usb-storage.

> and the BIO or
> filesystems handle things there no ? I haven't seen a single call to
> flush_dcache_page() in any of drivers/scsi, drivers/ata or drivers/ide
> when I looked...

There is no real issue; it's just that the problem was first noted in 
connection with usb-storage reading in executable pages, so Catalin's 
initial post was oriented toward modifying usb-storage.

The main issue here is that the same host controller will use PIO
sometimes and DMA sometimes, depending on the details of the transfer.  
The USB core didn't expect this and consequently we violated the rules
for DMA mapping.  The question is: If the core is fixed so that the
rules aren't violated, will everything work correctly?

Alan Stern
