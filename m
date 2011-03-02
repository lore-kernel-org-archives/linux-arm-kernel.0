From: rabin@rab.in (Rabin Vincent)
Date: Wed, 2 Mar 2011 21:22:03 +0530
Subject: Question about free_pgd_slow ?
In-Reply-To: <79b2dce2.4b84.12e5ae30c01.Coremail.bill_carson@126.com>
References: <79b2dce2.4b84.12e5ae30c01.Coremail.bill_carson@126.com>
Message-ID: <AANLkTi=obVFm=cwDyUCXQvEK3rDYberc9YWRVkv6_qZ=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 25, 2011 at 09:05, rocky <bill_carson@126.com> wrote:
> free_pgd_slow in arch/arm/mm/pgd.c ?free the 4 pages at pgd level,l
> while could I ask a question about why free the page by pointed by pgd
> index 0 ?

Besides the 16k for the pgd, it frees the second level* page table
referenced at index 0 of the pgd.

(* - of course it frees pud+pmd+pte, but on current ARM this folds down
to just the second level page table.)

On ARM, FIRST_USER_ADDRESS is set to PAGE_SIZE because the vectors may
need to be placed at 0x0.  Since the tables for that translation have to
always be active, functions like exit_mmap() will not free the 0th
secondary level page table (see the calls to free_pgtables() there).  So
we free it here when we're freeing the pgd.
