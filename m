From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 22 Mar 2017 16:44:29 +0100
Subject: [RFC PATCH 24/30] iommu: Specify PASID state when unbinding a task
In-Reply-To: <20170227195441.5170-25-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-25-jean-philippe.brucker@arm.com>
Message-ID: <20170322154429.GE7266@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2017 at 07:54:35PM +0000, Jean-Philippe Brucker wrote:
> It is an important distinction because, if the IOMMU driver reassigns a
> PASID while the IOMMU still holds pending PPR targeting that PASID
> internally, the PPR will trigger a fault in the wrong address space.

The IOMMU driver also controls a devices apbility to issue PPR requests
(at least on PCI), so it already knows whether a device has still
requests pending or if it even can create new ones.

Furhter, the IOMMU driver can already wait for all pending faults to be
processed before it shuts down a PASID. So it is not clear to me why the
device driver needs to be involved here.

When the device driver issues a PASID-unbind call the iommu driver
just waits until all pending faults are processed, answers new faults
with INVALID, then switch off the devices capability to issue new
faults, and then release the PASID.



	Joerg
