From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 4 Jun 2014 23:12:38 +0200
Subject: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140530112728.GB3949@e103592.cambridge.arm.com>
References: <1400877395-4235-1-git-send-email-thierry.reding@gmail.com>
 <538757B6.4010109@wwwdotorg.org> <20140530073006.GA24748@ulmo>
 <20140530112728.GB3949@e103592.cambridge.arm.com>
Message-ID: <20140604211237.GC18710@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 12:27:28PM +0100, Dave Martin wrote:
> On Fri, May 30, 2014 at 08:30:08AM +0100, Thierry Reding wrote:
[...]
> > Arnd, can you take another look at this binding and see if there's
> > anything else missing? If not I'll go through the document again and
> > update all #address-cells/#size-cells references with #iommu-cells as
> > appropriate and submit v3.
> 
> How do you envisage propagation of the master ID bits downstream of the
> IOMMU would be described?
> 
> We will definitely need a way to describe this for GICv3.  How those
> values are propagated is likely to vary between related SoCs and doesn't
> feel like it should be baked into a driver, especially for the ARM SMMU
> which may get reused in radically different SoC families from different
> vendors.

Well, we've had cases like these in the past (power sequences come to
mind). Some concepts are just too difficult or unwieldy to be put into
device tree. I think that this is one of them.

> The most likely types of remapping are the adding of a base offset or
> some extra bits to the ID -- because not all MSIs to the GIC will
> necessarily pass through the IOMMU.  It's also possible that we might
> see ID squashing or folding in some systems.

It can easily be argued that if the algorithm used to remap the ID
varies, the compatibility of the device changes. Therefore I would
expect any variant of the GICv3 that deviates from the "standard"
mapping (if there is such a thing) to have its own compatible string.

At that point there are two possibilities: a) handle the remapping in
code hooked into the driver via matching of the compatible string or
b) specifying a different specifier for each of these and keep the
description in DT. From an implementation point of view, variant b) is
likely going to be very similar to a), though (I'm thinking .of_xlate
type of functions here).

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140604/d7163784/attachment.sig>
