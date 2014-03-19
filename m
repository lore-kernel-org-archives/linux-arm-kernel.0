From: grundler@chromium.org (Grant Grundler)
Date: Tue, 18 Mar 2014 18:33:20 -0700
Subject: [PATCH v11 24/27] iommu/exynos: use exynos-iommu specific typedef
In-Reply-To: <20140314141302.393cfdf96dd7b82eee3f700e@samsung.com>
References: <20140314141302.393cfdf96dd7b82eee3f700e@samsung.com>
Message-ID: <CANEJEGu=yDfYi-gH7W7h7up2gd7MxBOg9bz4konLoe-UGf4RYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 10:13 PM, Cho KyongHo <pullip.cho@samsung.com> wrote:
> This commit introduces sysmmu_pte_t for page table entries and
> sysmmu_iova_t vor I/O virtual address that is manipulated by
> exynos-iommu driver. The purpose of the typedef is to remove
> dependencies to the driver code from the change of CPU architecture
> from 32 bit to 64 bit.

hi Cho,
I noticed this before but understood this code was only compiled for
ILP-32 programming model. I'm assuming that is going to change in the
not-to-distant future. Good. :)

>
> Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> ---
>  drivers/iommu/exynos-iommu.c |  103 ++++++++++++++++++++++--------------------
>  1 file changed, 54 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index e375501..6e716cc 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -56,19 +56,19 @@
>  #define lv2ent_large(pent) ((*(pent) & 3) == 1)
>
>  #define section_phys(sent) (*(sent) & SECT_MASK)
> -#define section_offs(iova) ((iova) & 0xFFFFF)
> +#define section_offs(iova) ((sysmmu_iova_t)(iova) & 0xFFFFF)

The cast will mask abuses of iova. Define section_offs as a static
function and GCC can type check iova parameter to make sure it's a
sysmmu_iova_t.
Thoughts?

I was thinking "((iova) & (sysmmu_iova_t) 0XFFFFF)" might do what you
want but it doesn't warn on abuse that I tried. I believe GCC knows
the upper bits are being ignored.

cheers,
grant
