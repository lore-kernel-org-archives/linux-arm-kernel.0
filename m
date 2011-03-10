From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Mar 2011 10:15:36 -0000
Subject: [PATCH] ARM: aout-core: zero thread debug registers in a.out core
	dump
In-Reply-To: <AANLkTi=uhEfpv1bD_Wtoq4i7kJ5D8yDFmqBwchAnqtXu@mail.gmail.com>
References: <1299581872-18098-1-git-send-email-will.deacon@arm.com>
	<AANLkTi=uhEfpv1bD_Wtoq4i7kJ5D8yDFmqBwchAnqtXu@mail.gmail.com>
Message-ID: <000701cbdf0c$19272af0$4b7580d0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bryan,

> > Hi Bryan,
> >
> > Feel free to upgrade your tag on this (signed-off / acked) since this is
> > clearly based on the patch you posted yesterday. I'd like to get this to
> > Russell ASAP so that we don't get a build-breaker in the near future.
> >
> 
> Oh, I missed this email. Just send out an similar patch.

No problem, I'd just like to get this in the pipeline asap!
 
> > diff --git a/arch/arm/include/asm/a.out-core.h b/arch/arm/include/asm/a.out-core.h
> > index 93d04ac..92f10cb 100644
> > --- a/arch/arm/include/asm/a.out-core.h
> > +++ b/arch/arm/include/asm/a.out-core.h
> > @@ -32,11 +32,7 @@ static inline void aout_dump_thread(struct pt_regs *regs, struct user *dump)
> > ? ? ? ?dump->u_dsize = (tsk->mm->brk - tsk->mm->start_data + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > ? ? ? ?dump->u_ssize = 0;
> >
> > - ? ? ? dump->u_debugreg[0] = tsk->thread.debug.bp[0].address;
> > - ? ? ? dump->u_debugreg[1] = tsk->thread.debug.bp[1].address;
> > - ? ? ? dump->u_debugreg[2] = tsk->thread.debug.bp[0].insn.arm;
> > - ? ? ? dump->u_debugreg[3] = tsk->thread.debug.bp[1].insn.arm;
> > - ? ? ? dump->u_debugreg[4] = tsk->thread.debug.nsaved;
> > + ? ? ? memset(dump->u_debugreg, 0, sizeof(dump->u_debugreg));
> >
> I think this should be
>  memset(dump->u_debugreg, 0, sizeof(dump->u_debugreg) * 8);
> 
> u_debugreg is a pointer to a int, the array contains 8 of them as we
> found in the user.h

dump_udebugreg is an integer array of fixed size. If you look at
the disassembly of fs/binfmt_aout.o (removed some inlining,
recompiled with -01):

00000c7c <aout_dump_thread>:
 c7c:   e92d4038        push    {r3, r4, r5, lr}
 c80:   e1a05000        mov     r5, r0
 c84:   e1a04001        mov     r4, r1
 c88:   e1a0200d        mov     r2, sp

[...]

 cfc:   e2840090        add     r0, r4, #144    ; 0x90
 d00:   e3a01020        mov     r1, #32
 d04:   ebfffffe        bl      0 <__memzero>

So the size from sizeof is correct, multiplying it by 8 is asking
for trouble! If we used the ARRAY_SIZE macro, then the multiplication
would be necessary because we would have performed the division inside
the macro.
 
Please can you submit another patch? I think the one I posted the other
day was alright, so if you re-post that you can add my S-o-B.

Thanks,

Will
