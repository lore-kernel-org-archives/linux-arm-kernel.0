From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sat, 5 Aug 2017 00:49:19 +0300
Subject: [PATCH RFC] arm64: introduce mm_context_t flags
In-Reply-To: <20170804173809.aviva53kccexghul@armageddon.cambridge.arm.com>
References: <20170731144825.31322-1-ynorov@caviumnetworks.com>
 <20170802163900.66gnhogililb3uak@armageddon.cambridge.arm.com>
 <20170802172940.ejiyl4j2ywlwhbme@yury-thinkpad>
 <20170804173809.aviva53kccexghul@armageddon.cambridge.arm.com>
Message-ID: <20170804214919.2ej6kj2mqmddfe3z@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 04, 2017 at 06:38:10PM +0100, Catalin Marinas wrote:
> On Wed, Aug 02, 2017 at 08:29:40PM +0300, Yury Norov wrote:
> > On Wed, Aug 02, 2017 at 05:39:01PM +0100, Catalin Marinas wrote:
> > > On Mon, Jul 31, 2017 at 05:48:25PM +0300, Yury Norov wrote:
> > > > In patch 06beb72fbe23e ("arm64: introduce mm context flag to keep 32 bit task
> > > > information") you introduce the field flags but use it only for a single flag -
> > > > TIF_32BIT. It looks hacky to me for three reasons:
> > > >  - The flag is introduced for the case where it's impossible to get the thread
> > > >    info structure for the thread associated with mm. So thread_info flags (TIF)
> > > >    may also be unavailable at place. This is not the case for the only existing
> > > >    user of if - uprobes, but in general this approach requires to include thread
> > > >    headers in mm code, which may become unwanted dependency.
> > > >  - New flag, if it uses TIF bits, for consistency should for example set/clear
> > > >    TIF_32BIT_AARCH64 for ILP32 tasks. And to be completely consistent, with
> > > >    current approach we'd mirror thread_info flags to mm_context flags. And keep
> > > >    it syncronized.
> > > >  - If we start using TIF flags here, we cannot easily add new mm_context
> > > >    specific bits because they may mess with TIF ones.
> > > > 
> > > > I think that this is not what was intended when you added new field in
> > > > mm_context_t.
> > > 
> > > TIF_32BIT was handy at the time but it indeed denotes AArch32 user
> > > task. For ILP32 we wouldn't need to set this bit since the instruction
> > > set is A64 and uprobe should support it (though not sure anyone tried).
> > > I noticed in your patch introducing binfmt_ilp32.c that SET_PERSONALITY
> > > actually sets this flag in the mm context.
> > 
> > Depending on what will be decided here, I'll change ilp32 patch
> > accordingly.
> 
> Since this was meant to keep track of AArch32 tasks, the ILP32
> personality macros need to clear it.
 
I understand it. I meant that the exact fix will depend on what we
will figure out here.

I have also fixed small issue with headers in the patch "arm64: signal:
share lp64 signal structures and routines to ilp32", so I think I will
create rc4-based branch that will incorporate all changes. But if you
need I can also update rc3-based branch. And 4.12 - do you need the
updated version of it?

> > > As with the TIF bits, the PERSONALITY macros become more complicated
> > > with more bits to set/clear. Since we don't have any plans for other mm
> > > context flags (independent of TIF), should we simply rename it to
> > > thread_flags and just copy the thread_info flags:
> > > 
> > > 	current->mm->context.thread_flags = current_thread_info()->flags;
> > 
> > This will also work. But it may raise questions to one who reads the
> > code.
> > - if mm_context needs the threads flags, why you copy it? Why not to
> >   move flags to the mm_context_t? It is always available for
> >   thread_info users.
> > - for multithreaded applications there might be different set of bits
> >   in the flags field in different theads. So what exactly will be in
> >   context.thread_flags is a matter of case, and you'd explain somehow
> >   which bits are reliable, and which are not.
> 
> That's a valid argument.
> 
> > - It doesn't sound convincing to me that there are no other candidates
> >   for mm_context.flags bits. 6 month ago we didn't need the flags at all.
> >   ARM64 is under intensive development, and it's highly probable that
> >   candidates may appear one day.
> 
> I'm fine with changing the macro to MMCF_AARCH32, however, could move
> the flag setting out of the SET_PERSONALITY macros, just to keep these
> macros strictly to the TIF flags? We can probably add it to
> arch_setup_new_exec(), something like:
> 
> static inline void arch_setup_new_exec(void)
> {
> 	current->mm->context.flags = 0;
> 	if (test_thread_flag(TIF_32BIT))
> 		current->mm->context.flags |= MMCF_AARCH32;
> }
> #define arch_setup_new_exec	arch_setup_new_exec
> 
> I would go for always initialising the flags to 0 rather than clearing
> certain bits, just to make it clear that we don't inherit them.

Looks even better. I will take it and send the patch soon.

Yury
