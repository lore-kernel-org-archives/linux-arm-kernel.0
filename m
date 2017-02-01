From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 1 Feb 2017 16:03:54 +0000
Subject: [PATCH v31 04/12] arm64: mm: allow for unmapping part of kernel
 mapping
In-Reply-To: <20170201124630.6016-3-takahiro.akashi@linaro.org>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-3-takahiro.akashi@linaro.org>
Message-ID: <20170201160354.GF4756@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 01, 2017 at 09:46:23PM +0900, AKASHI Takahiro wrote:
> A new function, remove_pgd_mapping(), is added.
> It allows us to unmap a specific portion of kernel mapping later as far as
> the mapping is made using create_pgd_mapping() and unless we try to free
> a sub-set of memory range within a section mapping.

I'm not keen on adding more page table modification code. It was painful
enough to ensure that those worked in all configurations.

Why can't we reuse create_pgd_mapping()? If we pass page_mappings_only,
and use an invalid prot (i.e. 0), what is the problem?

I can see that we wouldn't free/reallocate the pud or pmd entries, but
the "wasted" memory should be small. If anything, I'd argue that it's
preferable to keep that around so that we don't have to allocate memory
when we need to map the crashkernel region.

Is there another problem I'm missing?

> +static bool pgtable_is_cleared(void *pgtable)
> +{
> +	unsigned long *desc, *end;
> +
> +	for (desc = pgtable, end = (unsigned long *)(pgtable + PAGE_SIZE);
> +	     desc < end; desc++)
> +		if (*desc)
> +			return false;
> +
> +	return true;
> +}

If nothing else, we should be using the normal accessors for this, e.g.
{pte,pmd,pud}_none().

As above, I'd very much like to reuse our existing page table routines
if we can.

Thanks,
Mark.
