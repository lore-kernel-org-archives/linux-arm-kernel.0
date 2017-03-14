From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 14 Mar 2017 16:20:26 +0000
Subject: [PATCH V2] arm64: hwpoison: add VM_FAULT_HWPOISON[_LARGE] handling
In-Reply-To: <b2df589b-3d8d-8a25-d3ba-2b55f3791475@codeaurora.org> (Tyler
 Baicar's message of "Fri, 10 Mar 2017 11:06:04 -0700")
References: <1487720205-14594-1-git-send-email-tbaicar@codeaurora.org>
 <87wpc7o7mo.fsf@e105922-lin.cambridge.arm.com>
 <874lz4oo80.fsf@e105922-lin.cambridge.arm.com>
 <fae5fa32-687b-4ebd-2d0c-b9df5837ba89@codeaurora.org>
 <87efy6mjgj.fsf@e105922-lin.cambridge.arm.com>
 <b2df589b-3d8d-8a25-d3ba-2b55f3791475@codeaurora.org>
Message-ID: <87shmfkeyd.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

"Baicar, Tyler" <tbaicar@codeaurora.org> writes:

> Hello Punit,
>
> I ran the test with and without the kernel patch you're suggesting
> below. I do not see the "bad pmd ..." print that you are seeing in
> either case.

Thanks for trying out the patch. It's important to understand why we are
seeing the difference in behaviour.

Looking at the code path, you should be hitting the "bad pmd" pr_err in
dmesg. Any chance either hugepages or the memory failure configs weren't
enabled in the test kernel?

The test script (run_hugepage.sh) isn't particularly robust. It carries
on executing even though some of the pre-conditions are not satisfied. I
had seen the script continue even though some of the dependencies were
missing from "bin" directory in the mce-test repo (Fixed by running
"make install" in tools/page-types".

Also, I reduced the console output and dmesg noise by executing only the
failing test in run_hugepage.sh -

"exec_testcase head late_touch file fork_shared killed".

Can you try re-running with the other tests commented out?

> All the tests are not passing for me though, it runs 42
> test cases and 14 show up as failed for some reason.

I see similar behaviour. I think the failures are due to timing
sensitivity when synchronising multi-process test cases - I saw a
comment implying this somewhere but can't seem to find it now.

Thanks,
Punit

>
> Thanks,
>
> Tyler
>
>
> On 3/9/2017 10:46 AM, Punit Agrawal wrote:
>> [ +steve for arm64 mm and hugepages chops ]
>>
>> "Baicar, Tyler" <tbaicar@codeaurora.org> writes:
>>
>>> On 3/7/2017 12:56 PM, Punit Agrawal wrote:
>>>> Punit Agrawal <punit.agrawal@arm.com> writes:
>>>>
>>>> [...]
>>>>
>>>>> The code looks good but I ran into some failures while running the
>>>>> hugepages hwpoison tests from mce-tests suite[0]. I get a bad pmd error
>>>>> in dmesg -
>>>>>
>>>>> [  344.165544] mm/pgtable-generic.c:33: bad pmd 000000083af00074.
>>>>>
>>>>> I suspect that this is due to the huge pte accessors not correctly
>>>>> dealing with poisoned entries (which are represented as swap entries).
>>>> I think I've got to the bottom of the issue - the problem is due to
>>>> huge_pte_at() returning NULL for poisoned pmd entries (which in turn is
>>>> due to pmd_present() not handling poisoned pmd entries correctly)
>>>>
>>>> The following is the call chain for the failure case.
>>>>
>>>> do_munmap
>>>>     unmap_region
>>>>       unmap_vmas
>>>>         unmap_single_vma
>>>>           __unmap_hugepage_range_final    # The test case uses hugepages
>>>>             __unmap_hugepage_range
>>>>               huge_pte_offset             # Returns NULL for a poisoned pmd
>>>>
>>>> Reverting 5bb1cc0ff9a6 ("arm64: Ensure pmd_present() returns false after
>>>> pmd_mknotpresent()") fixes the problem for me but I don't think that is
>>>> the right fix.
>>>>
>>>> While I work on a proper fix, it would be great if you can confirm that
>>>> reverting 5bb1cc0ff9a6 makes the problem go away at your end.
>>> Thanks Punit! I haven't got a chance to do this yet, but I will let
>>> you know once I get it tested :)
>> This time with a patch. Please test this instead.
>>
>> After a lot of head scratching, I've bit the bullet and added a check to
>> return the poisoned entry from huge_pte_offset(). What with having to
>> deal with contiguous hugepages et al., there just doesn't seem to be any
>> leeway in how we handle the situation here.
>>
>> Let's see if there are any other ideas. Patch follows.
>>
>> Thanks,
>> Punit
>>
>> ----------->8-------------
>>  From d5ad3f428e629c80b0f93f2bbdf99b4cae28c9bc Mon Sep 17 00:00:00 2001
>> From: Punit Agrawal <punit.agrawal@arm.com>
>> Date: Thu, 9 Mar 2017 16:16:29 +0000
>> Subject: [PATCH] arm64: hugetlb: Fix huge_pte_offset to return poisoned pmd
>>
>> When memory failure is enabled, a poisoned hugepage PMD is marked as a
>> swap entry. As pmd_present() only checks for VALID and PROT_NONE
>> bits (turned off for swap entries), it causues huge_pte_offset() to
>> return NULL for poisoned PMDs.
>>
>> This behaviour of huge_pte_offset() leads to the error such as below
>> when munmap is called on poisoned hugepages.
>>
>> [  344.165544] mm/pgtable-generic.c:33: bad pmd 000000083af00074.
>>
>> Fix huge_pte_offset() to return the poisoned PMD which is then
>> appropriately handled by the generic layer code.
>>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Steve Capper <steve.capper@arm.com>
>> ---
>>   arch/arm64/mm/hugetlbpage.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>> index e25584d72396..9263f206353c 100644
>> --- a/arch/arm64/mm/hugetlbpage.c
>> +++ b/arch/arm64/mm/hugetlbpage.c
>> @@ -150,8 +150,17 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
>>          if (pud_huge(*pud))
>>                  return (pte_t *)pud;
>>          pmd = pmd_offset(pud, addr);
>> +
>> +       /*
>> +        * In case of HW Poisoning, a hugepage pmd can contain
>> +        * poisoned entries. Poisoned entries are marked as swap
>> +        * entries.
>> +        *
>> +        * For pmds that are not present, check to see if it could be
>> +        * a swap entry (!present and !none) before giving up.
>> +        */
>>          if (!pmd_present(*pmd))
>> -               return NULL;
>> +               return !pmd_none(*pmd) ? (pte_t *)pmd : NULL;
>>
>>          if (pte_cont(pmd_pte(*pmd))) {
>>                  pmd = pmd_offset(
>> --
>> 2.11.0
