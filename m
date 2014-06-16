From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Jun 2014 19:47:57 +0100
Subject: [RFC] Saving/Restoring the internal state of an interrupt
Message-ID: <539F3BDD.2090009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas, all,

Since ARM has grown some virtualization extensions, there is a
particular issue I've carefully avoided to address, and which is now
biting me exactly where you think it does.

Let's expose the problem:
- We have a per-CPU timer (the architected timer)
- This timer is shared across virtual machines
- We context-switch the state of the timer on entry/exit of the VM

The state of the timer itself is basically a control word and a
comparator value. Not much. Ah yes, one tiny detail: the state of the
interrupt controller (the GIC) is also part of the state.

This interrupt state is not the pending state, but the internal state
(called the "active" state), indicating if the interrupt is in
progress or not. If the interrupt is active (and configured as a level
interrupt), then the interrupt can't fire again until the guest EOIs
it (there is some special hardware dedicated to this).

So far, I got away with ignoring that state altogether by playing some
tricks in the timer control register (basically masking the interrupt
there). This worked fine until Ian found some interesting guest (QNX)
that falls over if someone masks the interrupt in the timer behind its
back. Fair enough.

So I'm back to square one and I have to context-switch that single
bit.

So far, I can see about three options:

- I can add a pair of exported functions:
  void gicv2_irq_set_active_state(struct irq_data *d, bool act)
  bool gicv2_irq_is_active(struct irq_data *d);

  that directly play with the state. Oh, and for GICv3 as well. And
  whatever comes after. It means that KVM has to know exactly the type
  of interrupt controller we're using (well, it already does), and call
  the right stuff.

- I can add similar function to struct irq_chip:
  void (*irq_set_state)(struct irq_data *d, void *data);
  void (*irq_get_state)(struct irq_data *d, void *data);

  and build a generic API on top of that. That's tempting, but I'm
  really not keen on the "void *data" crap, as it means KVM has to
  know the type of the opaque data anyway. Or we define what is the
  state of an interrupt, and I'm afraid there is as many definitions
  as there are interrupt controllers.

- The third possibility is that I go and duplicate parts of the two GIC
  drivers into KVM just to be able to save/restore these bits. Please
  pass the bucket around.

So far, I've prototyped the first option, but I'm seriously
questioning my own sanity. Any idea/opinion?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
