From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Mon, 14 Nov 2016 11:06:45 +0000
Subject: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
In-Reply-To: <2825537.ADCNsGqGxn@wuerfel>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1555494.4IFvGxvsfe@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F8F1A7A@lhreml507-mbx>
 <2825537.ADCNsGqGxn@wuerfel>
Message-ID: <20161114110645.0763092b@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 09 Nov 2016 22:34:38 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday, November 9, 2016 12:10:43 PM CET Gabriele Paoloni wrote:
> > > On Tuesday, November 8, 2016 11:47:09 AM CET zhichang.yuan wrote:  
> > > > +       /*
> > > > +        * The first PCIBIOS_MIN_IO is reserved specifically for  
> > > indirectIO.  
> > > > +        * It will separate indirectIO range from pci host bridge to
> > > > +        * avoid the possible PIO conflict.
> > > > +        * Set the indirectIO range directly here.
> > > > +        */
> > > > +       lpcdev->io_ops.start = 0;
> > > > +       lpcdev->io_ops.end = PCIBIOS_MIN_IO - 1;
> > > > +       lpcdev->io_ops.devpara = lpcdev;
> > > > +       lpcdev->io_ops.pfin = hisilpc_comm_in;
> > > > +       lpcdev->io_ops.pfout = hisilpc_comm_out;
> > > > +       lpcdev->io_ops.pfins = hisilpc_comm_ins;
> > > > +       lpcdev->io_ops.pfouts = hisilpc_comm_outs;  
> > > 
> > > I have to look at patch 2 in more detail again, after missing a few
> > > review
> > > rounds. I'm still a bit skeptical about hardcoding a logical I/O port
> > > range here, and would hope that we can just go through the same
> > > assignment of logical port ranges that we have for PCI buses,
> > > decoupling
> > > the bus addresses from the linux-internal ones.  
> > 
> > The point here is that we want to avoid any conflict/overlap between
> > the LPC I/O space and the PCI I/O space. With the assignment above
> > we make sure that LPC never interfere with PCI I/O space.  
> 
> But we already abstract the PCI I/O space using dynamic registration.
> There is no need to hardcode the logical address for ISA, though
> I think we can hardcode the bus address to start at zero here.

Pedantically ISA starts at 0x100. The LPC may start at 0x00 as it also
covers motherboard devices (0x00-0xFF). It is also possible that the
'LPC' space is only partially routed to the PCI bridges because some if
it magially disappears on CPU die (at least on x86) and has done since
the era of socket 7 (eg the Cyrix 6x86 doesn't route 0x22/0x23 out of the
CPU).

Assuming LPC starts at 0 ought to be ok given the PCI root bridge
shouldn't see the transactions.

The LPC or it's equivalent may also not be routed via the PCI bridges at
all, so you could have an LPC mapping that is unused or partially used
with another bus actually getting some classes of LPC traffic - on x86 at
least.

Alan
