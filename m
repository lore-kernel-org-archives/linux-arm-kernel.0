From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 7 Feb 2014 16:25:08 +0000
Subject: [PATCH] ARM: enable IRQs in user undefined instruction vector
In-Reply-To: <20140206205447.GX26684@n2100.arm.linux.org.uk>
References: <1391545146-8320-1-git-send-email-kevin@bracey.fi>
 <20140206112039.GA31054@arm.com> <52F3D024.5020804@bracey.fi>
 <20140206205447.GX26684@n2100.arm.linux.org.uk>
Message-ID: <20140207162508.GA7048@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 08:54:48PM +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 06, 2014 at 08:10:44PM +0200, Kevin Bracey wrote:
> > The VFP code did take pains to increment the pre-emption count before  
> > enabling interrupts, but it's not obvious whether it requires no  
> > pre-emption between the bounce and handler, or just no pre-emption  
> > during the handler.
> 
> Just take a moment to think about this.
> 
> - Userspace raises an undefined instruction exception, running on CPU 0.
> - The kernel starts to handle the exception by saving the ARM state.
> - Enables interrupts.
> - Context switch occurs.
> - VFP state is saved and the VFP is disabled.

There is one case when it isn't saved because of FPEXC_EN being cleared
but we don't care since the VFP registers haven't been touched.

> Now, on CPU1...
> - Context switch occurs to the above thread (due to thread migration).
> - VFP will be in a disabled state.
> - We read FPEXC, find that the VFP is disabled
> - Load saved state into the VFP
> - Check for an exception recorded in the VFP state, and handle it.

This should work since we check the restored registers.

> > What about the iwmmxt and the crunchbits? They are only lazy-enable  
> > routines, to activate an inactive coprocessor. Which I think makes them  
> > safe. If we schedule before reaching the handler, when this context is  
> > returned to, the coprocessor must still be disabled in our context - the  
> > handler can proceed to enable it. And there can't be any other context  
> > state to worry about, assuming the lazy enable scheme works.
> 
> Again, the restore needs to happen with preemption disabled so that
> you don't end up with the state half-restored, and then when you
> resume the thread, you restore the other half.
> 
> This is actually the case I'm more worried about - whether all the
> various handlers are safe being entered with preemption enabled.
> They weren't written for it so the current answer is that they
> aren't safe.

My patchset disables preemption on entering those handlers via
__und_usr, so they don't touch their state with preemption enabled
(well, review is still needed, I can repost them).

> > I share Alexey's Ignatov's concern that your patch ends up running the  
> > support code with interrupts either on or off depending on whether you  
> > came from user or supervisor mode, which feels a little odd. But then,  
> > always enabling interrupts like the current code does, when they might  
> > have been off in the SVC mode context, also seems wrong.
> 
> That is indeed wrong, but then we /used/ to have the requirement that
> the kernel will _never_ execute VFP instructions.  That's changed
> recently since we now permit neon instructions to be executed.

Even if we would take VFP faults from the kernel, I think they are fine
to be executed with interrupts disabled. The problem is when we get page
faults and these may sleep but that's not the case with kernel mappings.

An alternative would be to only enable interrupts around user access in
__und_usr and disable them again afterwards.

-- 
Catalin
