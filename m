From: gking@nvidia.com (Gary King)
Date: Mon,  2 Aug 2010 19:42:45 -0700
Subject: [PATCH 0/4] Add support for page alloc w/ custom cache attributes
Message-ID: <1280803369-13362-1-git-send-email-gking@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is an attempt to address the recent discussion regarding
dual-mapping of kernel pages with different cache attributes that
was spawned by the VCM patch series (and other IOMMU / SMMU patches),
to allow memory allocations for the SMMU to use any kernel-managed
page.

This adds 2 new APIs (enabled with the ARM_ATTRIB_ALLOCATOR config)
to allocate and free pages with caller-specified cache attributes.
When this config is enabled, the kernel's lowmem mapping is mapped
using PTEs rather than sections, so that the cache attributes for the
kernel's mapping can be updated when the page is allocated to match
the caller's request (and returned to pgprot_kernel when freed).

Additionally, this patch stack adds an additional memory type (inner-
writeback, outer-non-cacheable) that we (NVIDIA) have found to be
extremely beneficial in optimizing the drawing that Android's window
system (among others) uses.

I'm sending this out for comments on the overall direction. The APIs
are similar to functions that we implemented in the Tegra system MMU
driver.

- Gary
