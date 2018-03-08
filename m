From: mingo@kernel.org (Ingo Molnar)
Date: Thu, 8 Mar 2018 09:08:47 +0100
Subject: [PATCH 1/2] mm/vmalloc: Add interfaces to free unused page table
In-Reply-To: <20180307183227.17983-2-toshi.kani@hpe.com>
References: <20180307183227.17983-1-toshi.kani@hpe.com>
 <20180307183227.17983-2-toshi.kani@hpe.com>
Message-ID: <20180308080847.dvwd3w6wuhwsg3qo@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Toshi Kani <toshi.kani@hpe.com> wrote:

> On architectures with CONFIG_HAVE_ARCH_HUGE_VMAP set, ioremap()
> may create pud/pmd mappings.  Kernel panic was observed on arm64
> systems with Cortex-A75 in the following steps as described by
> Hanjun Guo.
> 
> 1. ioremap a 4K size, valid page table will build,
> 2. iounmap it, pte0 will set to 0;
> 3. ioremap the same address with 2M size, pgd/pmd is unchanged,
>    then set the a new value for pmd;
> 4. pte0 is leaked;
> 5. CPU may meet exception because the old pmd is still in TLB,
>    which will lead to kernel panic.
> 
> This panic is not reproducible on x86.  INVLPG, called from iounmap,
> purges all levels of entries associated with purged address on x86.

Where does x86 iounmap() do that?

> x86 still has memory leak.
> Add two interfaces, pud_free_pmd_page() and pmd_free_pte_page(),
> which clear a given pud/pmd entry and free up a page for the lower
> level entries.
> 
> This patch implements their stub functions on x86 and arm64, which
> work as workaround.

At minimum the ordering of the patches is very confusing: why don't you introduce 
the new methods in patch #1, and then use them in patch #2?

Also please double check the coding style of your patches, there's a number of 
obvious problems of outright bad patterns and also cases where you clearly don't 
try to follow the (correct) style of existing code.

Thanks,

	Ingo
