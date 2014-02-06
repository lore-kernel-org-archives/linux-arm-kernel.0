From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Feb 2014 11:20:39 +0000
Subject: [PATCH] ARM: enable IRQs in user undefined instruction vector
In-Reply-To: <1391545146-8320-1-git-send-email-kevin@bracey.fi>
References: <1391545146-8320-1-git-send-email-kevin@bracey.fi>
Message-ID: <20140206112039.GA31054@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 10:19:06PM +0200, Kevin Bracey wrote:
> If an abort occurs while loading an instruction from user space in
> __und_usr, the resulting do_page_fault() can output "sleeping function
> called from invalid context" warnings, due to IRQs being disabled in
> __und_usr, and hence in do_page_fault().
> 
> Avoid the problem by enabling IRQs in __und_usr before attempting to
> load the instruction, and modify code and comments in the undefined
> instruction handlers to note that IRQs are enabled on entry iff the
> instruction was executed in user mode.
> 
> See http://comments.gmane.org/gmane.linux.ports.arm.omap/59256 for
> an earlier report of the observed might_sleep() warning.

There was a follow-up on this:

http://thread.gmane.org/gmane.linux.ports.arm.kernel/263765

>  arch/arm/kernel/entry-armv.S       | 11 ++++++++---
>  arch/arm/mach-ep93xx/crunch-bits.S |  7 ++++++-
>  arch/arm/vfp/entry.S               |  2 +-
>  3 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index b3fb8c9..bed1567 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -399,6 +399,7 @@ ENDPROC(__irq_usr)
>  	.align	5
>  __und_usr:
>  	usr_entry
> +	enable_irq

The problem is that you can be preempted here and parts of the kernel
may not cope with this.

The reason I haven't pushed my patches to mainline is that I was worried
about such preemption cases. We enter iwmmxt_task_enable for example
with interrupts and preemption enabled, we disable preemption there but
is it too late? I don't have a way to test these and even for VFP I'm
not sure testing would guarantee it in all scenarios.

So it needs more thinking. Please have a look at my patches, if we get
to the conclusion there is no issue, I'll push them upstream.

-- 
Catalin
