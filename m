From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 12 Nov 2018 12:06:13 +0100
Subject: [PATCH v4 2/3] arm64: implement live patching
In-Reply-To: <20181112110127.GA30967@lst.de>
References: <20181026142008.D922868C94@newverein.lst.de>
 <20181026142152.5F0D868C95@newverein.lst.de>
 <CAKv+Gu_D2vzk-sBkufK7JvaPawC+QnpZwkC0+ikTb7A6qko8ng@mail.gmail.com>
 <20181112110127.GA30967@lst.de>
Message-ID: <CAKv+Gu9aM3FBUDkdy3xC+ZhWBx-dgG7P4cGKTJgcVkKEBw1FSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Nov 2018 at 12:01, Torsten Duwe <duwe@lst.de> wrote:
>
> On Thu, Nov 08, 2018 at 01:42:35PM +0100, Ard Biesheuvel wrote:
> > On 26 October 2018 at 16:21, Torsten Duwe <duwe@lst.de> wrote:
> > >         /* The program counter just after the ftrace call site */
> > >         str     lr, [x9, #S_PC]
> > > +
> > >         /* The stack pointer as it was on ftrace_caller entry... */
> > >         add     x28, fp, #16
> > >         str     x28, [x9, #S_SP]
> >
> > Please drop this hunk
>
> Sure. I missed that one during cleanup.
>
> > > @@ -233,6 +234,10 @@ ftrace_common:
>                          ^^^^^^^^^^^^^^
> > >         ldr     x28, [fp, 8]
> > >         str     x28, [x9, #S_LR]        /* to pt_regs.r[30] */
> > >
> > > +#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
> > > +       mov     x28, lr         /* remember old return address */
> > > +#endif
> > > +
> > >         ldr_l   x2, function_trace_op, x0
> > >         ldr     x1, [fp, #8]
> > >         sub     x0, lr, #8      /* function entry == IP */
> > > @@ -245,6 +250,17 @@ ftrace_call:
> > >
> > >         bl      ftrace_stub
> > >
> > > +#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
> > > +       /* Is the trace function a live patcher an has messed with
> > > +        * the return address?
> > > +        */
> > > +       add     x9, sp, #16     /* advance to pt_regs for restore */
> > > +       ldr     x0, [x9, #S_PC]
> > > +       cmp     x0, x28         /* compare with the value we remembered */
> > > +       /* to not call graph tracer's "call" mechanism twice! */
> > > +       b.ne    ftrace_common_return
> >
> > Is ftrace_common_return guaranteed to be in range? Conditional
> > branches have only -/+ 1 MB range IIRC.
>
> It's the same function. A "1f" would do the same job, but the long label
> is a talking identifier that saves a comment. I'd more be worried about
> the return from the graph trace caller, which happens to be the _next_
> function ;-)
>
> If ftrace_caller or graph_caller grow larger than a meg, something else is
> _very_ wrong.
>

Ah ok. I confused myself into thinking that ftrace_common_return() was
defined in another compilation unit

> > > +#endif
> > > +
> > >  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> >
> > Can we fold these #ifdef blocks together (i.e, incorporate the
> > conditional livepatch sequence here)
>
> I'll see how to make it fit. But remember some people might want ftrace
> but no live patching capability.
>

Sure. I simply mean turning this

#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
<bla>
#endif


#ifdef CONFIG_FUNCTION_GRAPH_TRACER
<bla bla>
#endif

into

#ifdef CONFIG_FUNCTION_GRAPH_TRACER
#ifdef CONFIG_LIVEPATCH
<bla>
#endif
<bla bla>
#endif
