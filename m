From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Apr 2013 20:19:27 +0100
Subject: [PATCH v4 01/15] ARM: multi-cluster PM: secondary kernel entry
 code
In-Reply-To: <1360041732-17936-2-git-send-email-nicolas.pitre@linaro.org>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <1360041732-17936-2-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20130423191927.GA5316@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 12:21:58AM -0500, Nicolas Pitre wrote:
> +#include <asm/mcpm_entry.h>
> +#include <asm/barrier.h>
> +#include <asm/proc-fns.h>
> +#include <asm/cacheflush.h>
> +
> +extern volatile unsigned long mcpm_entry_vectors[MAX_NR_CLUSTERS][MAX_CPUS_PER_CLUSTER];

This should not be volatile.  You should know by now the stance in the
Linux community against using volatile on data declarations.  See
Documentation/volatile-considered-harmful.txt to remind yourself of
the reasoning.

> +
> +void mcpm_set_entry_vector(unsigned cpu, unsigned cluster, void *ptr)
> +{
> +	unsigned long val = ptr ? virt_to_phys(ptr) : 0;
> +	mcpm_entry_vectors[cluster][cpu] = val;
> +	__cpuc_flush_dcache_area((void *)&mcpm_entry_vectors[cluster][cpu], 4);
> +	outer_clean_range(__pa(&mcpm_entry_vectors[cluster][cpu]),
> +			  __pa(&mcpm_entry_vectors[cluster][cpu + 1]));

And really, if the write hasn't been done by the compiler prior to calling
__cpuc_flush_dcache_area() then we're into really bad problems.
