From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Dec 2010 14:51:26 +0000
Subject: [RFC][PATCH] ARM: Add initial hibernation support for Cortex
	A8 and A9
In-Reply-To: <AANLkTinFTAHzuEaLMn=xcevLCFvjga7RC6yztzC1fO5d@mail.gmail.com>
References: <1292910239-4313-1-git-send-email-myungjoo.ham@samsung.com>
	<AANLkTinFTAHzuEaLMn=xcevLCFvjga7RC6yztzC1fO5d@mail.gmail.com>
Message-ID: <20101221145126.GU28157@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 21, 2010 at 02:41:39PM +0000, Catalin Marinas wrote:
> We could follow the ARM ARM and define a save_context structure which
> has architected registers and implementation-defined ones. For the
> latter you could use a union inside this structure to differentiate
> between A8, A9 and other registers for different implementations.

No we shouldn't.  The architecture manual will tell you that you need
to save the entire universe (eg, IRQ-mode registers, VFP registers, etc.)

What we should have is the individual support files (eg, perf) saving
their own state at the appropriate time.  And there's two times that
subsystems need to save their state:

1. Hot unplug of a CPU.
2. Suspend.

I've recently added the necessary hotplug notifier to VFP.

With some intelligence, we can avoid saving many registers, such as the
non-SVC mode registers (by calling cpu_init() which re-sets the non-SVC
mode registers up as we want them to be), the VFP registers (which we
save into the thread context save structure if they're not already
saved there.)

The same should be true of things like perf.

Things like the control register we already have the value cached, so
there's little point saving another copy of it.

What we should also have is a callback into the proc-*.S files for
them to save the processor specific registers such as the TTB registers.

And then, with non-secure mode, we run into issues about which registers
we _can_ sanely read and write.

What I'm saying is that rather than copying stuff verbatim from the
ARM ARM, _think_ first and see what is actually necessary.
