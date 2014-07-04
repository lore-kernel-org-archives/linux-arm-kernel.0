From: will.deacon@arm.com (Will Deacon)
Date: Fri, 4 Jul 2014 09:13:31 +0100
Subject: [PATCH 2/5] iommu/arm-smmu: add support for PCI master devices
In-Reply-To: <3b9f2103f5c44958a74f1e594a58d58a@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1404125530-17984-1-git-send-email-will.deacon@arm.com>
 <1404125530-17984-3-git-send-email-will.deacon@arm.com>
 <a9de518782874b5c8ddd366e6617b8de@BL2PR03MB468.namprd03.prod.outlook.com>
 <20140703144341.GC14305@arm.com>
 <3b9f2103f5c44958a74f1e594a58d58a@BL2PR03MB468.namprd03.prod.outlook.com>
Message-ID: <20140704081331.GB23379@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 08:41:53AM +0100, Varun Sethi wrote:
> Hi Will,

Hey Varun,

> > Once Thierry's generic IOMMU binding is sorted, we should look at adding
> > support for the Stream ID description. Have you looked at that at all?
> > 
> Yes, I have looked at the bindings. Would we need to represent the stream
> ids for PCI devices in the device tree? Why do we want to depend on the
> firmware to map the requestor id to the stream id? It can be handled using
> the APIs proposed by Alex Williamson. This is similar to IOMMU group
> determination, which is handled by the IOMMU driver.

Well, there could easily be a fixed mapping from the ID at the host controller
and the ID seem by the SMMU (e.g. two host controllers sharing an SMMU?). I
don't think walking the PCI buses can help you there.

The way I was thinking to handle this is that we express SID = RID +
offset. In the device-tree, we can then describe a range of RIDs on the host
controller, a single offset, and we get back a range of SIDs.

In the worst case scenario, each RID maps to a totally random SID, so then
you have a huge table describing the mapping. I *think* this is actually
unlikely, and if we ever see such a device we can either have a large
mapping or put it into C code for that specific SoC (if it's really huge).

FWIW: I believe that the ACPI folks are thinking along similar lines.

Will
