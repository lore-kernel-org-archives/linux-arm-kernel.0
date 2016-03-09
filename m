From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Wed, 9 Mar 2016 23:13:07 +0530
Subject: [PATCH] arm64: Fix the ptep_set_wrprotect() to set PTE_DIRTY if
 (PTE_DBM && !PTE_RDONLY)
In-Reply-To: <20160309160352.GM6192@e104818-lin.cambridge.arm.com>
References: <1457499768-31176-1-git-send-email-gkulkarni@caviumnetworks.com>
 <20160309100605.GJ6192@e104818-lin.cambridge.arm.com>
 <CAFpQJXUaXYkVNCc1OjLxCmpKu6b26LOaMv0V9XYRn7pLAGk2SQ@mail.gmail.com>
 <20160309160352.GM6192@e104818-lin.cambridge.arm.com>
Message-ID: <CAFpQJXVkjgpTaftiA7uK-GknoZXP+fP0pTX1ajZk6wfjovDwCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 9, 2016 at 9:33 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Mar 09, 2016 at 05:17:39PM +0530, Ganapatrao Kulkarni wrote:
>> On Wed, Mar 9, 2016 at 3:36 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > On Wed, Mar 09, 2016 at 10:32:48AM +0530, Ganapatrao Kulkarni wrote:
>> >> Commit 2f4b829c625e ("arm64: Add support for hardware updates of the
>> >> access and dirty pte bits") introduced support for handling hardware
>> >> updates of the access flag and dirty status.
>> >>
>> >> ptep_set_wrprotect is setting PTR_DIRTY if !PTE_RDONLY,
>> >> however by design it suppose to set PTE_DIRTY
>> >> only if (PTE_DBM && !PTE_RDONLY). This patch addes code to
>> >> test and set accordingly.
>> >
>> > The reasoning behind the original code is that if !PTE_RDONLY, you have
>> > no way to tell whether the page was written or not since it is already
>> > writable, independent of the DBM. So by clearing the DBM bit (making the
>> > page read-only), we need to ensure that a potential dirty state is
>> > transferred to the software PTE_DIRTY bit.
>> >
>> > By checking PTE_DBM && !PTE_RDONLY, you kind of imply that you can have
>> > a page with !PTE_DBM && !PTE_RDONLY. Given that PTE_DBM is actually
>> > PTE_WRITE, PTE_RDONLY must always be set when !PTE_DBM. The bug may be
>> > elsewhere not setting these bits correctly.
>>
>> but i do see this macro,
>> #define pte_hw_dirty(pte)       (pte_write(pte) && !(pte_val(pte) & PTE_RDONLY))
>
> This was added in commit b847415ce96e ("arm64: Fix the pte_hw_dirty()
> check when AF/DBM is enabled") for the pte_modify() case which is not
> called on the actual PTE but a local variable. A pte passed to this
> function as !PTE_DBM && !PTE_RDONLY should not be assumed dirty since
> PTE_RDONLY will be set later by set_pte_at() when the actual page table
> write occurs.
>
> ptep_set_wrprotect() is run directly on the actual PTE, so here a
> !PTE_RDONLY only means potentially dirty, independent of the PTE_DBM
> bit. I consider the additional PTE_DBM check superfluous in this case
> but we need to understand when we would actually get a pte with both
> PTE_DBM and PTE_RDONLY cleared.
>
> The only way I see this happening is if the pte doesn't have PTE_VALID
> set, IOW it probably has PTE_PROT_NONE set which is used by the NUMA
> balancing. So calling set_pte_at() on a !PTE_VALID && !PTE_DBM pte does
> not currently set PTE_RDONLY and ptep_set_wrprotect() wrongly assumes it
> is dirty.
>
>> i dont see this issue, if i comment out arm64 implementation of
>> ptep_set_wrprotect()
>
> Because the default implementation discards any existing hw dirty
> information by clearing the PTE_DBM bit and setting PTE_RDONLY via the
> set_pte_at (of course, apart from the atomicity issues).
>
>> >> This patch fixes BUG,
>> >> kernel BUG at /build/linux-StrpB2/linux-4.4.0/fs/ext4/inode.c:2394!
>> >> Internal error: Oops - BUG: 0 [#1] SMP
>> >
>> > Which bug is this? It's a PageWriteback() check in the for-next/core
>> > branch. What kernel version are you using?
>>
>> i am using 4.4.0
>
> I guess with additional NUMA patches since it only fails when you enable
> the NUMA_BALANCING configuration.
>
>> > BTW, in 4.5-rc2 we pushed commit ac15bd63bbb2 ("arm64: Honour !PTE_WRITE
>> > in set_pte_at() for kernel mappings"), though not sure that's what you
>> > are hitting.
>>
>> i have tried this patch, but issue still exist. crash log below
>>
>> root at ubuntu:/home/ganapat/test# [  733.853009] kernel BUG at
>> fs/ext4/inode.c:2394!
>
> Is this the BUG_ON in page_buffers(!PagePrivate(page))? I can see in the
> code above this that wrongly marking a page as dirty could have some
> side effects.
>
> Can you give this patch a try, on top of commit ac15bd63bbb2?

thanks, this fixes the issue, i have tried making pte_valid same as pte_present
however, i have overlooked that set_pte_at is using pte_valid_user(in 4.4)


>
> -------------8<----------------------
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 7c73b365fcfa..b409a983f870 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -201,7 +201,7 @@ extern void __sync_icache_dcache(pte_t pteval, unsigned long addr);
>  static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>                               pte_t *ptep, pte_t pte)
>  {
> -       if (pte_valid(pte)) {
> +       if (pte_present(pte)) {
>                 if (pte_sw_dirty(pte) && pte_write(pte))
>                         pte_val(pte) &= ~PTE_RDONLY;
>                 else

Ganapat
