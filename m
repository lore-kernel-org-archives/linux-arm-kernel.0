From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 02 Sep 2014 09:56:12 +0300
Subject: [RFC PATCH 1/7] iommu: provide early initialisation hook for
 IOMMU drivers
In-Reply-To: <20140901075216.GA24430@ulmo>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
 <1409327670-3495-2-git-send-email-will.deacon@arm.com>
 <20140901075216.GA24430@ulmo>
Message-ID: <5261873.R44Dyo67Nf@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 September 2014 09:52:19 Thierry Reding wrote:
> On Fri, Aug 29, 2014 at 04:54:24PM +0100, Will Deacon wrote:
> > IOMMU drivers must be initialised before any of their upstream devices,
> > otherwise the relevant iommu_ops won't be configured for the bus in
> > question. To solve this, a number of IOMMU drivers use initcalls to
> > initialise the driver before anything has a chance to be probed.
> > 
> > Whilst this solves the immediate problem, it leaves the job of probing
> > the IOMMU completely separate from the iommu_ops to configure the IOMMU,
> > which are called on a per-bus basis and require the driver to figure out
> > exactly which instance of the IOMMU is being requested. In particular,
> > the add_device callback simply passes a struct device to the driver,
> > which then has to parse firmware tables or probe buses to identify the
> > relevant IOMMU instance.
> > 
> > This patch takes the first step in addressing this problem by adding an
> > early initialisation pass for IOMMU drivers, giving them the ability to
> > set some per-instance data on their of_node. This data can then be
> > passed back to a new add_device function (added in a later patch) to
> > identify the IOMMU instance in question.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> > 
> >  drivers/iommu/of_iommu.c          | 14 ++++++++++++++
> >  include/asm-generic/vmlinux.lds.h |  2 ++
> >  include/linux/of_iommu.h          | 21 +++++++++++++++++++++
> >  3 files changed, 37 insertions(+)
> 
> I don't think this is the right direction. We've been preaching that
> using initcall ordering is a bad thing and people should be using
> deferred probe instead. Now we have a bunch of these OF tables that do
> the exact opposite. Note that these are nothing more than a variant of
> initcalls that get called at platform-specific points in time.

My idea to solve this problem was to defer probing of the bus master device 
from the add_device IOMMU operation. This obviously won't work with add_device 
called from the BUS_NOTIFY_ADD_DEVICE notifier, which led me to naively wonder 
whether we couldn't call the add_device operation from the 
BUS_NOTIFY_BIND_DRIVER notifier instead.

> There are also ongoing discussions about how to change the device probe
> order to use dependencies (such as phandles from device tree) to prevent
> excessive deferred probing. With that in place this would be solved in a
> much more generic way.

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140902/74614f63/attachment.sig>
