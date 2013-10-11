From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Oct 2013 11:43:39 +0100
Subject: [PATCH v2 2/3] AArch64: KGDB: Add Basic KGDB support
In-Reply-To: <CA+=Sn1naFrtkYSEo6D2qbqCNDgrj6dUZkRFLDGq5gs_3HMLk4g@mail.gmail.com>
References: <1380534251-4464-1-git-send-email-vijay.kilari@gmail.com>
 <1380534251-4464-3-git-send-email-vijay.kilari@gmail.com>
 <20130930163654.GJ26036@mudshark.cambridge.arm.com>
 <CALicx6vpX6nm=zdBZTY57EgPRphcjMzwFxug6CAa_U21u4_4Cw@mail.gmail.com>
 <20131002101846.GC28311@mudshark.cambridge.arm.com>
 <CA+=Sn1kErSHjRkUsxB_2WzXj6Fn-OcnUb42R_WR-hJEaVrL8VQ@mail.gmail.com>
 <20131007095141.GD465@mudshark.cambridge.arm.com>
 <CA+=Sn1naFrtkYSEo6D2qbqCNDgrj6dUZkRFLDGq5gs_3HMLk4g@mail.gmail.com>
Message-ID: <20131011104339.GD14732@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Fri, Oct 11, 2013 at 01:24:29AM +0100, Andrew Pinski wrote:
> On Mon, Oct 7, 2013 at 2:51 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Oct 04, 2013 at 10:51:02PM +0100, Andrew Pinski wrote:
> >> Yes this will be a full schedule barrier due to the inline-asm being a
> >> volatile inline-asm (implicitly because there are no outputs).  What I
> >> meant about the compiler could move around code only happens when you
> >> don't there are other implicit non schedule barrier instructions, in
> >> this case wmb is an volatile inline-asm which is also a scheduler
> >> barrier.
> >
> > volatile != scheduling barrier (example below).
> 
> Actually it does mean that but scheduling barrier != code motion
> barrier; at least in GCC.

Bah, terminology. I can tell you're a compiler engineer ;)

> > Assembles to the following with GCC 4.9 for ARM:
> >
> > 00000000 <foo>:
> >    0:   e5900000        ldr     r0, [r0]
> >    4:   f57ff04f        dsb     sy
> >    8:   e320f000        nop     {0}
> >    c:   f57ff04f        dsb     sy
> >   10:   e280000a        add     r0, r0, #10
> >   14:   e12fff1e        bx      lr
> 
> 
> Yes but this is not the scheduler doing the code motion (it is SCEV
> Constant prop followed by TER [temporary expression replacement] which
> is causing the code motion to happen).

Regardless, it's still not suitable for breakpoints in general.

> >> Note all other targets (ARM, PPC, x86, tile, etc.) all use a static
> >> inline function which does exactly the same as what is being added
> >> here.
> >
> > Agreed, I didn't mean to imply this was an issue with this particular patch.
> > I'm just curious as to why this has been deemed acceptable by other
> > architectures, when it doesn't look especially useful to me.
> 
> The main reason why it is acceptable by other architectures is due to
> the full definition of the function itself:
> void kgdb_breakpoint(void)
> {
>         atomic_inc(&kgdb_setting_breakpoint);
>         wmb(); /* Sync point before breakpoint */
>         arch_kgdb_breakpoint();
>         wmb(); /* Sync point after breakpoint */
>         atomic_dec(&kgdb_setting_breakpoint);
> }
> 
> All of these function calls are all volatile inline-asm so there is
> not going to be any code motion happening.  This is true in all
> architectures.  So then you ask if kgdb_breakpoint can be inlined
> anywhere that we could get the breakpoint and not have the "correct"
> value, the answer is no and I audited each and every call to
> kgdb_breakpoint.  If you want just add the attribute noinline to
> kgdb_breakpoint and the problem you mentioned about the code motion
> happening goes away.

Thanks for taking a look at this. I think adding the noinline would be a
good idea (as a seperate patch).

Cheers,

Will
