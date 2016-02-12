From: aneesh.kumar@linux.vnet.ibm.com (Aneesh Kumar K.V)
Date: Fri, 12 Feb 2016 21:47:39 +0530
Subject: [BUG] random kernel crashes after THP rework on s390 (maybe also
 on PowerPC and ARM)
In-Reply-To: <20160212125943.1eb2ca9d@thinkpad>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad> <87a8n6shf2.fsf@linux.vnet.ibm.com>
 <20160212125943.1eb2ca9d@thinkpad>
Message-ID: <8760xtsy1o.fsf@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gerald Schaefer <gerald.schaefer@de.ibm.com> writes:

> On Fri, 12 Feb 2016 09:34:33 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> Gerald Schaefer <gerald.schaefer@de.ibm.com> writes:
>> 
>> > On Thu, 11 Feb 2016 21:09:42 +0200
>> > "Kirill A. Shutemov" <kirill@shutemov.name> wrote:
>> >
>> >> On Thu, Feb 11, 2016 at 07:22:23PM +0100, Gerald Schaefer wrote:
>> >> > Hi,
>> >> > 
>> >> > Sebastian Ott reported random kernel crashes beginning with v4.5-rc1 and
>> >> > he also bisected this to commit 61f5d698 "mm: re-enable THP". Further
>> >> > review of the THP rework patches, which cannot be bisected, revealed
>> >> > commit fecffad "s390, thp: remove infrastructure for handling splitting PMDs"
>> >> > (and also similar commits for other archs).
>> >> > 
>> >> > This commit removes the THP splitting bit and also the architecture
>> >> > implementation of pmdp_splitting_flush(), which took care of the IPI for
>> >> > fast_gup serialization. The commit message says
>> >> > 
>> >> >     pmdp_splitting_flush() is not needed too: on splitting PMD we will do
>> >> >     pmdp_clear_flush() + set_pte_at().  pmdp_clear_flush() will do IPI as
>> >> >     needed for fast_gup
>> >> > 
>> >> > The assumption that a TLB flush will also produce an IPI is wrong on s390,
>> >> > and maybe also on other architectures, and I thought that this was actually
>> >> > the main reason for having an arch-specific pmdp_splitting_flush().
>> >> > 
>> >> > At least PowerPC and ARM also had an individual implementation of
>> >> > pmdp_splitting_flush() that used kick_all_cpus_sync() instead of a TLB
>> >> > flush to send the IPI, and those were also removed. Putting the arch
>> >> > maintainers and mailing lists on cc to verify.
>> >> > 
>> >> > On s390 this will break the IPI serialization against fast_gup, which
>> >> > would certainly explain the random kernel crashes, please revert or fix
>> >> > the pmdp_splitting_flush() removal.
>> >> 
>> >> Sorry for that.
>> >> 
>> >> I believe, the problem was already addressed for PowerPC:
>> >> 
>> >> http://lkml.kernel.org/g/454980831-16631-1-git-send-email-aneesh.kumar at linux.vnet.ibm.com
>> >> 
>> >> I think kick_all_cpus_sync() in arch-specific pmdp_invalidate() would do
>> >> the trick, right?
>> >
>> > Hmm, not sure about that. After pmdp_invalidate(), a pmd_none() check in
>> > fast_gup will still return false, because the pmd is not empty (at least
>> > on s390).
>> 
>> Why can't we do this ? I did this for ppc64.
>> 
>>  void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>>  		     pmd_t *pmdp)
>>  {
>> -	pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, 0);
>> +	pmd_hugepage_update(vma->vm_mm, address, pmdp, ~0UL, 0);
>> 
>
> Wouldn't that semantically change what pmdp_invalidate() was supposed to
> do? The comment before the call says "the pmd_trans_huge and
> pmd_trans_splitting must remain set at all times on the pmd". So, after
> removing pmd_trans_splitting, it seems to be necessary to at least keep
> pmd_trans_huge set.
>
> In your case, the pmd would be completely cleared, which may help to find
> it in fast_gup with pmd_none(), but I'm not sure if this would open up
> other problems, e.g. with concurrent page faults. But I must also admit that
> my THP overview got a little rusty.

Thinking about this more, I guess, I should not be doing this. Because
this bring in the exit_mmap race that I outlined in the patch even
though the window now is small. 

I guess we should fix this in the gup path by checking for what ever
trick we are using to mark the pmd splitting. For ppc64 we clear the
_PAGE_USER. We are ok as long as autonuma is enabled because
pmd_protnone() check will check against _PAGE_USER. But that may not be
sufficient. 

-aneesh
