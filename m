From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 5 Sep 2011 21:21:39 +0300
Subject: [PATCH 2/2] ARM: Samsung: update/rewrite Samsung SYSMMU (IOMMU)
	driver
In-Reply-To: <1314971786-15140-3-git-send-email-m.szyprowski@samsung.com>
References: <1314971786-15140-1-git-send-email-m.szyprowski@samsung.com>
	<1314971786-15140-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CADMYwHyeP-1Rd1GxJx-z7XjrThK_H_bPB-_FZMb-_Y1VGeA4Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Fri, Sep 2, 2011 at 4:56 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
...
> ?arch/arm/plat-s5p/Kconfig ? ? ? ? ? ? ? ? ? ? ?| ? 21 +-
> ?arch/arm/plat-s5p/include/plat/sysmmu.h ? ? ? ?| ?119 ++--
> ?arch/arm/plat-s5p/sysmmu.c ? ? ? ? ? ? ? ? ? ? | ?855 ++++++++++++++++++------

Please move the driver to drivers/iommu/, where all other IOMMU API users sit.

...
> diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
...
> +config IOMMU_API
> + ? ? ? bool

You don't need this anymore: this is already part of drivers/iommu/Kconfig.

> +static int s5p_sysmmu_unmap(struct iommu_domain *domain, unsigned long iova,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? int gfp_order)
> ?{
...
> + ? ? ? if (SZ_1M == len) {
> + ? ? ? ? ? ? ? if (!page_1m(flpt_va))
> + ? ? ? ? ? ? ? ? ? ? ? bug_unmapping_prohibited(iova, len);
..
> + ? ? ? } else if (SZ_16M == len) {
> + ? ? ? ? ? ? ? int i;
> + ? ? ? ? ? ? ? /* first loop to verify it actually is 16M mapping */
> + ? ? ? ? ? ? ? for (i = 0; i < 16; ++i)
> + ? ? ? ? ? ? ? ? ? ? ? if (!page_16m(flpt_va + 4 * i))
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? bug_unmapping_prohibited(iova, len);

Actually these are not bugs; iommu drivers need to unmap the page they
find in iova, and return the page size that was actually unmapped: you
may well receive a page size that is different from the page that maps
iova.

...
> +
> + ? ? ? return 0;

On success, need to return the size (in page order) of the page that
was unmapped.

Regards,
Ohad.
