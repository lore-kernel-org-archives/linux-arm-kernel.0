From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 28 Apr 2014 13:18:03 +0200
Subject: [PATCH v12 11/31] documentation: iommu: add binding document of
 Exynos System MMU
In-Reply-To: <6544270.ddFBoY6LMm@wuerfel>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
 <4447051.OnJtcFSqFV@wuerfel> <20140428103919.GF19455@ulmo>
 <6544270.ddFBoY6LMm@wuerfel>
Message-ID: <20140428111802.GI19455@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 12:56:03PM +0200, Arnd Bergmann wrote:
> On Monday 28 April 2014 12:39:20 Thierry Reding wrote:
> > On Sun, Apr 27, 2014 at 08:23:06PM +0200, Arnd Bergmann wrote:
> > > On Sunday 27 April 2014 13:07:43 Shaik Ameer Basha wrote:
> > > > +- mmu-masters: A phandle to device nodes representing the master for which
> > > > +               the System MMU can provide a translation. Any additional values
> > > > +              after the phandle will be ignored because a System MMU never
> > > > +              have two or more masters. "#stream-id-cells" specified in the
> > > > +              master's node will be also ignored.
> > > > +              If more than one phandle is specified, only the first phandle
> > > > +              will be treated.
> > > 
> > > This seems completely backwards: Why would you list the masters for an IOMMU
> > > in the IOMMU node?
> > > 
> > > The master should have a standard property pointing to the IOMMU instead.
> > > 
> > > We don't have a generic binding for IOMMUs yet it seems, but the time is
> > > overdue to make one.
> > > 
> > > Consider this NAKed until there is a generic binding for IOMMUs that all
> > > relevant developers have agreed to.
> > 
> > I'd like to take this opportunity and revive one of the hibernating
> > patch sets that we have for Tegra. The last effort to get things merged
> > was back in January I think. I haven't bothered to look up the reference
> > since it's probably good to start from scratch anyway.
> > 
> > The latest version of the binding that was under discussion back then I
> > think looked something like this:
> > 
> > 	device at ... {
> > 		iommus = <&iommu [spec]>[, <&other_iommu [other_spec]>...];
> > 	};
> > 
> > And possibly with a iommu-names property to go along with that. The idea
> > being that a device can be a master on possibly multiple IOMMUs. Using
> > the above it would also be possible to have one device be multiple
> > masters on the same IOMMU.
> 
> Yes, that seems reasonable. Just one question: How would you represent a
> device that has multiple masters, with at least one connected to an IOMMU
> and another one connected to memory directly, without going to the IOMMU?

Heh, I don't think I've ever thought about that use-case. I guess I was
always assuming that in the absence of an IOMMU the device would simply
access memory directly. From what I can tell that's how Tegra works at
least. If the IOMMU is not enabled for a given client, that client will
access physical memory untranslated.

I suppose if that really must be represented then a global dummy IOMMU
could be introduced to help with these cases.

> > On Tegra the specifier would be used to encode a memory controller's
> > client ID. One discussion point back at the time was to encode the ID as
> > a bitmask to allow more than a single master per entry. Another solution
> > which I think is a little cleaner and more generic, would be to use one
> > entry per master and use a single cell to encode the client ID. Devices
> > with multiple clients to the same IOMMU could then use multiple entries
> > referencing the same IOMMU.
> 
> I'm not completely following here. Are you talking about the generic
> binding, or the part that is tegra specific for the specifier?
> 
> My first impression is that the generic binding should just allow an
> arbitrary specifier with a variable #iommu-cells, and leave the format
> up to the IOMMU driver.

Yes, I was getting ahead of myself. The idea was to have #iommu-cells
and allow the specifier to be IOMMU-specific. On Tegra that would
translate to the memory controller client ID, on other devices I suspect
something similar might exist, but for the generic binding it should be
completely opaque and hence irrelevant.

Really just like any of the other bindings that have foos and #foo-cells
properties.

> A lot of drivers probably only support one
> master, so they can just set #iommu-cells=<0>, others might require
> IDs that do not fit into one cell.

You mean "#iommu-cells = <1>" for devices that only require one master?
There still has to be one cell to specify which master. Unless perhaps
if they can be arbitrarily assigned. I guess even if there's a fixed
mapping that applies to one SoC generation, it might be good to still
employ a specifier and have the mapping in DT for flexibility.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/ed7a533c/attachment-0001.sig>
