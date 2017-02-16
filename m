From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Feb 2017 15:08:48 +0100
Subject: [PATCH 2/4] PCI: add driver for Cortina Gemini Host Bridge
In-Reply-To: <CACRpkdb=BqihykWo3egtNW1VKE2-FV+nJQQVYOc2GdCvh1fMng@mail.gmail.com>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <2695922.yyinjvNuJK@wuerfel>
 <CACRpkdb=BqihykWo3egtNW1VKE2-FV+nJQQVYOc2GdCvh1fMng@mail.gmail.com>
Message-ID: <3658176.ffWihUmtIa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, February 4, 2017 7:43:15 PM CET Linus Walleij wrote:
> On Wed, Feb 1, 2017 at 12:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Saturday, January 28, 2017 9:48:37 PM CET Linus Walleij wrote:
> 
> >> +     /* No clue what these do */
> >> +     pcibios_min_io = 0x100;
> >> +     pcibios_min_mem = 0;
> >
> > Don't touch these
> 
> OK I have a clue why this is there now, atleast the first one.
> 
> The first 0x100 in the IOspace is actually configuration registers
> for the bridge. That is why we have this:

I see. It's normal to have the PCI config space done through
ports 0cf8-0cff, but apparently this one uses other ports in
the same range.

> reg = <0x50000000 0x100>;
> (...)
> /* PCI ranges mappings */
>                         ranges = /* 1MiB I/O space 0x50000000-0x500fffff */
>                          <0x01000000 0 0          0x50000000 0 0x00100000>,
> 
> This is in all the vendor code I have located too.
> 
> So the pcibios_min_io is manipulated to avoid touching that
> sensitive area. But I also see that arch/arm/mm/iomap.c
> sets it to 0x1000, according to the commit because you said
> it's the only valid value :D
> 
> I tried setting the IO range to <0x50000100 0x000FFF00>
> instead of <0x50000000 0x00100000>
> but predictably that doesn't work. Maybe it should, I don't
> know really.

It should work in theory, but then you'd have to update
io_offset accordingly, and it would be a bit confusing.

Did you notice my other comment below (quoting from my own
message)?

> > +
> > +     bus = pci_scan_root_bus(&pdev->dev, 0, &gemini_pci_ops, p, &res);
> 
> Can you try using the new pci_register_host_bridge() API?

	Arnd
