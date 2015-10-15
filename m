From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Thu, 15 Oct 2015 12:00:40 +0200
Subject: l2c: Kernel panic in l2c310_enable() in non-secure mode
In-Reply-To: <20151014174721.GR32532@n2100.arm.linux.org.uk>
References: <561E6407.6000002@sigmadesigns.com>
 <561E6B1F.1070701@sigmadesigns.com>
 <20151014174721.GR32532@n2100.arm.linux.org.uk>
Message-ID: <561F7948.8080201@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/2015 19:47, Russell King - ARM Linux wrote:

> Wrong.  Do _not_ enable FLZ in the Cortex-A9.  FLZ needs the L2 cache
> enabled _before_ the Cortex A9.  This is not something you can do in
> firmware/boot loader/etc.  It has to be done by the kernel when the L2
> cache is initialised.

Can you tell me if the following setup is reasonable?

(The important thing to note is that I do have control over the firmware.)

l2c_enable and l2c_disable will hand control over to the firmware,
which will handle the details of FLOZ:

When enabling the L2, firmware will:
A1) set L2CC_reg1_aux_control[0] to 1
A2) enable the L2
A3) set CP15_ACTLR bits 1,2,3 to 1

When disabling the L2, firmware will:
B1) clear CP15_ACTLR bits 1,2,3 to 0
B2) disable the L2
B3) clear L2CC_reg1_aux_control[0] to 0

Thus, on my platform, Linux would no longer need to write CP15_ACTLR.

Then I just need a platform-specific bool e.g. "firmware_handles_cp15_actlr"
and check it where appropriate:

In enable:
	if (!firmware_handles_cp15_actlr && (aux & L310_AUX_CTRL_FULL_LINE_ZERO)) {
		set_auxcr(get_auxcr() | BIT(3) | BIT(2) | BIT(1));
		cpu_notifier(l2c310_cpu_enable_flz, 0);
	}

In disable:
	if (!firmware_handles_cp15_actlr && (l2x0_saved_regs.aux_ctrl & L310_AUX_CTRL_FULL_LINE_ZERO))
		set_auxcr(get_auxcr() & ~(BIT(3) | BIT(2) | BIT(1)));


What do you think?

Regards.
