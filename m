From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Jul 2013 10:39:32 +0200
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <CACxGe6sUFmLZMT+dvCbpmPrzR3DNMjw64LbD3n=JsjXsmrM-qg@mail.gmail.com>
References: <51F3A82E.2000907@broadcom.com>
 <CACxGe6t0C7PTiDDaFkgoMZWUpBVokasxwZpV6HEtf3LaPi4qUw@mail.gmail.com>
 <CAKON4OymA55w_V=oP4BL2su84m8EnPgdhnQtyLWKaAJE-yNBkQ@mail.gmail.com>
 <CACxGe6uE6jOE-vz0onW5h93Es-soGiBAcFBM7Dvxh+HvCNrHkw@mail.gmail.com>
 <CACxGe6vw9=y5a+EgF1gO39SwGAdGofD2MYjyJ3jYu6uN3ke70A@mail.gmail.com>
 <1374988276.1973.29.camel@dabdike>
 <20130730014453.GJ29970@voom.fritz.box>
 <CAKON4OyWuF+qm2MAhbXnGg=ozzw37kpSWciLxyUy+QQzxoWdxQ@mail.gmail.com>
 <20130730032926.GL29970@voom.fritz.box>
 <CACxGe6sUFmLZMT+dvCbpmPrzR3DNMjw64LbD3n=JsjXsmrM-qg@mail.gmail.com>
Message-ID: <20130730083932.GE1441@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 10:35:03PM -0600, Grant Likely wrote:
> >> User acquires a machine running ARM Linux version 3.x, with u-boot
> >> and dtb in a read only flash partition. The board boots and works just
> >> fine. However, for his application, the user requires a new kernel
> >> feature that appeared in version 3.y where y > x. He compiles the new
> >> kernel, and it also works.
> >
> > I'm afraid this kind of use case will never be properly supported, DT
> > stable ABI or not.
> 
> Why? New kernel features should be no problem at all.
> 
> New driver features /might/ not be available, but only if the new
> feature requires additional data that isn't present in the tree and
> cannot be obtained elsewhere.
> 
> >
> > Think about this: what kernel will actually be shipped in that board?
> > Most likely, it will be a BSP kernel from the vendor. Does the vendor
> > will have made that commitment to have a stable ABI for the DT? Will it
> > use the same bindings than mainline? Do we want to support all the crazy
> > bindings every vendor will come up with?
> 
> That's not a DT issue. That an out-of-tree board/SoC support issue. DT
> doesn't make that any better or worse.

Yet, with the DT switch, the two are bound together.

Before the DT, the only convention we had basically was that we had to
be loaded in memory and executed.

Now, the bootloader has to pass a complex data structure to the kernel.
If this data structure doesn't follow the same convention than we do, we
are screwed, and if we can't update either the bootloader or the DT that
is loaded by it, we end up screwed.

One example that comes to my mind right now is this one: we've been
arguing over spidev probing for quite some time. The easy solution would
be to add a "linux,spidev" compatible. Obviously, this has been ruled
out numerous time. Yet, in the beaglebone black out-of-tree kernel,
there is actually a patch that adds this compatible, that is later used
in the DTs.

These spidev part of the DTs will never work with vanilla. And if you
can't update the DT and want to use mainline, you'll never ever have the
same feature set.

That's of course just a small example, with not much impact on a system,
but that could be way worse.

But saying that vendors will follow the same convention we do is just
unrealistic. I mean, even us haven't be able to work out a stable ABI
for more than 2 years now, yet we should expect anyone else to do it?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130730/9def5cff/attachment.sig>
