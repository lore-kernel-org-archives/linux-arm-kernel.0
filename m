From: pullip.cho@samsung.com (KyongHo Cho)
Date: Tue, 6 Sep 2011 19:27:59 +0900
Subject: [PATCH 2/2] ARM: Samsung: update/rewrite Samsung SYSMMU (IOMMU)
	driver
In-Reply-To: <1314971786-15140-3-git-send-email-m.szyprowski@samsung.com>
References: <1314971786-15140-1-git-send-email-m.szyprowski@samsung.com>
	<1314971786-15140-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAHQjnONHr-Ao_KLjdRKgVQQUKtOmmoyqFwdkSZCDsE6hx1q-Ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

On Fri, Sep 2, 2011 at 10:56 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> + *
> + * iova must be aligned on a 4kB, 64kB, 1MB and 16MB boundaries, respectively.
> + */

Actually, iova is just needed to be aligned by 4KiB because it is
minimum requirement.
I think IOMMU driver is capable of mapping a group of page frames that
is aligned
by 1MiB with an iova that is aligned by 4KB
if the iova is large enough to map the given page frames.

> +static int s5p_sysmmu_map(struct iommu_domain *domain, unsigned long iova,
> + ? ? ? ? ? ? ? ? ? ? ? ? phys_addr_t paddr, int gfp_order, int prot)
> +{
> + ? ? ? struct s5p_sysmmu_domain *s5p_domain = domain->priv;
> + ? ? ? int flpt_idx = flpt_index(iova);
> + ? ? ? size_t len = 0x1000UL << gfp_order;
> + ? ? ? void *flpt_va, *slpt_va;
> +
> + ? ? ? if (len != SZ_16M && len != SZ_1M && len != SZ_64K && len != SZ_4K) {
> + ? ? ? ? ? ? ? sysmmu_debug(3, "bad order: %d\n", gfp_order);
> + ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? }

Likewise, I think this driver need to support mapping 128KiB aligned,
128KiB physical memory, for example.

Otherwise, it is somewhat restrictive than we expect.

Thank you.

Cho KyongHo.
