From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 25 Jul 2016 18:14:42 +0100
Subject: [PATCH 0/2] arm64: mm: use fully constructed struct pages from
 EFI page tables
In-Reply-To: <1469208745-6693-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1469208745-6693-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160725171442.GF2423@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2016 at 07:32:23PM +0200, Ard Biesheuvel wrote:
> As reported by Sudeep, the EFI memory attributes table handling may crash
> on an uninitialized spinlock in the struct page associated with a UEFI runtime
> translation table page.
> 
> This is caused by a failure to take into account the fact that generic code
> treats such pages differently depending on whether they are associated with
> init_mm or not. The EFI page tables are completely separate from both the
> kernel and the userland mappings, and are completely static during the
> lifetime of the OS, but still, the most robust solution is to simply
> construct these pages fully, so that generic code that compares against
> &init_mm can work safely and correctly.
> 
> Patch #1 is a preparatory patch to drop a reference to late_pgtable_alloc
> from code that no longer needs it.
> 
> Patch #2 renamed late_pgtable_alloc to pgd_table_alloc, and updates it to
> construct the struct page associated with the allocated page.
> 
> Ard Biesheuvel (2):
>   arm64: mm: make create_mapping_late() non-allocating
>   arm64: mm: run pgtable_page_ctor() on non-swapper translation table
>     pages

Patches applied. I'll send them with the 4.8 pull request this week.

Thanks.

-- 
Catalin
