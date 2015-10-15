From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Thu, 15 Oct 2015 13:07:32 +0200
Subject: l2c: Kernel panic in l2c310_enable() in non-secure mode
In-Reply-To: <561F7948.8080201@sigmadesigns.com>
References: <561E6407.6000002@sigmadesigns.com>
 <561E6B1F.1070701@sigmadesigns.com>
 <20151014174721.GR32532@n2100.arm.linux.org.uk>
 <561F7948.8080201@sigmadesigns.com>
Message-ID: <561F88F4.40401@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/2015 12:00, Marc Gonzalez wrote:

> On 14/10/2015 19:47, Russell King - ARM Linux wrote:
> 
>> Wrong.  Do _not_ enable FLZ in the Cortex-A9.  FLZ needs the L2 cache
>> enabled _before_ the Cortex A9.  This is not something you can do in
>> firmware/boot loader/etc.  It has to be done by the kernel when the L2
>> cache is initialised.
> 
> Can you tell me if the following setup is reasonable?
> 
> (The important thing to note is that I do have control over the firmware.)
> 
> l2c_enable and l2c_disable will hand control over to the firmware,
> which will handle the details of FLOZ:
> 
> When enabling the L2, firmware will:
> A1) set L2CC_reg1_aux_control[0] to 1
> A2) enable the L2
> A3) set CP15_ACTLR bits 1,2,3 to 1
> 
> When disabling the L2, firmware will:
> B1) clear CP15_ACTLR bits 1,2,3 to 0
> B2) disable the L2
> B3) clear L2CC_reg1_aux_control[0] to 0
> 
> Thus, on my platform, Linux would no longer need to write CP15_ACTLR.
> 
> Then I just need a platform-specific bool e.g. "firmware_handles_cp15_actlr"
> and check it where appropriate:
> 
> In enable:
> 	if (!firmware_handles_cp15_actlr && (aux & L310_AUX_CTRL_FULL_LINE_ZERO)) {
> 		set_auxcr(get_auxcr() | BIT(3) | BIT(2) | BIT(1));
> 		cpu_notifier(l2c310_cpu_enable_flz, 0);
> 	}
> 
> In disable:
> 	if (!firmware_handles_cp15_actlr && (l2x0_saved_regs.aux_ctrl & L310_AUX_CTRL_FULL_LINE_ZERO))
> 		set_auxcr(get_auxcr() & ~(BIT(3) | BIT(2) | BIT(1)));
> 
> 
> What do you think?

Come to think of it, instead of introducing this extra bool, I can
just ask the firmware author to set NSACR.NS_SMP, which effectively
turns the above set_auxcr() calls into NOPs. (And Rob noted that I'll
need that bit set anyway.)

That way, no changes are required in Linux, and everything magically
works as expected. I'll file an internal bug report.

One more question on this topic:

When Linux sees L310_AUX_CTRL_FULL_LINE_ZERO set, it then enables:

  bit3 = Write full line of zeros mode
  bit2 = L1 Prefetch enable
  bit1 = L2 Prefetch hint enable

Why are the "prefetch enable" features bundled in the operation?

Regards.
