From: duwe@lst.de (Torsten Duwe)
Date: Mon, 12 Nov 2018 12:51:13 +0100
Subject: [PATCH v4 1/3] arm64: implement ftrace with regs
In-Reply-To: <CAKv+Gu-rNeCj5jySq4H5mRONtWfoLy7ADsowWNW+LUBLMWnV+A@mail.gmail.com>
References: <20181026142008.D922868C94@newverein.lst.de>
 <20181026142148.6353A68C94@newverein.lst.de>
 <CAKv+Gu-rNeCj5jySq4H5mRONtWfoLy7ADsowWNW+LUBLMWnV+A@mail.gmail.com>
Message-ID: <20181112115112.GB30967@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 08, 2018 at 01:12:42PM +0100, Ard Biesheuvel wrote:
> 
> On 26 October 2018 at 16:21, Torsten Duwe <duwe@lst.de> wrote:
> > @@ -162,6 +165,114 @@ ftrace_graph_call:                        // ftrace_graph_cal
> >
> >         mcount_exit
> >  ENDPROC(ftrace_caller)
> > +#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> > +
> > +/*
> > + * Since no -pg or similar compiler flag is used, there should really be
> > + * no reference to _mcount; so do not define one. Only some value for
> > + * MCOUNT_ADDR is needed for comparison. Let it point here to have some
> > + * sort of magic value that can be recognised when debugging.
> > + */
> > +       .global _mcount
> > +_mcount:
> > +       ret     /* make it differ from regs caller */
> > +
> > +ENTRY(ftrace_regs_caller)
> > +       /* callee's preliminary stack frame: */
> > +       stp     fp, x9, [sp, #-16]!
> 
> Does the 'fp' alias for x29 work with older assemblers? I guess it
> does not matter gor GCC 8+ code, but be careful when you rewrite
> existing stuff.

I had gotten the impression the fp alias was there ever since, so I used
it for readability. Thanks for the notification, I'll double check.

> > +       mov     fp, sp
> > +
> > +       /* our stack frame: */
> > +       stp     fp, lr, [sp, #-S_FRAME_SIZE]!
> 
> If sizeof(struct pt_regs) == S_FRAME_SIZE), you should subtract 16
> additional bytes here

This is intentional :-]

At the end of pt_regs there's a "stackframe", which now aligns with the
"preliminary" frame I create for the callee. Please tell me what the struct
member is good for if not for an actual callee stack frame...
I thought it was a neat idea.

> > +
> > +ftrace_common:
> > +       /*
> > +        * At this point we have 2 new stack frames, and x9 pointing
> > +        * at a pt_regs which we can populate as needed.
> > +        */
> > +
> > +       /* save function arguments */
> > +       stp     x0, x1, [x9]
> > +       stp     x2, x3, [x9, #S_X2]
> > +       stp     x4, x5, [x9, #S_X4]
> > +       stp     x6, x7, [x9, #S_X6]
> > +       stp     x8, x9, [x9, #S_X8]
> > +
> 
> x9 is not a function argument, and if it were, you'd have clobbered it
> by now. Please use a single 'str' and store x8 only

This way the x9 slot in pt_regs will be undefined. Is that ok with everybody?

> > +ftrace_common_return:
> > +       add     x9, sp, #16     /* advance to pt_regs for restore */
> > +
> > +       ldp     x0, x1, [x9]
> > +       ldp     x2, x3, [x9, #S_X2]
> > +       ldp     x4, x5, [x9, #S_X4]
> > +       ldp     x6, x7, [x9, #S_X6]
> > +       ldp     x8, x9, [x9, #S_X8]
> > +
> 
> Same as above. It also deserves a mention that you are relying on the
> absence of IPA-RA, and so x9..x18 are guaranteed to be dead at
> function entry, and so they don't need to be restored here.

Sure, I can quote some ABI spec here :-/
I just wish all arm code was such well documented.

> > --- a/arch/arm64/kernel/ftrace.c
> > +++ b/arch/arm64/kernel/ftrace.c
> > @@ -65,18 +65,61 @@ int ftrace_update_ftrace_func(ftrace_fun
> >         return ftrace_modify_code(pc, 0, new, false);
> >  }
> >
> > +#ifdef CONFIG_ARM64_MODULE_PLTS
> > +static int install_ftrace_trampoline(struct module *mod, unsigned long *addr)
> > +{
> > +       struct plt_entry trampoline, *mod_trampoline;
> > +       trampoline = get_plt_entry(*addr);
> > +
> > +       if (*addr == FTRACE_ADDR)
> > +               mod_trampoline = mod->arch.ftrace_trampoline;
> > +       else if (*addr == FTRACE_REGS_ADDR)
> > +               mod_trampoline = mod->arch.ftrace_regs_trampoline;
> 
> Could we do something like
> 
> if (*addr == FTRACE_ADDR)
>     mod_trampoline = &mod->arch.ftrace_trampoline[0];
> else if (*addr == FTRACE_REGS_ADDR)
>     mod_trampoline = &mod->arch.ftrace_trampoline[1];
> 
> and get rid of the additional struct field and pointer?

"0" and "1" won't make it obvious which one has the regs tracing, but besides
that, I like the idea of making this a small array. Other opinions?

	Torsten
