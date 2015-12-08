From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 8 Dec 2015 21:08:32 +0800
Subject: ARM64: kernel oops in 4.4-rc4+
In-Reply-To: <20151208103013.GA19612@arm.com>
References: <CACVXFVPnmKzv-mnDyjOnoQtxZ4kyWLtkymK1XhDThO8ibi7f7w@mail.gmail.com>
 <20151208103013.GA19612@arm.com>
Message-ID: <CACVXFVPgTPYzHj0E7cSx=X+=t=0Am_yBSk6FnTZHeG0hyY6ipg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 8, 2015 at 6:30 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Dec 08, 2015 at 02:30:33PM +0800, Ming Lei wrote:
>> Hi,
>
> [adding Catalin to cc]
>
>> The attached kernel oops can be triggered immediately after
>> running the following command on APM Mustang:
>>
>>         $stress-ng --all 8 -t 10m
>>
>> [1] kernel oops log
>> stress-ng: info:  [5220] 5 failures reached, aborting stress process
>> [  265.782659] kernel BUG at ./arch/arm64/include/asm/pgtable.h:282!
>
> Yikes, this means we're replacing a writable pte with a clean pte, so
> there's a potential race w/ hardware DBM.
>
> Could you dump pte and *ptep please?

They are dumped as so:

set_pte_at: addr 470000, ptep fffffe00bc870238, *ptep 680047348a0bd3,
pte 680047348a0fd3

with the following change:

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7e074f9..1c5f0ee 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -278,6 +278,12 @@ static inline void set_pte_at(struct mm_struct *mm, unsigne
         */
        if (IS_ENABLED(CONFIG_DEBUG_VM) && IS_ENABLED(CONFIG_ARM64_HW_AFDBM) &&
            pte_valid(*ptep)) {
+
+               if (!pte_young(pte) || (pte_write(*ptep) && !pte_dirty(pte)))
+                       trace_printk("%s: addr %lx, ptep %p, *ptep %llx, pte %ll
+                               __func__, addr, ptep,
+                               (unsigned long long)pte_val(*ptep),
+                               (unsigned long long )pte_val(pte));
                BUG_ON(!pte_young(pte));
                BUG_ON(pte_write(*ptep) && !pte_dirty(pte));

>
>> [  265.788726] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>> [  265.794186] Modules linked in:
>> [  265.797241] CPU: 1 PID: 15830 Comm: stress-ng-cache Tainted: G
>>   W       4.4.0-rc4+ #54
>
> What changes do you have on top of -rc4?

Nothing else, and it is just built from the latest linus tree.


Thanks,
Ming Lei
