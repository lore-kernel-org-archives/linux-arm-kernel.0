From: kevin@bracey.fi (Kevin Bracey)
Date: Thu, 06 Feb 2014 20:10:44 +0200
Subject: [PATCH] ARM: enable IRQs in user undefined instruction vector
In-Reply-To: <20140206112039.GA31054@arm.com>
References: <1391545146-8320-1-git-send-email-kevin@bracey.fi>
 <20140206112039.GA31054@arm.com>
Message-ID: <52F3D024.5020804@bracey.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2014 13:20, Catalin Marinas wrote:
> On Tue, Feb 04, 2014 at 10:19:06PM +0200, Kevin Bracey wrote:
>> See http://comments.gmane.org/gmane.linux.ports.arm.omap/59256 for
>> an earlier report of the observed might_sleep() warning.
> There was a follow-up on this:
>
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/263765

Thanks for that pointer - we failed to find that thread. And from it I 
see I totally missed the iwmmxt path. :(

>   __und_usr:
>   	usr_entry
> +	enable_irq
> The problem is that you can be preempted here and parts of the kernel
> may not cope with this.

A very close analogue to this code is vector_swi. As far as I can see, 
having interrupts+preemption enabled in this __und_usr section should be 
as safe as it is there, so I'm pretty confident there shouldn't be a 
general kernel issue. But...

> The reason I haven't pushed my patches to mainline is that I was worried
> about such preemption cases. We enter iwmmxt_task_enable for example
> with interrupts and preemption enabled, we disable preemption there but
> is it too late? I don't have a way to test these and even for VFP I'm
> not sure testing would guarantee it in all scenarios.

The only concern I can see - and it's a big one - is that of how a HW 
coprocessor responds. If the coprocessor bounces an instruction, and we 
switch context before reaching the support code, will the hardware and 
its support code cope - both with switching to another context in that 
state, and handling the original bounce in this context when we get back?

I know that because they're asynchronous, the FPA+VFP have always had to 
cope with possible pre-emption in the window between them deciding they 
need support and their next opportunity to bounce an instruction; but 
what if they get pre-empted between a bounce being generated and the 
support code processing it?

The VFP code did take pains to increment the pre-emption count before 
enabling interrupts, but it's not obvious whether it requires no 
pre-emption between the bounce and handler, or just no pre-emption 
during the handler.

For the FPA, we only have FPA emulation, not FPA support code, so 
nothing to worry about there.

What about the iwmmxt and the crunchbits? They are only lazy-enable 
routines, to activate an inactive coprocessor. Which I think makes them 
safe. If we schedule before reaching the handler, when this context is 
returned to, the coprocessor must still be disabled in our context - the 
handler can proceed to enable it. And there can't be any other context 
state to worry about, assuming the lazy enable scheme works.

Personally, I've always wondered why ARM never implemented a CP15 
register you could read to find out what instruction generated a SWI or 
undefined instruction exception, to save all this hassle. It's always 
seemed to me like an obvious addition, ever since the I+D caches were 
split; why do I have to load my code into the data cache?

> So it needs more thinking. Please have a look at my patches, if we get
> to the conclusion there is no issue, I'll push them upstream.
>
I think if there's a problem, it will be in the VFP code - the others 
seem straightforward.  The interrupt enable has to be made safe - as 
long as another core can age a page before the handler is reached, the 
VFP support code will /have/ to be able to cope with pre-emption between 
the fault and handler, if it doesn't already. We need a VFP expert to 
figure it out properly.

We will stress test your posted patch for our failure case, which is 
Android skipping VFP instructions thanks to the extra irqs_disabled() 
patch in do_page_fault().

I think we should also include the fixup handler modification from my 
patch -  I think __und_usr having a fixup handler that skips the 
instruction if do_page_fault fails is just asking for trouble, so it 
should be aligned with vector_swi so it retries.

I share Alexey's Ignatov's concern that your patch ends up running the 
support code with interrupts either on or off depending on whether you 
came from user or supervisor mode, which feels a little odd. But then, 
always enabling interrupts like the current code does, when they might 
have been off in the SVC mode context, also seems wrong.

I did ponder for my version whether the __und_svc path should restore 
original IRQ status before going to call_fpe, to make the handler entry 
environment more uniform -  IRQ status would always be as in original 
context.

Maybe it's a fine detail, as we don't really expect to be handling any 
of these instructions from the kernel anyway, but if we are going to the 
trouble to send __und_svc to handlers rather than going straight to 
__und_svc_fault...

Kevin
