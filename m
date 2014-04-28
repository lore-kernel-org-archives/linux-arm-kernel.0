From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Apr 2014 12:56:03 +0200
Subject: [PATCH v12 11/31] documentation: iommu: add binding document of
 Exynos System MMU
In-Reply-To: <20140428103919.GF19455@ulmo>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
 <4447051.OnJtcFSqFV@wuerfel> <20140428103919.GF19455@ulmo>
Message-ID: <6544270.ddFBoY6LMm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 April 2014 12:39:20 Thierry Reding wrote:
> On Sun, Apr 27, 2014 at 08:23:06PM +0200, Arnd Bergmann wrote:
> > On Sunday 27 April 2014 13:07:43 Shaik Ameer Basha wrote:
> > > +- mmu-masters: A phandle to device nodes representing the master for which
> > > +               the System MMU can provide a translation. Any additional values
> > > +              after the phandle will be ignored because a System MMU never
> > > +              have two or more masters. "#stream-id-cells" specified in the
> > > +              master's node will be also ignored.
> > > +              If more than one phandle is specified, only the first phandle
> > > +              will be treated.
> > 
> > This seems completely backwards: Why would you list the masters for an IOMMU
> > in the IOMMU node?
> > 
> > The master should have a standard property pointing to the IOMMU instead.
> > 
> > We don't have a generic binding for IOMMUs yet it seems, but the time is
> > overdue to make one.
> > 
> > Consider this NAKed until there is a generic binding for IOMMUs that all
> > relevant developers have agreed to.
> 
> I'd like to take this opportunity and revive one of the hibernating
> patch sets that we have for Tegra. The last effort to get things merged
> was back in January I think. I haven't bothered to look up the reference
> since it's probably good to start from scratch anyway.
> 
> The latest version of the binding that was under discussion back then I
> think looked something like this:
> 
> 	device at ... {
> 		iommus = <&iommu [spec]>[, <&other_iommu [other_spec]>...];
> 	};
> 
> And possibly with a iommu-names property to go along with that. The idea
> being that a device can be a master on possibly multiple IOMMUs. Using
> the above it would also be possible to have one device be multiple
> masters on the same IOMMU.

Yes, that seems reasonable. Just one question: How would you represent a
device that has multiple masters, with at least one connected to an IOMMU
and another one connected to memory directly, without going to the IOMMU?

> On Tegra the specifier would be used to encode a memory controller's
> client ID. One discussion point back at the time was to encode the ID as
> a bitmask to allow more than a single master per entry. Another solution
> which I think is a little cleaner and more generic, would be to use one
> entry per master and use a single cell to encode the client ID. Devices
> with multiple clients to the same IOMMU could then use multiple entries
> referencing the same IOMMU.

I'm not completely following here. Are you talking about the generic
binding, or the part that is tegra specific for the specifier?

My first impression is that the generic binding should just allow an
arbitrary specifier with a variable #iommu-cells, and leave the format
up to the IOMMU driver. A lot of drivers probably only support one
master, so they can just set #iommu-cells=<0>, others might require
IDs that do not fit into one cell.

	Arnd
