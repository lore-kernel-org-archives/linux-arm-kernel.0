From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Dec 2013 11:42:27 -0700
Subject: [PATCHv7 05/12] iommu/core: add ops->{bound,unbind}_driver()
In-Reply-To: <1386835033-4701-6-git-send-email-hdoyu@nvidia.com>
References: <1386835033-4701-1-git-send-email-hdoyu@nvidia.com>
 <1386835033-4701-6-git-send-email-hdoyu@nvidia.com>
Message-ID: <52AF4993.80406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2013 12:57 AM, Hiroshi Doyu wrote:
> ops->{bound,unbind}_driver() functions are called at
> BUS_NOTIFY_{BOUND,UNBIND}_DRIVER respectively.

Some explanation re: why the existing {add,remove}_device hooks aren't
enough would be useful. I didn't really get that from the current commit
description. What actions would an IOMMU driver take in these new
callbacks that could not be taken in {add,remove}_device? Surely the
IOMMU could set up any internal data structures, AS, or page tables,
etc. within add_device, rather than deferring to bound_driver, which
presumably happens after the device's probe(), yet the driver might want
to make the HW do bus-master accesses within probe(), or at least map
stuff into the page table...

> This is necessary to control the device population order. IOMMU master
> devices depend on an IOMMU device instanciation. IOMMU master devices

Is an "IOMMU master device" the device that issues transactions on the
bus, which are affected by the IOMMU? The more common term for this is
"bus master"; "IOMMU master device" sounds too similar to the "IOMMU"
itself.
