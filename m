From: bill_carson@126.com (rocky)
Date: Sat, 5 Mar 2011 18:19:27 +0800 (CST)
Subject: Question about free_pgd_slow ?
In-Reply-To: <AANLkTi=obVFm=cwDyUCXQvEK3rDYberc9YWRVkv6_qZ=@mail.gmail.com>
References: <AANLkTi=obVFm=cwDyUCXQvEK3rDYberc9YWRVkv6_qZ=@mail.gmail.com>
	<79b2dce2.4b84.12e5ae30c01.Coremail.bill_carson@126.com>
Message-ID: <14bf5cc1.490f.12e858767f5.Coremail.bill_carson@126.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


At 2011-03-02 23:52:03?"Rabin Vincent" <rabin@rab.in> wrote:>On Fri, Feb 25, 2011 at 09:05, rocky <bill_carson@126.com> wrote:>> free_pgd_slow in arch/arm/mm/pgd.c  free the 4 pages at pgd level,l>> while could I ask a question about why free the page by pointed by pgd>> index 0 ?>>Besides the 16k for the pgd, it frees the second level* page table>referenced at index 0 of the pgd.>>(* - of course it frees pud+pmd+pte, but on current ARM this folds down>to just the second level page table.)>>On ARM, FIRST_USER_ADDRESS is set to PAGE_SIZE because the vectors may>need to be placed at 0x0.  Since the tables for that translation have to>always be active, functions like exit_mmap() will not free the 0th>secondary level page table (see the calls to free_pgtables() there).  So>we free it here when we're freeing the pgd.
Thanks Rabin
I dig the code more deeper,
exit_mmap called free_pgtables by setting floor with FIRST_USER_ADDRESS, 
then in free_pgd_range , vma->start first aligned with PMD_MASK before compared with floor, 
PMD_MASK for arm is 2M aligned ,so that means 0~0x200000 virtual address mapping is free in
free_pgd_slow.

But I still dont get it, 
why is that  low vector mapping must always be active even though the task is going to exit?

rocky



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110305/374de67a/attachment-0001.html>
