From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 12 Apr 2011 20:32:08 +0200
Subject: [RFC PATCH] Current status, suspend-to-disk support on ARM
In-Reply-To: <alpine.DEB.2.00.1104121636460.29883@localhost6.localdomain6>
References: <alpine.DEB.2.00.1104041424310.690@localhost6.localdomain6>
	<20110412055958.GA3507@ucw.cz>
	<alpine.DEB.2.00.1104121636460.29883@localhost6.localdomain6>
Message-ID: <20110412183208.GC26916@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >>There's one ugly thing in this set - I've changed a generic kernel
> >>header, <linux/suspend.h> to #define save/restore_processor_state()
> >>on ARM so that it only does preempt_disable/enable(). It's
> >>surprising that this isn't the default behaviour; all platforms need
> >>swsusp_arch_suspend/resume anyway so why force the existance of
> >>_two_ arch-specific hooks ?
> >
> >Can you submit separate patch cleaning it up?
> 
> How about the attached ?
> 
> It's for discussion, and hence not tested (admittedly, I need an x86
> test system ...).
...

> I've also been wondering:
> The comments in kernel/power/hibernate.c mention the need to get
> preempt counts "right" as major motivator to call
> save/restore_processor_state.
> effect" of save/restore_processor_state).
> 
> But then on all architectures in kernels as far back as 2.6.32 it
> doesn't look like save/restore_processor state are actually
> adjusting the preempt count; nowhere do they call
> preempt_enable/disable.

You might need to dig a bit more. IIRC it manipulated FPU or something
long time ago.

> Finally, on things like e.g. the floating point context saves:
> Wouldn't this happen as part of freezing processes (in the early
> stages of suspend), and/or as part of device quiesce ?

Are you sure? I thought we have (had?) concept of lazy FPU
saving... and occassionaly kernel uses FPU too (with some
precautions).

> >>@@ -195,6 +195,14 @@ config VECTORS_BASE
> >> 	help
> >> 	  The base address of exception vectors.
> >>
> >>+config ARCH_HIBERNATION_POSSIBLE
> >>+	bool
> >>+	help
> >>+	  If the machine architecture supports suspend-to-disk
> >>+	  it should select this automatically for you.
> >>+	  Otherwise, say 'Y' at your own peril.
> >>+
> >
> >Good for debugging, but not good for mainline.
> 
> How would this be done better ?

Just set the ARCH_HIBERNATION_POSSIBLE=y in the ARM code now that ARM
can do it. No need to ask user.

> @@ -412,8 +413,7 @@ static int resume_target_kernel(bool platform_mode)
>  	if (error)
>  		goto Enable_irqs;
>  
> -	/* We'll ignore saved state, but this gets preempt count (etc) right */
> -	save_processor_state();
> +	preempt_disable();
>  	error = restore_highmem();
>  	if (!error) {
>  		error = swsusp_arch_resume();

Yep. save_processor_state() on x86 does kernel_fpu_begin(), and than
one needs to be balanced IIRC.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
