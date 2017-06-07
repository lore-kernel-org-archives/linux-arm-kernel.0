From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 7 Jun 2017 15:02:01 -0400
Subject: [PATCH v2 2/2] arm64: ftrace: add support for far branches to
 dynamic ftrace
In-Reply-To: <20170607165626.GE2669@arm.com>
References: <20170530135220.20759-1-ard.biesheuvel@linaro.org>
 <20170530135220.20759-3-ard.biesheuvel@linaro.org>
 <20170605171535.GP21944@arm.com>
 <20170607114637.1a717019@gandalf.local.home>
 <CAKv+Gu8kWt7yDg8hu=bJb4FrA3qGqV2jgShujqHqewDSKr1D8w@mail.gmail.com>
 <20170607165626.GE2669@arm.com>
Message-ID: <20170607150201.7123c48f@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 Jun 2017 17:56:26 +0100
Will Deacon <will.deacon@arm.com> wrote:

> On Wed, Jun 07, 2017 at 03:50:10PM +0000, Ard Biesheuvel wrote:
> > On 7 June 2017 at 15:46, Steven Rostedt <rostedt@goodmis.org> wrote:  
> > > On Mon, 5 Jun 2017 18:15:35 +0100
> > > Will Deacon <will.deacon@arm.com> wrote:
> > >
> > >  
> > >> > +           tramp = (unsigned long *)mod->arch.ftrace_trampoline->sh_addr;
> > >> > +           if (tramp[0] != addr) {
> > >> > +                   if (tramp[0] != 0) {
> > >> > +                           pr_err("ftrace: far branches to multiple entry points unsupported inside a single module\n");
> > >> > +                           return AARCH64_BREAK_FAULT;
> > >> > +                   }
> > >> > +
> > >> > +                   /* point the trampoline to our ftrace entry point */
> > >> > +                   module_disable_ro(mod);
> > >> > +                   tramp[0] = addr;
> > >> > +                   module_enable_ro(mod, true);  
> > >>
> > >> I'm not sure what the barrier semantics are for module_enable_ro, but I'd be
> > >> inclined to stick in a smp_wmb() here to order the write of the trampoline
> > >> data before the writing of the branch instruction.  
> > >
> > > I would assume that module_disable/enable_ro() has proper barriers for
> > > modifying the page tables with respect to code around it, otherwise it
> > > would probably be an issues elsewhere in the kernel. Specifically in
> > > the module code itself.
> > >
> > > I don't see how a smp_wmb() would be needed here, especially since this
> > > is serialized code, and not something done by multiple CPUs.
> > >  
> > 
> > But other cores could be invoking the function we are patching here,
> > no? So when such a core observes (and executes) the updated
> > instruction before it observes the updated target field of the
> > trampoline, it will branch to address 0x0.  
> 
> I think Steve's saying that the TLB invalidation buried in the set_memory_*
> functions called by module_enable_ro will have sufficient barriers to order
> the write of the trampoline with respect to writing the branch instruction,
> but this isn't quite right because module_enable_ro is affected by things
> like CONFIG_STRICT_MODULE_RWX and rodata_enabled.
> 

Sorry, I was thinking that you were worried about the update with the
page tables taking affect.

But from the above comment by Ard, I'm now thinking you are worried
about the jump to the trampoline itself when the branch is enabled. Now,
my question is, can a smp_wmb() be good enough as there's no smp_rmb()
to accompany it. Even with an smp_wmb() the reads can still come out of
order without any smp_rmb() on the execution path.

The way I get around that on x86 is I call on_each_cpu() a sync_core()
routine. See run_sync() in arch/x86/kernel/ftrace.c. That makes sure
that all cores are updated before I proceed to the next step.

-- Steve
