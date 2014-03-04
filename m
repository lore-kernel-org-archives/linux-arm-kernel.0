From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 3 Mar 2014 18:01:08 -0700
Subject: [PATCH 3/3] PCI: imx6: ventana: fixup for IRQ mismapping
In-Reply-To: <CAJ+vNU1+o=2+YF8W=QfBNUhyCoC1tm17KD=cwRnUJozbbsN8qQ@mail.gmail.com>
References: <1393550394-11071-1-git-send-email-tharvey@gateworks.com>
 <1393550394-11071-4-git-send-email-tharvey@gateworks.com>
 <7755759.E1g1jlxbyc@wuerfel>
 <20140228173957.GC7773@obsidianresearch.com>
 <CAJ+vNU0Ao4BJhL9kQL45_nGf7hFZWsBMXMs9Y_pr10Mamqtnxw@mail.gmail.com>
 <20140301012234.GA31062@obsidianresearch.com>
 <CAJ+vNU0CLO6GWpYGx6SG1sXrqkn=6BNoFGodBtWxeCYUTEQW5Q@mail.gmail.com>
 <20140303233733.GA5603@obsidianresearch.com>
 <CAJ+vNU1+o=2+YF8W=QfBNUhyCoC1tm17KD=cwRnUJozbbsN8qQ@mail.gmail.com>
Message-ID: <20140304010108.GA31144@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 04:38:10PM -0800, Tim Harvey wrote:
> On Mon, Mar 3, 2014 at 3:37 PM, Jason Gunthorpe
> <jgunthorpe@obsidianresearch.com> wrote:
> > On Mon, Mar 03, 2014 at 11:59:51AM -0800, Tim Harvey wrote:
> >
> >> A pci fixup for the XIO2001 could at least be placed in
> >> arch/arm/mach-imx/mach-imx6q.c with a check for
> >> of_machine_is_compatible("gw, ventana").  This is currently done in
> >> order to handle GPIO on the PEX890x bridge which is used as PERST# for
> >> downstream slots (see
> >> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/mach-imx/mach-imx6q.c#n87).
> >
> > That is an odd looking thing .. PERST# of a subordinate port should be
> > tied to the PCI_BRIDGE_CTL_BUS_RESET bit in the port's bridge
> > configuration space - is more configuration of the PLX chip required?
> 
> PCI_BRIDGE_CTL_BUS_RESET does cause a hot reset on the corresponding
> downstream link however the minPCIe card slot has a PERST# pin that is
> for a functional reset to the card.  

Ah, I'm getting my PCI versions mixed up, that all sounds right to me
then..

> > Also, be aware that PCI specifies a minimum time after
> > reset-deassertion before accessing the bus, and I don't see a sleep...
> 
> there is an msleep(100) there after the de-assertion.

.. and I'm blind, looks good.

> Ok - that all makes sense and hopefully when I get the legacy PCI
> interrupt mapping via DT working for IMX6 I can prove it out.
> 
> What did you think of my two ideas above to resolve this issue on our
> add-in card where the bus-topology isn't known ahead of time:
> 
>  1. bootloader builds out DT with proper interrupt-map's to handle the
> mis-map after enumerating the bus to understand the toplogy.

This is how the OF stuff for PCI has historically been used, so it is
a nice OS-agnostic way to implement this work around, particularly if
you have some kind of daughter card specific information you can rely
on (eg a SPD that could indicate the problematic PCB revision)

If you do that you could also hoist the required fixup for your switch
into firmware too.

>  2. a pci fixup for xio2001 that further qualifies the DT machine and
> the 'depth' of the xio2001 (ie make sure its the first xio2001 bridge
> on the bus) that replaces the swizzle function.  This would be in
> arch/arm/mach-imx/mach-imx6q.c

You can probably make this work, but given there is already a DT based
fix I'm not sure if people will like a .c version, especially if it
requires more single-use 'general purpose' interfaces from the core
code...

Jason
