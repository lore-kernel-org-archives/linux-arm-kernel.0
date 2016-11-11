From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 11 Nov 2016 16:17:37 +0000
Subject: [PATCH v7 04/16] drivers: iommu: make of_iommu_set/get_ops() DT
 agnostic
In-Reply-To: <20161111152248.GS2078@8bytes.org>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
 <20161109141948.19244-5-lorenzo.pieralisi@arm.com>
 <20161111152248.GS2078@8bytes.org>
Message-ID: <552e674a-f434-f08f-8e16-a94544ce8e6e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/16 15:22, Joerg Roedel wrote:
> On Wed, Nov 09, 2016 at 02:19:36PM +0000, Lorenzo Pieralisi wrote:
>> +struct iommu_fwentry {
>> +	struct list_head list;
>> +	struct fwnode_handle *fwnode;
>> +	const struct iommu_ops *ops;
>> +};
> 
> Is there a reason the iommu_ops need to be stored there? Currently it
> seems that the ops are only needed to get the of_xlate fn-ptr later. And
> the place where it is called the iommu-ops should also be available
> through pdev->dev->bus->iommu_ops.

In the original of_iommu_configure design, the thought was that an ops
structure could be IOMMU-instance-specific (hence the later-removed
"priv" member), so I suppose right now it is mostly a hangover from
that. However, it's also what we initialise a device's fwspec with, so
becomes important again if we're ever going to get past the limitations
of buses-which-are-not-actually-buses[1].

Robin.

[1]:http://www.mail-archive.com/iommu at lists.linux-foundation.org/msg14576.html
