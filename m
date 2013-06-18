From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 18 Jun 2013 13:10:18 -0600
Subject: [PATCH v3 03/12] bus: mvebu-mbus: Add static window allocation
 to the DT binding
In-Reply-To: <51C0ADF7.5050609@gmail.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130618174622.GD2204@obsidianresearch.com>
 <51C0A5F8.8030300@gmail.com> <201306182039.50736.arnd@arndb.de>
 <51C0AA8E.9080807@gmail.com>
 <20130618184753.GA6090@obsidianresearch.com>
 <51C0ADF7.5050609@gmail.com>
Message-ID: <20130618191018.GB6578@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 08:59:03PM +0200, Sebastian Hesselbarth wrote:

> >S = 0 means 4 bit I, 8 bit A
> >S = F means special
> >S = 1 could mean 16 bit I, etc , etc
> 
> S & 0x8 == 0x0 means 7b target
> S & 0x8 == 0x8 means 7b special ?

No need, special == mbus driver defined. There is no target ID.

The forms could be:

 0IAA0000
 FK000000
   - K=0 -> internal regs
   - K=1 -> PCI-E thingy
    etc
 1IIAA000 (future expansion example)


> >The mbus top level ranges remap already supports>4G locations for
> >the windows, even though current hardware cannot do that.
> 
> True. But as Arnd also mentioned, I don't think it will ever be a
> problem at all. Possibly there will never be any future SoC with mbus
> that will either allow >32b remap base addresses nor >4G size.

Actually, I think the failure to allow > 32b remap is a mistake
on Marvell's part. Linux needs as much low memory as possible, moving
things above 4G gives you more low SDRAM.

So I'd hope to see 40bit addressing for MBUS windows in a future chip.

But again, that already works with what Ezequiel has..

To be very clear, the only issue with the 32 bit offset is if we need
to describe an offset into a target in DT that is larger than 32
bits. The only use of offsets in DT is for internal regs. The
need for a > 32 bit offset in DT does not exist with the current
architecture.

Jason
