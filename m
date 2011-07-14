From: ccross@google.com (Colin Cross)
Date: Wed, 13 Jul 2011 18:43:13 -0700
Subject: IRQCHIP_MASK_ON_SUSPEND and the gic
Message-ID: <CAMbhsRS=Pu-VoLFZR162DEjTVsx_f8X0S5zX09c8bDnfDq4=Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quick background:
The gic is an interrupt controller commonly found in SMP ARM devices.
It has no power management capabilities, and is turned off when the
cpu is powered down in suspend.  In order to wake the device out of
suspend, a second interrupt controller is placed in series with the
gic, passing each interrupt through along with a mask.  If an unmasked
interrupt is received at the secondary controller, and the cpu is
powered down, a wakeup is triggered.

In order to keep the cpu from waking on masked interrupts during
cpuidle, the secondary controller masks must be updated at the same
time as the gic masks.  This is handled through the gic_arch_extn
irqchip pointer that is filled out by each architecture.

During suspend, the same registers used by mask/unmask need to be
programmed to have all wakeup interrupts unmasked, and all non-wakeup
interrupts masked.  I believe the unmasking is already taken care of:
every interrupt starts as unmasked, and is lazily masked only when an
interrupt arrives while it is disabled.  When check_wakeup_irqs is
called in suspend, every interrupt is guaranteed to be either
unmasked, or masked and marked pending.  Pending wakeup irqs will
abort suspend, so every wakeup interrupt is guaranteed to be unmasked
after check_wakeup_irqs.

That leaves masking, which can easily be handled by setting the
IRQCHIP_MASK_ON_SUSPEND flag on the gic irqchip (propagated from the
gic_arch_extn irqchip).

So, finally, my question: there is nothing for each secondary
interrupt controller driver to do in a set_wake handler, but if its
not implemented, enable_irq_wake will return an error.  Is there any
way to avoid implementing an empty set_wake handler?  Should the
missing handler not be an error if IRQCHIP_MASK_ON_SUSPEND is set?
