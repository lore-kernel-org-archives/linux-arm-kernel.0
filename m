From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 17 Nov 2017 11:39:25 +0000
Subject: [RFCv2 PATCH 31/36] iommu/arm-smmu-v3: Add support for PCI ATS
In-Reply-To: <BLUPR0201MB1505BC86D3838D13F38665E7A52F0@BLUPR0201MB1505.namprd02.prod.outlook.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-32-jean-philippe.brucker@arm.com>
 <BLUPR0201MB150565029F9260A528739ACBA52E0@BLUPR0201MB1505.namprd02.prod.outlook.com>
 <673fda01-2ae0-87e4-637e-fe27096b6be0@arm.com>
 <BLUPR0201MB1505BC86D3838D13F38665E7A52F0@BLUPR0201MB1505.namprd02.prod.outlook.com>
Message-ID: <9da446e9-cf84-61ce-f3f5-32386387bc9f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/11/17 06:11, Bharat Kumar Gogada wrote:
[...]
> Thanks Jean, I see that currently vfio_group_fops_open does not allow multiple instances. 
> If a device supports multiple PASID there might be different applications running parallel. 
> So why is multiple instances restricted ?

You can't have multiple processes owning the same PCI device, it's
unmanageable.

For using multiple PASIDs, my idea was that the userspace driver ("the
server"), that owns the device, would have a way to partition it into
smaller frames. It forks to create "clients" and assigns a PASID to each
of them (by issuing VFIO_BIND(client_pid) -> pasid, then writing the PASID
into a privileged MMIO frame that defines the partition properties). Each
client accesses an unprivileged MMIO frame to use a device partition (or
sends commands to the server via IPC), and can perform DMA on its own
virtual memory.

This is complete speculation of course, we have very little information on
how PASID-capable devices will be designed, so I'm trying to imagine
likely scenarios.

Thanks,
Jean
