From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 Jan 2013 15:34:18 +0000
Subject: [PATCH 01/16] ARM: b.L: secondary kernel entry code
In-Reply-To: <1357777251-13541-2-git-send-email-nicolas.pitre@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-2-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <CAHkRjk65PEVDS6vi=07g_hef8yXOR+mTYV_Nchu1fAuLnOJLOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nico,

On 10 January 2013 00:20, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> --- /dev/null
> +++ b/arch/arm/common/bL_entry.c
...
> +extern volatile unsigned long bL_entry_vectors[BL_NR_CLUSTERS][BL_CPUS_PER_CLUSTER];

IMHO, we should keep this array linear and ignore the cluster grouping
at this stage. This information could be added to latter patches that
actually need to know about the b.L topology. This would also imply
that we treat the MPIDR just as an ID without digging into its bit
layout. But I haven't looked at the other patches yet to see how this
would fit.

> +void bL_set_entry_vector(unsigned cpu, unsigned cluster, void *ptr)
> +{
> +       unsigned long val = ptr ? virt_to_phys(ptr) : 0;
> +       bL_entry_vectors[cluster][cpu] = val;
> +       smp_wmb();
> +       __cpuc_flush_dcache_area((void *)&bL_entry_vectors[cluster][cpu], 4);
> +       outer_clean_range(__pa(&bL_entry_vectors[cluster][cpu]),
> +                         __pa(&bL_entry_vectors[cluster][cpu + 1]));

Why are you using the smp_wmb() here? We don't need any barrier since
data cache ops by MVA are automatically ordered in relation to stores
to the same MVA (as long as the MVA is in Normal Cacheable memory).

> --- /dev/null
> +++ b/arch/arm/common/bL_head.S
...
> +ENTRY(bL_entry_point)
> +
> + THUMB(        adr     r12, BSYM(1f)   )
> + THUMB(        bx      r12             )
> + THUMB(        .thumb                  )
> +1:
> +       mrc     p15, 0, r0, c0, c0, 5

Minor thing, maybe a comment for this line like @ MPIDR.

-- 
Catalin
