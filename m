From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Sep 2018 12:33:01 +0100
Subject: Huge page(contiguous bit) slow down
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A69FE8F27@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A69FE8F27@G01JPEXMBKW03>
Message-ID: <20180918113300.GC16498@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lei Zhang,

Thanks for the report and the initial diagnosis.

On Tue, Sep 18, 2018 at 03:02:17AM +0000, Zhang, Lei wrote:
> I found a slowdown problem when we uses a huge page on arm64 chip.
> I think the cause of this problem is a bug of huge_ptep_set_access_flags()
> with contiguous pte.
> Could you review and merge my patch?

Before we get to that, here are some things that might help you when
reporting problems in the future:

1. Please keep your line lengths to <= 80 columns, since this makes the
   email easier to read. (I've reflowed your text in my reply)

2. Please try to CC the right maintainers on your report. If you're not
   sure who they are, then you can run ./scripts/get_maintainer.pl:

   $ ./scripts/get_maintainer.pl arch/arm64/mm/hugetlbpage.c

   identifies me and Catalin, for example. You can also use git blame,
   which shows that Steve and Punit wrote a lot of this function. I've
   added these people to CC.

3. If you have a patch that you'd like to be merged, you'll need a
   commit message that includes your "Signed-off-by:" line. You can use
   git format-patch to generate this, but you should also have a look at
   Documentation/process/submitting-patches.rst.

4. Please always mention the kernel version that you're seeing problems
   with, in case we've applied fixes to the problematic area in the
   meantime.

> Incident:
> Multiple threaded process repeats page fault again and again, so the PC in
> EL0 doesn't move to the next operation.
> 
> Multiple threads occur page fault at the same time and the same VA. It may
> cause slowdown or hang of a process.
> Because a race problem on updating pte maybe happened when the condition
> matched as below.
> 1. Multiple threads are running
> 2. All threads are ld/st-ing to the same huge page
> 3. The huge page is consist of contiguous ptes (2MiB page = 64KiB page x 32)
> 4. The huge page is mapped without MAP_POPULATE flag.
> 
> Mechanism:
> The mechanism of this problem is as below.
> Updating pte use 4 steps.
> 
> step1: create pte content
> step2: zero-clear pte at ptep_get_and_clear
> step3: flush tlb at flush_tlb_range
> step4: set pte at set_pte_at(pte becomes non-zero)
> 
> When thread1 is doing between step2 and step4, thread2 accesses the same huge
> page at the same time.
> It cause a new page fault at thread2.
> After that, when thread2 is doing between step2 and step4, thread1 retries
> the access to the same page.
> It cause a new page fault at thread1 again.
> Multi-threads repeat this flow again and again.

Hmm, yes, I can see how this happens. Whilst the mmap_sem should serialise
the faults, the contig hugepage code always clears the pte as part of the
BBM sequence, so we can get stuck in a fault cycle.

> On the other hand, if the pte is not a contiguous pte, slowdown or hang will
> not occur.
> Because it check whether a correct pte has been already presented by other
> thread using pte_same before step2(0 clear pte).
> 
> Call tree information:
> hugetlb_fault
>   huge_ptep_set_access_flags
>     ptep_set_access_flags  -> ( contiguous pte route not call this)
>       pte_same
>     ptep_get_and_clear
>     flush_tlb_range
>     set_pte_at
> 
> So our patch calls the same check function not only for non-contiguous pte
> but also for contiguous pte.
> 
> -----------------------------
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -332,6 +332,9 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>         if (!pte_cont(pte))
>                 return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
> 
> +       if(pte_same(pte, READ_ONCE(*ptep)))
> +               return 0;
> +

This broadly seems to follow the non-contiguous code, but I wonder if we
can then drop the subsequent pte_same() check on this path and always return
1 when we actually update the entries?

Will
