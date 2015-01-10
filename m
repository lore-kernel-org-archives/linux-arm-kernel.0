From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 9 Jan 2015 20:39:05 -0800
Subject: Linux 3.19-rc3
In-Reply-To: <54B09CA3.1060501@redhat.com>
References: <CA+55aFwsxoyLb9OWMSCL3doe_cz_EQtKsEFCyPUYn_T87pbz0A@mail.gmail.com>
 <54AE7D53.2020305@redhat.com> <20150109121348.GD12942@leverpostej>
 <CAPvkgC23LHhs7Tw4rdAPFooimonji8R7kEAbWYRKPJwouwUzBA@mail.gmail.com>
 <54AFE53A.4020004@redhat.com> <20150109175702.GA27787@leverpostej>
 <54B01FF0.3020900@arm.com> <20150109194333.GA23028@arm.com>
 <54B09CA3.1060501@redhat.com>
Message-ID: <CA+55aFw3aGeiWOiKxQaC23VVX_Q9B0cDeZc37vVfK+SJVjGwFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 9, 2015 at 7:29 PM, Laszlo Ersek <lersek@redhat.com> wrote:
>
> I've bisected this issue to

.. commit f045bbb9fa1b ("mmu_gather: fix over-eager
tlb_flush_mmu_free() calling")

Hmm. That commit literally just undoes something that commit
fb7332a9fedf ("mmu_gather: move minimal range calculations into
generic code") changed, and that was very wrong on x86.

But arm64 did have very different TLB flushing logic, so there may be
some ARM64 reason that Will did that change originally, and then he
forgot that reason when he ack'ed commit f045bbb9fa1b that undid it.

Will?

Before your mmu_gather range calculations commit, we used to have

In tlb_flush_mmu_tlbonly():

     tlb->need_flush = 0;

and in tlb_flush_mmu():

    if (!tlb->need_flush)
                return;

and your commit changed the rule to be

    !tlb->need_flush == !tlb->end

so in the current tree we have

 In tlb_flush_mmu_tlbonly():

    __tlb_reset_range(tlb);   // replaces "tlb->need_flush = 0;"

and in tlb_flush_mmu():

    if (!tlb->end)    // replaces if (!tlb->need_flush)
        return;

so we seem to do exactly the same as 3.18.

But in your original patch, you moved that "if (!tlb->end) return;"
check from tlb_flush_mmu() into tlb_flush_mmu_tlbonly(), and that
apparently is actually needed on arm64. But *why*?

Also, looking at that commit fb7332a9fedf, I note that some of the
"need_flush" setting was simply removed. See for example
arch/powerpc/mm/hugetlbpage.c, and also in mm/memory.c:
tlb_remove_table(). Is there something non-obvious that sets tlb->end
there?

The other need_flush removals seem to all be paired with adding a
__tlb_adjust_range() call, which will set ->end.

I'm starting to suspect that you moved the need_flush test into
tlbonly exactly because you removed that

        tlb->need_flush = 1;

from mm/memory.c: tlb_remove_table().

x86 doesn't care, because x86 doesn't *use* tlb_remove_table(). But
arm64 does, at least with the RCU freeing.

Any ideas?

                         Linus
