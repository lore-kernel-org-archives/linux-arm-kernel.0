From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Thu, 1 Sep 2011 11:35:18 +0200
Subject: [PATCH] iommu: omap_iovmm: support non page-aligned buffers in
	iommu_vmap
In-Reply-To: <201108311856.26969.laurent.pinchart@ideasonboard.com>
References: <1314646569-16738-1-git-send-email-ohad@wizery.com>
	<CAK=Wgbb06Z0_8OKFf6MKjYe+SJN16Mh9PA6z_T+cpSpB9EKHFw@mail.gmail.com>
	<20110831130642.GQ12940@amd.com>
	<201108311856.26969.laurent.pinchart@ideasonboard.com>
Message-ID: <20110901093518.GC15287@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2011 at 12:56:26PM -0400, Laurent Pinchart wrote:
> True, but if we implement address rounding transparently in the IOMMU layer 
> Ohad's concern can be valid, depending on whether the device is trusted. If we 
> decide to push address rounding to the drivers that decision can be made on a 
> per-device basis. However, drivers are usually not aware of what granularity 
> the IOMMU works on, so that wouldn't be straightforward and clean.

Drivers usually just use the DMA-API, so they can not assume at all that
any protection happens. The problem also can't be really solved without
changing/breaking the DMA-API. It is defined to work on byte granularity
while the hardware only works with pages.

The only way to work around this it to implement the driver in a way so
that they only map page-aligned buffers where the size is also a
multiple of a page-size.

In this case you can assume the page-size you are working on because you
already assume in the driver that an iommu is in use.

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
