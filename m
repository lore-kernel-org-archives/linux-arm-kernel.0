From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 4 Jun 2014 16:35:10 +0200
Subject: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140602104104.GD3855@e103592.cambridge.arm.com>
References: <1400877218-4113-1-git-send-email-thierry.reding@gmail.com>
 <4545972.cM7IP1qTXQ@wuerfel>
 <CAL_Jsq+tkFNpjSEZboT+o69B_Z3a8e-ZVKaYDmLwtkyYoPy6VQ@mail.gmail.com>
 <5288123.eXagyPAxNq@wuerfel>
 <20140602104104.GD3855@e103592.cambridge.arm.com>
Message-ID: <20140604143509.GF28484@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 02, 2014 at 11:41:04AM +0100, Dave Martin wrote:
> On Fri, May 30, 2014 at 09:49:59PM +0200, Arnd Bergmann wrote:
> > On Friday 30 May 2014 14:31:55 Rob Herring wrote:
> > > On Fri, May 30, 2014 at 2:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Friday 30 May 2014 08:16:05 Rob Herring wrote:
> > > >> On Fri, May 23, 2014 at 3:33 PM, Thierry Reding
> > > >> <thierry.reding@gmail.com> wrote:
> > > >> > From: Thierry Reding <treding@nvidia.com>
> > > >> > +IOMMU master node:
> > > >> > +==================
> > > >> > +
> > > >> > +Devices that access memory through an IOMMU are called masters. A device can
> > > >> > +have multiple master interfaces (to one or more IOMMU devices).
> > > >> > +
> > > >> > +Required properties:
> > > >> > +--------------------
> > > >> > +- iommus: A list of phandle and IOMMU specifier pairs that describe the IOMMU
> > > >> > +  master interfaces of the device. One entry in the list describes one master
> > > >> > +  interface of the device.
> > > >> > +
> > > >> > +When an "iommus" property is specified in a device tree node, the IOMMU will
> > > >> > +be used for address translation. If a "dma-ranges" property exists in the
> > > >> > +device's parent node it will be ignored. An exception to this rule is if the
> > > >> > +referenced IOMMU is disabled, in which case the "dma-ranges" property of the
> > > >> > +parent shall take effect.
> > > >>
> > > >> Just thinking out loud, could you have dma-ranges in the iommu node
> > > >> for the case when the iommu is enabled rather than putting the DMA
> > > >> window information into the iommus property?
> > > >>
> > > >> This would probably mean that you need both #iommu-cells and #address-cells.
> > > >
> > > > The reason for doing like this was that you may need a different window
> > > > for each device, while there can only be one dma-ranges property in
> > > > an iommu node.
> > > 
> > > My suggestion was that you also put the IDs in the dma-ranges as the
> > > first cell much as ranges for PCI encodes other information in the
> > > first cell. Then you can have an entry for each ID. The downside is
> > > another special case like PCI.
> > > 
> > > The argument for using #address-cells and #size-cells seems to be to
> > > align with how ranges work. If that's the route we want to go, then I
> > > say we should not stop there and actually use dma-ranges as well.
> > > Otherwise, I don't see the advantage over #iommu-cells.
> > 
> > I can see how dma-ranges in bus nodes work, it just doesn't seem to
> > have any reasonable meaning in the iommu node itself.
> 
> dma-ranges defines a static mapping for mastering through the bus node.
> 
> The whole point of an IOMMU is that it maps dynamically, so I agree:
> I'm unclear on what dma-ranges should mean in the IOMMU node itself
> (if anything).
> 
> > 
> > > > I don't understand the problem. If you have stream IDs 0 through 7,
> > > > you would have
> > > >
> > > >         master at a {
> > > >                 ...
> > > >                 iommus = <&smmu 0>;
> > > >         };
> > > >
> > > >         master at b {
> > > >                 ...
> > > >                 iommus = <&smmu 1;
> > > >         };
> > > >
> > > >         ...
> > > >
> > > >         master at 12 {
> > > >                 ...
> > > >                 iommus = <&smmu 7;
> > > >         };
> > > >
> > > > and you don't need a window at all. Why would you need a mask of
> > > > some sort?
> > > 
> > > 1 master with 7 IDs like this:
> > > 
> > >          master at a {
> > >                  ...
> > >                  iommus = <&smmu 0> <&smmu 1> <&smmu 2> <&smmu 3>
> > > <&smmu 4> <&smmu 5> <&smmu 6> <&smmu 7>;
> > >          };
> > > 
> > > If there was any sort of window, then it is almost certainly the same
> > > window for each ID.
> 
> Do we have real examples of using a window *and* an ID?  I thought the
> windowed-IOMMU concept was partly a way of encoding the ID in some
> real address bits on the bus.  If you're doing that, it seems less likely
> that there is a true "ID" as such (though it is possible).
> 
> > Ok, I see. In that case you'd probably want to have #address-cells = <1>
> > and #size-cells = <1> and give a range of IDs like
> > 
> > 	iommus = <&smmu 0 8>;
> > 
> > Do you think that ranges can have a meaningful definition with the ARM
> > SMMU stream IDs?
> 
> In the strictest sense, no.
> 
> But for a large set of sane configurations, this probably works.
> 
> Small sets of randomly-assigned IDs can just be enumerated one by one.
> 
> We wouldn't be able to describe folding and bit shuffling, but we
> probably don't want to encourage that anyway.

I'm having some difficulty understanding this. You make it sound like
there's a fairly arbitrary number of IDs that the SMMU can handle. So
how is the mapping to devices defined? If you say encourage that does
make it sound like the assignment of IDs is purely defined by some
mechanism in software rather than in hardware. Or they are more or less
randomly picked by someone. If that's the case, is that not something
that should be dynamically allocated by the kernel rather than put into
the device tree?

Maybe in the above case all you really need to know is how many IDs a
device needs to be assigned so that they can be properly allocated,
rather than the device exactly specifying which ones.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140604/266cc7e2/attachment-0001.sig>
