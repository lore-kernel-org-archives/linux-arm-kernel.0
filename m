From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 10 Jul 2014 11:49:10 +0200
Subject: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140709181048.GX9485@arm.com>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
 <20140709134050.GN9485@arm.com> <20140709142125.GB3262@ulmo>
 <20140709181048.GX9485@arm.com>
Message-ID: <20140710094909.GA21583@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 07:10:48PM +0100, Will Deacon wrote:
> Hi Thierry,
> 
> On Wed, Jul 09, 2014 at 03:21:27PM +0100, Thierry Reding wrote:
> > On Wed, Jul 09, 2014 at 02:40:50PM +0100, Will Deacon wrote:
> > > I would like to move the ARM SMMU driver over to this for 3.18, if possible.
> > > One use-case there is the ability to describe groups of masters behind a
> > > multi-master IOMMU but which must be part of the same domain (i.e. an
> > > iommu_group). This is useful for presenting devices to a guest with a
> > > virtual SMMU, where the physical devices share a stage-2 context.
> > > 
> > > With your binding, does this simply mean determining the set of master IDs
> > > in the group, then describing the complete set for each master?
> > 
> > I'm not sure I properly understand what you're trying to do, but I don't
> > think the binding is designed to cover that. Rather the goal was to
> > describe the IDs belonging to each master, so that an IOMMU can be
> > properly configured.
> 
> This is directly related to that problem, see below.
> 
> > Anything beyond that (e.g. logical grouping of masters) isn't directly
> > within the scope of the binding (it doesn't describe hardware but some
> > policy pertaining to some specific use-case).
> 
> This *is* for hardware. I can use PCI as an example, but this could equally
> apply to other types of bus. If you have a bunch of PCI master devices
> sitting being a non-transparent bridge, they can end up sharing the same
> master device ID (requester ID). This means that there is no way in the
> IOMMU to initialise a translation for one of these devices without also
> affecting the others. We currently have iommu_groups to deal with this, but
> it *is* a property of the hardware and we absolutely need a way to describe
> it. I'm happy to add it later, but we need to think about it now to avoid
> merging something that can't easily be extended.
> 
> For PCI, the topology is probable but even then, we need this information to
> describe the resulting master device ID emitted by the bridge for the
> upstream group. One way to do this with your binding would be to treat all
> of the upstream masters as having the same device ID.

Yes, I think that makes most sense. After all from the IOMMU's point of
view requests from all devices behind the bridge will originate from the
same ID.

So technically it's not really correct to encode the master ID within
each of the devices, but rather they should be inheriting the ID from
the non-transparent bridge.

> With virtualisation, we may want to assign a group of devices to a guest but
> without emulating the bridge. This would need something the device-tree to
> describe that they are grouped together.

But that's also a software decision, isn't it? Virtualization doesn't
have anything to do with the hardware description. Or am I missing
something? Of course I guess you could generate a DTB for the guest and
group device together, in which case you're pretty much free to do what
you want since you're essentially defining your own hardware.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140710/7b56bc1b/attachment.sig>
