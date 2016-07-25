From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 25 Jul 2016 14:48:02 +0100
Subject: [PATCH 0/2] arm64: mm: use fully constructed struct pages from
 EFI page tables
In-Reply-To: <1469208745-6693-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1469208745-6693-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <806da4dd-7318-4f40-3fc2-c6696ed7a71e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/07/16 18:32, Ard Biesheuvel wrote:
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

These patches fixes the issue I reported. You can add:

Tested-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
