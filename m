From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Sep 2012 11:14:20 +0100
Subject: [PATCH v4 1/2] ARM: new cache maintenance api for iommu
In-Reply-To: <CADysL2bGP_FKW4dnxM4zbziOPfrbAemRazZYd_mS9i++bZGcqQ@mail.gmail.com>
References: <CADysL2bGP_FKW4dnxM4zbziOPfrbAemRazZYd_mS9i++bZGcqQ@mail.gmail.com>
Message-ID: <20120908101420.GA28448@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 10:50:17AM +0530, Gupta, Ramesh wrote:
> + *	flush_iommu_mem(start, end)
> + *
> + *		Clean and invalidate the specified virtual address range.
> + *		This is	to support the non coherent iommu drivers.
> + *		The iommu driver need to call this api with the page
> + *		table memory address range to ensure the data held in
> + *		the cache is visible to the slave processor MMU.
> + *		- start  - virtual start address
> + *		- end    - virtual end address

I think:
	iommu_flush_range(start, end)
or
	iommu_flush_area(start, size)
		Perform CPU specific cache operations are required to
		ensure that the IOMMU page table mappings covering the
		specified block of memory are visiable to the IOMMU.

Notice that it's defined by purpose, not by implementation.  Also notice
the distinction between _range taking two addresses, and _area taking
a start plus size.

Also notice that it is defined just for IOMMU page tables, not for general
data for other processors.

Note that iommu_flush_area is safer if your virt_to_phys() are non-linear.
