From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 29 Feb 2016 16:45:47 +0100
Subject: [PATCH] iommu: exynos: pointers are nto physical addresses
In-Reply-To: <1456735568-3886545-1-git-send-email-arnd@arndb.de>
References: <1456735568-3886545-1-git-send-email-arnd@arndb.de>
Message-ID: <20160229154547.GA13711@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 09:45:59AM +0100, Arnd Bergmann wrote:
> The exynos iommu driver changed an incorrect cast from pointer
> to 'unsigned int' to an equally incorrect cast to a 'phys_addr_t',
> which results in an obvious compile-time error when phys_addr_t
> is wider than pointers are:
> 
> drivers/iommu/exynos-iommu.c: In function 'alloc_lv2entry':
> drivers/iommu/exynos-iommu.c:918:32: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
> 
> The code does not actually want the physical address (which would
> involve using virt_to_phys()), but just checks the alignment,
> so we can change it to use a cast to uintptr_t instead.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 740a01eee9ad ("iommu/exynos: Add support for v5 SYSMMU")
> ---
> I also see that some incorrect __raw_writel() calls have crept in
> around the same time, which breaks running big-endian kernels when
> this driver is loaded.
> 
> Please fix and that that as well.
> 
>  drivers/iommu/exynos-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks Arnd.
