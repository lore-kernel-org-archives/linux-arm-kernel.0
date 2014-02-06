From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Feb 2014 20:54:48 +0000
Subject: [PATCH] ARM: enable IRQs in user undefined instruction vector
In-Reply-To: <52F3D024.5020804@bracey.fi>
References: <1391545146-8320-1-git-send-email-kevin@bracey.fi>
 <20140206112039.GA31054@arm.com> <52F3D024.5020804@bracey.fi>
Message-ID: <20140206205447.GX26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 08:10:44PM +0200, Kevin Bracey wrote:
> The VFP code did take pains to increment the pre-emption count before  
> enabling interrupts, but it's not obvious whether it requires no  
> pre-emption between the bounce and handler, or just no pre-emption  
> during the handler.

Just take a moment to think about this.

- Userspace raises an undefined instruction exception, running on CPU 0.
- The kernel starts to handle the exception by saving the ARM state.
- Enables interrupts.
- Context switch occurs.
- VFP state is saved and the VFP is disabled.

Now, on CPU1...
- Context switch occurs to the above thread (due to thread migration).
- VFP will be in a disabled state.
- We read FPEXC, find that the VFP is disabled
- Load saved state into the VFP
- Check for an exception recorded in the VFP state, and handle it.

So, that seems to work.  I suspect most things will work just fine in
this case.  What /can't/ be allowed to happen is we can't start
reading state from the hardware to handle the exception (or even be
mid-restoring the state) and be preempted - if we do, we'll end up
in a right mess because we'll end up with inconsistent state.

> What about the iwmmxt and the crunchbits? They are only lazy-enable  
> routines, to activate an inactive coprocessor. Which I think makes them  
> safe. If we schedule before reaching the handler, when this context is  
> returned to, the coprocessor must still be disabled in our context - the  
> handler can proceed to enable it. And there can't be any other context  
> state to worry about, assuming the lazy enable scheme works.

Again, the restore needs to happen with preemption disabled so that
you don't end up with the state half-restored, and then when you
resume the thread, you restore the other half.

This is actually the case I'm more worried about - whether all the
various handlers are safe being entered with preemption enabled.
They weren't written for it so the current answer is that they
aren't safe.

> I share Alexey's Ignatov's concern that your patch ends up running the  
> support code with interrupts either on or off depending on whether you  
> came from user or supervisor mode, which feels a little odd. But then,  
> always enabling interrupts like the current code does, when they might  
> have been off in the SVC mode context, also seems wrong.

That is indeed wrong, but then we /used/ to have the requirement that
the kernel will _never_ execute VFP instructions.  That's changed
recently since we now permit neon instructions to be executed.

However, the requirements to execute these instructions is very strict:
preemption disabled, it must not fault.  If you do fault, none of the
standard handlers get invoked, instead you get a critical kernel message.
So, if it does happen, then it's quite a bug already.

The only case where the kernel intentionally provokes such a fault
(which won't even reach the normal VFP handler) is when testing for the
presence of VFP and there is no hardware fitted.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
