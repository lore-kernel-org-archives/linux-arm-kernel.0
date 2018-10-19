From: anshuman.khandual@arm.com (Anshuman Khandual)
Date: Fri, 19 Oct 2018 08:02:26 +0530
Subject: [PATCH V2 2/5] mm/hugetlb: Distinguish between migratability and
 movability
In-Reply-To: <20181019015931.GA18973@hori1.linux.bs1.fc.nec.co.jp>
References: <1539316799-6064-1-git-send-email-anshuman.khandual@arm.com>
 <1539316799-6064-3-git-send-email-anshuman.khandual@arm.com>
 <20181019015931.GA18973@hori1.linux.bs1.fc.nec.co.jp>
Message-ID: <e7a3d5d8-dc65-72fc-5764-010af02d1517@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/19/2018 07:29 AM, Naoya Horiguchi wrote:
> On Fri, Oct 12, 2018 at 09:29:56AM +0530, Anshuman Khandual wrote:
>> During huge page allocation it's migratability is checked to determine if
>> it should be placed under movable zones with GFP_HIGHUSER_MOVABLE. But the
>> movability aspect of the huge page could depend on other factors than just
>> migratability. Movability in itself is a distinct property which should not
>> be tied with migratability alone.
>>
>> This differentiates these two and implements an enhanced movability check
>> which also considers huge page size to determine if it is feasible to be
>> placed under a movable zone. At present it just checks for gigantic pages
>> but going forward it can incorporate other enhanced checks.
> 
> (nitpicking...)
> The following code just checks hugepage_migration_supported(), so maybe
> s/Movability/Migratability/ is expected in the comment?
> 
>   static int unmap_and_move_huge_page(...)
>   {
>           ...
>           /*
>            * Movability of hugepages depends on architectures and hugepage size.
>            * This check is necessary because some callers of hugepage migration
>            * like soft offline and memory hotremove don't walk through page
>            * tables or check whether the hugepage is pmd-based or not before
>            * kicking migration.
>            */
>           if (!hugepage_migration_supported(page_hstate(hpage))) {
> 
Sure, will update this patch only unless other changes are suggested.
