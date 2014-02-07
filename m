From: vinayakm.list@gmail.com (vinayak menon)
Date: Fri, 7 Feb 2014 17:49:54 +0530
Subject: [PATCH] ARM: enable IRQs in user undefined instruction vector
In-Reply-To: <20140207100649.GZ26684@n2100.arm.linux.org.uk>
References: <1391545146-8320-1-git-send-email-kevin@bracey.fi>
 <20140206112039.GA31054@arm.com> <52F3D024.5020804@bracey.fi>
 <20140206205447.GX26684@n2100.arm.linux.org.uk>
 <CAOaiJ-kY_VwsY0iHSMVQZx=zvP5is1LRkir5_zP6Jnttv+O1VQ@mail.gmail.com>
 <20140207100649.GZ26684@n2100.arm.linux.org.uk>
Message-ID: <CAOaiJ-=ASevi8ex=M-SHZMCNZw+=78GbJr3aoyDCGO00S=94Sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I don't see any point to this change - it does nothing to address the
> point I raised.

I see.

The issue that was observed can be summarized like this. There was a
userspace crash which was because of an 8 byte offset to SP when
returning from a function (strtoimax).
Analysis showed that the vpush {d8}  instruction at the beginning of
strtoimax failed to execute, but vpop {d8}  at the end did execute.
This resulted in a 8 byte offset in SP and resulted in the crash.

Further debugging showed that this was happening because, one of the
ldrht instructions in __und_usr was hitting a page fault, and the
fixup code was returning to the next instruction.

Correction was added to PC in the fixup (str     r4, [sp, #S_PC] , in
the patch above), to fix the problem. But we were left with the
warning (might_sleep).

Reading the discussions, I thought enabling irq is an issue, and felt
that without enabling the interrupts, just disabling preemption before
calling ldrht should stop the warnings. Because do_page_fault jumps to
call fixup, if its an atomic context.

Thanks
