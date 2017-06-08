From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Jun 2017 10:59:57 +0100
Subject: [PATCH v2 2/2] arm64: ftrace: add support for far branches to
 dynamic ftrace
In-Reply-To: <20170607150201.7123c48f@gandalf.local.home>
References: <20170530135220.20759-1-ard.biesheuvel@linaro.org>
 <20170530135220.20759-3-ard.biesheuvel@linaro.org>
 <20170605171535.GP21944@arm.com>
 <20170607114637.1a717019@gandalf.local.home>
 <CAKv+Gu8kWt7yDg8hu=bJb4FrA3qGqV2jgShujqHqewDSKr1D8w@mail.gmail.com>
 <20170607165626.GE2669@arm.com>
 <20170607150201.7123c48f@gandalf.local.home>
Message-ID: <20170608095957.GB6071@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Wed, Jun 07, 2017 at 03:02:01PM -0400, Steven Rostedt wrote:
> On Wed, 7 Jun 2017 17:56:26 +0100
> Will Deacon <will.deacon@arm.com> wrote:
> 
> > On Wed, Jun 07, 2017 at 03:50:10PM +0000, Ard Biesheuvel wrote:
> > > On 7 June 2017 at 15:46, Steven Rostedt <rostedt@goodmis.org> wrote:  
> > > > On Mon, 5 Jun 2017 18:15:35 +0100
> > > > Will Deacon <will.deacon@arm.com> wrote:
> > > >
> > > >  
> > > >> > +           tramp = (unsigned long *)mod->arch.ftrace_trampoline->sh_addr;
> > > >> > +           if (tramp[0] != addr) {
> > > >> > +                   if (tramp[0] != 0) {
> > > >> > +                           pr_err("ftrace: far branches to multiple entry points unsupported inside a single module\n");
> > > >> > +                           return AARCH64_BREAK_FAULT;
> > > >> > +                   }
> > > >> > +
> > > >> > +                   /* point the trampoline to our ftrace entry point */
> > > >> > +                   module_disable_ro(mod);
> > > >> > +                   tramp[0] = addr;
> > > >> > +                   module_enable_ro(mod, true);  
> > > >>
> > > >> I'm not sure what the barrier semantics are for module_enable_ro, but I'd be
> > > >> inclined to stick in a smp_wmb() here to order the write of the trampoline
> > > >> data before the writing of the branch instruction.  
> > > >
> > > > I would assume that module_disable/enable_ro() has proper barriers for
> > > > modifying the page tables with respect to code around it, otherwise it
> > > > would probably be an issues elsewhere in the kernel. Specifically in
> > > > the module code itself.
> > > >
> > > > I don't see how a smp_wmb() would be needed here, especially since this
> > > > is serialized code, and not something done by multiple CPUs.
> > > >  
> > > 
> > > But other cores could be invoking the function we are patching here,
> > > no? So when such a core observes (and executes) the updated
> > > instruction before it observes the updated target field of the
> > > trampoline, it will branch to address 0x0.  
> > 
> > I think Steve's saying that the TLB invalidation buried in the set_memory_*
> > functions called by module_enable_ro will have sufficient barriers to order
> > the write of the trampoline with respect to writing the branch instruction,
> > but this isn't quite right because module_enable_ro is affected by things
> > like CONFIG_STRICT_MODULE_RWX and rodata_enabled.
> > 
> 
> Sorry, I was thinking that you were worried about the update with the
> page tables taking affect.
> 
> But from the above comment by Ard, I'm now thinking you are worried
> about the jump to the trampoline itself when the branch is enabled. Now,
> my question is, can a smp_wmb() be good enough as there's no smp_rmb()
> to accompany it. Even with an smp_wmb() the reads can still come out of
> order without any smp_rmb() on the execution path.

So this is actually really subtle and the architecture manual doesn't
give us *quite* what we need. The reads that we're trying to order are:

  1. The instruction fetch of the branch instruction
  2. The load of the offset for the indirect branch in the trampoline

You might think there's a strong dependency here because the second load
doesn't take place if the branch isn't taken, but branch prediction could
in theory break that assumption.

Now, having a branch predictor predict on a NOP is extremely unlikely,
so I'll see if I can get the architecture clarified here. In the meantime,
I've merged this patch because I'm pretty confident it will work in practice
and if the architecture really won't give us the guarantee then we'll have
other things to fix too (like the whole applicability of the _nosync
patching).

Will
