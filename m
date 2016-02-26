From: djkurtz@chromium.org (Daniel Kurtz)
Date: Sat, 27 Feb 2016 00:47:24 +0800
Subject: [RFC 3/3] CMDQ: Mediatek CMDQ driver
In-Reply-To: <1456477230.17841.2.camel@mtksdaap41>
References: <8A0FDEEF9DBBD140A3857422D81DA20F867B19FD@mtkmbs01n1>
 <1454479333.11967.12.camel@mtksdaap41>
 <CAGS+omABD93f3X0pfiFgaxa9Lob2txkJfUUomUvs+hiRkxSuHw@mail.gmail.com>
 <1456477230.17841.2.camel@mtksdaap41>
Message-ID: <CAGS+omBRhYugsiFTzfDG2jtON4rj7Y4aDY-X2afRSh09G-ZC+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 5:00 PM, Horng-Shyang Liao <hs.liao@mediatek.com> wrote:
>
> On Wed, 2016-02-03 at 14:40 +0800, Daniel Kurtz wrote:
> > > Hi Dan,
> > >
> > > Thanks for your comment.
> > > This solution looks good to me.
> > > I will change it as your suggestion.
> > >
> > > But, I have a question about 'mask out the provided *device virtual*
> > > address'.
> > > Are lower 16-bits (or 24-bits for JUMP op) of device virtual address the
> > > same as device physical address?
> >
> > I'm not sure.  But I doubt it we can rely on this.
> > My guess would be that the ioremap only preserves the lower 12 bits
> > (4k page size).
> >
> > > If not, we still need to pass in physical address into CMDQ driver.
> >
> > Or, instead of the iommu/slot approach, we can just provide a
> > registration function for the gce driver.
> > Each gce consumer could then have a simple gce node, with no slot/address:
> >
> >   mediatek,gce = <&gce>;
> >
> > Then on probe, the gce consumer could pass in its (struct device *) to
> > gce_register_device().  gce_register_device() could then access the
> > device's of_node to extract its physical address range, and look up
> > its physical address in its table of per-soc of
> > "device_address:gce_subsys_address" entries.  If the physical address
> > is in a valid subsys ranges, the gce_register_device would cache the
> > subsys address, and an offset in a (struct gce_consumer).
> > gce_register_device() could then add this struct to a struct list_head
> > of gce_consumers, and finally return a pointer to it back to the
> > caller.
> >
> > Later, the gce consumer could pass in ths (struct gce_consumer *) when
> > make gce calls, along with the *offset* (not the physical address or
> > virtual address) for the register that it wishes to access.  Then the
> > gce driver can simply use the gce_consumer->subsys entry to create a
> > gce address from the passed in offset.
> >
> > This will keep the binding very simple, and would remove the need to
> > convert from device virtual to physical addresses by the gce consumer,
> > but require a little more per-gce-consumer setup.
> >
> > -Dan
>
> Hi Dan,
>
> When I try to implement this comment, I realize the only benefit from
> this comment is to wrap physical address.
>
> Recall from my previous reply: gce address = subsys + valid low bits.
> So, CMDQ driver still need to do "(Base + offset) & valid mask" to get
> gce valid low bits.
> Current implementation let display driver do "base + offset".
> This comment just transfers this calculation from display driver to CMDQ
> driver.
>
> However, this comment will let CMDQ interface (behavior) become more
> complicated, e.g. gce_register_device(), struct gce_consumer, and int
> cmdq_rec_write(struct cmdq_rec *handle, u32 value, struct gce_consumer
> *consumer, u32 offset)
>
> Do you think it is worth to do this effort to wrap physical address?

Yes, I think it is worth it to unify the gce address computation and
move it into the gce driver.

-Dan
