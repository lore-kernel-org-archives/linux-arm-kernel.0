From: w@1wt.eu (Willy Tarreau)
Date: Tue, 8 Apr 2014 16:53:44 +0200
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140408164317.0e9b9092@skate>
References: <alpine.DEB.2.10.1404062253500.16719@vroombuntu>
 <20140407174106.GD9952@obsidianresearch.com>
 <CAAfodu0kbTspq2QQf0dh3U7LB-q+ECaX9FJ35fCc25UmgPJZSg@mail.gmail.com>
 <20140407204817.GB20736@obsidianresearch.com>
 <alpine.DEB.2.10.1404072239050.32332@vroombuntu>
 <20140408064003.GU29787@1wt.eu>
 <CAFJTrDu82avr6mSaz1PNzOJ0tnQiH5aiq6URiXZAbJ=4W+2EJg@mail.gmail.com>
 <CAFJTrDtiRctixnbBEbHMsnxsPy7ew9-7SoD5cyUA6DWPU9p6Fw@mail.gmail.com>
 <20140408123632.GG8767@1wt.eu> <20140408164317.0e9b9092@skate>
Message-ID: <20140408145344.GB11052@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Tue, Apr 08, 2014 at 04:43:17PM +0200, Thomas Petazzoni wrote:
> Willy, Neil, Matthew,
> 
> On Tue, 8 Apr 2014 14:36:32 +0200, Willy Tarreau wrote:
> 
> > On Tue, Apr 08, 2014 at 01:31:48PM +0100, Matthew Minter wrote:
> > > To add to my previous point, I would consider releasing these patches
> > > as soon as possible as it seems that it can easily cause panics on a
> > > range of boards. Failing that perhaps it is at least worth releasing a
> > > hotfix which will cause PCI probing to fail should the window not be a
> > > power of two? Thus it will fail early with a warning instead of
> > > potentially causing a kernel crash.
> > 
> > Have you tested the whole patch or just the one enforcing the power of 2 ?
> > It would be interesting to know if the one with SZ_4M is needed for you or
> > not (I guess not).
> > 
> > I suspect that just this single-liner will work as well, as it does for me.
> > 
> > Thanks,
> > Willy
> > 
> > 
> > diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> > index 0e79665..552ab73 100644
> > --- a/drivers/pci/host/pci-mvebu.c
> > +++ b/drivers/pci/host/pci-mvebu.c
> > @@ -363,6 +363,7 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
> >  	port->memwin_size  =
> >  		(((port->bridge.memlimit & 0xFFF0) << 16) | 0xFFFFF) -
> >  		port->memwin_base;
> > +	port->memwin_size = roundup_pow_of_two(port->memwin_size);
> >  
> >  	mvebu_mbus_add_window_by_id(port->mem_target, port->mem_attr,
> >  				    port->memwin_base, port->memwin_size);
> 
> Thanks to all of you for the investigation. So if I summarize your
> findings, we have two patches needed to fix the problems of everybody:
> 
>  1) The bug fix for the MSI teardown function in irq-armada-370-xp.c.
>     This one is easy, I'll test it right now, and give my formal
>     Acked-by soon.
> 
>  2) The problem of non-power of 2 sized windows. This one is more
>     complicated, as we cannot simply round up the size of the windows
>     inside the pci-mvebu.c driver: the Linux PCI core is not aware of
>     this rounding, and might therefore allocate a BAR for the next
>     device at an address that overlaps the previous window we have
>     enlarged to match the power of two size requirement. This is
>     something that was already discussed with the PCI maintainers, but
>     the discussion needs to be revived I guess.
> 
> Am I correct, or are other patches needed, or are remaining problems
> not solved by these two fixes?

There's still the older issue I got with trying to load a 2-port based
igb card on the xp-gp, the code says that hwirq 0xffffffe4 is invalid
and cannot be enabled and after that it panics. I recall having debugged
this one a few months ago, and finding something like ffffffe4 == -ENOSPC
which was returned by one of the inner functions. Let's put that aside
for a moment though, but I would appreciate it if you find the time to
try your igb NIC on your XPGP in 3.14 to see if you get the same result.

Thanks,
Willy
