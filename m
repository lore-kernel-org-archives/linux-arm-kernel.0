From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Mon, 13 Jun 2011 16:34:48 +0100 (BST)
Subject: [RFC PATCH v5] ARM hibernation / suspend-to-disk (fwd)
In-Reply-To: <20110613135649.GB8498@arm.com>
References: <alpine.DEB.2.00.1106131303290.25153@localhost6.localdomain6>
	<20110613122601.GC12325@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106131400090.25153@localhost6.localdomain6>
	<20110613135649.GB8498@arm.com>
Message-ID: <alpine.DEB.2.00.1106131546070.19778@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Jun 2011, Dave Martin wrote:

[ ... ]
> Santosh, Frank: to what extent do you think the OMAP suspend code could
> be abstracted using something like Colin's CPU pm notifier framework?
>
> I'd hope that at least some stuff can be abstracted out, but I don't
> understand the OMAP code intimately enough to be certain of that...
>
> We shouldn't expect to remove absolutely all the SoC specifics from
> suspend code, but the more we can hook into a generic framework, the
> better for everyone.
>
> Cheers
> ---Dave
>

Hi Dave,

you mean the patch set from this weekend ?

I've still got to read through all of that in detail (currently not 
getting the digest mails).

There's this thing which Russell keeps on pointing out, that a SoC is more 
than a CPU core and even a CPU core is more than just the ARM itself ... 
and power management somehow needs dealing with all...


To me, the picture looks a bit like:

 	- the "inner" thing which is the ARMv[4567] control register set

 	- the "semi-inner" thing which are SoC core control regs outside
 	  of what is generic ARMv[4567], and/or which behave differently
 	  from that due to SoC spec / errata / ...
 	  "Secure state" probably fits amongst this as well.

 	- the "semi-outer" parts like optional ARM features (cache, VFP,
 	  Neon, ...) which still have a generic spec

 	- the "outer" parts - builtin devices and their state, interrupt
 	  controller, clocks and regulator stuff, ...

This is unfortunately simplified and the separations between these aren't 
quite as clean.

It used to be so that as far as device drivers were dealing with 
suspend/resume the latter bit was done via sysdev/syscore and anything 
else delegated to a (SoC-specific) platform_suspend_ops entry.



Russell's changes for "generic CPU suspend/resume" get the innermost bits 
into common code, while Colin's changes allow for more of the outer parts 
within common code ?


Assuming I'm reading these things right, then the place where OMAP could 
possibly use Colin's CPU PM notifier changes would be to convert some of 
the code in omap_sram_idle() (the backbone for platform_suspend_ops on 
OMAP) to use it.

To use the OMAP code for illustration (could've quoted other SoC code as 
well, the kind of work to be done is similar but the details of what and 
how it's done are very different ...):


void omap_sram_idle(void)
{
[ ... ]
                                 omap3_per_save_context();
[ ... ]
                         omap3_core_save_context();
                         omap3_cm_save_context();
[ ... ]
         omap3_intc_prepare_idle();
[ ... ]

         _omap_sram_idle(omap3_arm_context, save_state);
         cpu_init();
[ ... ]
                         omap3_core_restore_context();
                         omap3_cm_restore_context();
                         omap3_sram_restore_context();
                         omap2_sms_restore_context();
[ ... ]
         omap3_intc_resume_idle();
[ ... ]
                         omap3_per_restore_context();
[ ... ]
}

Aren't things like these potential candidates to convert to Colin's 
framework, if one chooses so ?



While the place where OMAP might possibly be using Russell's generic 
cpu_suspend/resume were deeper down - within _omap_sram_idle. Note the _ - 
it's a function pointer actually evaluating to omap????_cpu_suspend.


So it's kind of a two-pronged attack to minimize the SoC-specific code, 
Colin's framework to extract common code from the "outer" parts and 
Russell's cpu_suspend/resume to extract common code from the "inner" 
parts.


Orthogonal problems / solutions ?

FrankH.
