From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 14 Jul 2014 08:44:53 +0200
Subject: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140713094341.GB23235@arm.com>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
 <20140712093917.GD18601@arm.com>
 <CAF6AEGutHp+3f3iPA+jjaRkqq=5T_vytZ_ESoSqsQ4RHZ8F8yQ@mail.gmail.com>
 <201407121422.02078.arnd@arndb.de>
 <CAF6AEGs7=3UByP2DLm-uwU03wr7M14x2t-0hLX-VPJ6_eZbU3g@mail.gmail.com>
 <20140713094341.GB23235@arm.com>
Message-ID: <20140714064452.GD2081@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 13, 2014 at 10:43:41AM +0100, Will Deacon wrote:
> On Sat, Jul 12, 2014 at 01:57:31PM +0100, Rob Clark wrote:
> > On Sat, Jul 12, 2014 at 8:22 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Saturday 12 July 2014, Rob Clark wrote:
> > >> >> Was there actually a good reason for having the device link to the
> > >> >> iommu rather than the other way around?  How much would people hate it
> > >> >> if I just ignore the generic bindings and use something that works for
> > >> >> me instead.  I mean, it isn't exactly like there is going to be .dts
> > >> >> re-use across different SoC's..  and at least with current IOMMU API
> > >> >> some sort of of_get_named_iommu() API doesn't really make sense.
> > >> >
> > >> > The thing is, if you end up ignoring the generic binding then we have two
> > >> > IOMMUs using the same (ARM SMMU) binding and it begs the question as to
> > >> > which is the more generic! I know we're keen to get this merged, but merging
> > >> > something that people won't use and calling it generic doesn't seem ideal
> > >> > either. We do, however, desperately need a generic binding.
> > >>
> > >> yeah, ignoring the generic binding is not my first choice.  I'd rather
> > >> have something that works well for everyone.  But I wasn't really sure
> > >> if the current proposal was arbitrary, or if there are some
> > >> conflicting requirements between different platforms.
> > >
> > > The common case that needs to be simple is attaching one (master) device
> > > to an IOMMU using the shared global context for the purposes of implementing
> > > the dma-mapping API.
> > 
> > well, I don't disagree that IOMMU API has some problems.  It is too
> > tied to the bus type, which doesn't really seem to make sense for
> > platform devices.  (Unless we start having multiple platform busses?)
> > 
> > But at least given the current IOMMU API I'm not really sure how it
> > makes a difference which way the link goes.  But if there has already
> > been some discussion about how you want to handle the tie in with
> > dma-mapping, if you could point me at that then maybe your point will
> > make more sense to me.
> 
> If you look at the proposed binding in isolation, I think it *is* cleaner
> than the ARM SMMU binding (I've acked it...) and I believe it's more
> consistent with the way we describe linkages elsewhere.
> 
> However, the issue you're raising is that it's more difficult to make use of
> in a Linux IOMMU driver.

Like I said, if it's difficult to make use of this in a Linux IOMMU
driver then the right thing that we should be focusing on is enhancing
the IOMMU framework to better cope with this.

> The reward you'll get for using it will come eventually when the DMA
> ops are automatically swizzled for devices using the generic binding.

Note that for the case that Rob mentioned (and similarly for the primary
use-case that I have) the DMA integration layer isn't a good fit. So the
goal should be to make this easier to work with when using the DMA layer
*and* when using the IOMMU API directly.

> My plan for the ARM SMMU driver is:
> 
>   (1) Change ->probe() to walk the device-tree looking for all masters with
>       phandles back to the SMMU instance being probed

You and Rob mentioned this several times and I don't understand why the
SMMU needs to know all masters up front. Is this necessary because it
needs to program all registers at .probe() time and they can't be
reprogrammed subsequently? Or is this just some kind of optimization?

>   (2) For each master, extract the Stream IDs and add them to the internal
>       SMMU driver data structures (an rbtree per SMMU instance). For
>       hotpluggable buses, we'll need a way for the bus controller to
>       reserve a range of IDs -- this will likely be a later extension to
>       the binding.
> 
>   (3) When we get an ->add() call, warn if it's a device we haven't seen
>       and reject the addition.

It seems to me like this would be the logical place to parse stream IDs.
You could for example have a case where some device tree contains a node
for which no driver will ever be loaded (for example because it hasn't
been built-in, or the device is never used and the module is therefore
never loaded). That's a situation that you cannot determine by simply
walking the device tree in the IOMMU's .probe().

I've always thought about IOMMU masters much in the same way as other
types of resources, such as memory or interrupts. In the rest of the
kernel we do carefully try to postpone allocation of these resources
until they are required, specifically so we don't waste resources when
they're unused.

That's also one of the reasons why I think associating an IOMMU with the
bus type is bad. Currently if an IOMMU driver thinks it should enable
translation for a given device, then there's no way for that device's
driver to opt out again. There may be reasons (performance, hardware
bugs, ...) for the driver to decide against using the IOMMU for
translation, but there's currently no way to do that if the IOMMU driver
disagrees.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/25c5eef6/attachment.sig>
