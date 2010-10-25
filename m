From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Oct 2010 13:15:53 +0200
Subject: [RFC PATCH 06/18] ARM: LPAE: Introduce the 3-level page table
	format definitions
In-Reply-To: <20101025090007.25275.99918.stgit@e102109-lin.cambridge.arm.com>
References: <20101025085812.25275.55757.stgit@e102109-lin.cambridge.arm.com>
	<20101025090007.25275.99918.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <201010251315.53304.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 October 2010, Catalin Marinas wrote:
> +/*
> + * With LPAE, there are 3 levels of page tables. Each level has 512 entries of
> + * 8 bytes each, occupying a 4K page. The first level table covers a range of
> + * 512GB, each entry representing 1GB. Since we are limited to 4GB input
> + * address range, only 4 entries in the PGD are used.
> + *
> + * There are enough spare bits in a page table entry for the kernel specific
> + * state.
> + */
> +#define PTRS_PER_PTE           512
> +#define PTRS_PER_PMD           512
> +#define PTRS_PER_PGD           4

Since the PGD is so extremely small, would it be possible to fold it
into the mm_context_t in order to save an allocation?
Or does the PGD still require page alignment?

Do you also have patches to allow 40-bit virtual space? I suppose we
will need that for KVM support in the future.

	Arnd
