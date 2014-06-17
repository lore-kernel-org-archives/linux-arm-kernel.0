From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Jun 2014 13:18:11 +0100
Subject: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140617115829.GB18816@ulmo>
References: <1400877395-4235-1-git-send-email-thierry.reding@gmail.com>
 <538757B6.4010109@wwwdotorg.org> <20140530073006.GA24748@ulmo>
 <20140530112728.GB3949@e103592.cambridge.arm.com>
 <20140604211237.GC18710@mithrandir>
 <20140616125704.GE16758@arm.com> <20140617115829.GB18816@ulmo>
Message-ID: <20140617121811.GG13808@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 12:58:30PM +0100, Thierry Reding wrote:
> On Mon, Jun 16, 2014 at 01:57:04PM +0100, Will Deacon wrote:
> > On Wed, Jun 04, 2014 at 10:12:38PM +0100, Thierry Reding wrote:
> > > It can easily be argued that if the algorithm used to remap the ID
> > > varies, the compatibility of the device changes. Therefore I would
> > > expect any variant of the GICv3 that deviates from the "standard"
> > > mapping (if there is such a thing) to have its own compatible string.
> > 
> > There is no standard mapping; it's a property defined at system integration
> > time. I fully expect different SoCs to do different things here.
> 
> My point was that the mapping itself seems to be fundamental enough to
> make devices with different mappings "incompatible". Therefore I think
> this could probably be handled by using different compatible values,
> something along the lines of this:
> 
> 	compatible = "vendor,soc-gicv3", "arm,gicv3";
> 
> Then the mapping can be described in code, which should be a whole lot
> easier and more flexible than a more or less generic notation in device
> tree.

I don't think that scales well beyond a handful of unique mappings, and I
really anticipate everybody doing something different based on their
integration constraints.

You'd very quickly end up with sets of tables for each SoC, describing the
topology and associated IDs in the kernel source, which feels like a giant
step backwards from where we are today with device tree.

If, for example, the GIC architecture prescribed a fixed set of Device IDs
and an algorithm for converting from Stream IDs then your approach may have
some merits, but that's not where we are today (and I also don't think it's
practical to try and enforce such system-wide properties into an interrupt
controller architecture).

Will
