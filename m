From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 18 Mar 2015 11:01:21 +0000
Subject: [PATCH v4 0/3] genirq: Saving/restoring the irqchip state of an irq
 line
Message-ID: <1426676484-21812-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Despite Linux offering a rather fine grained control over the life
cycle of an interrupt, there is a few cases where it would be very
useful to snapshot (or even set) the internal state of the interrupt
controller for a given interrupt line:

- With KVM, a device shared between VMs must have its whole context
  switched, and that includes the interrupt line state. KVM/arm is
  moving to using this.
- Some GPIO controllers seem to require peeking into the interrupt
  controller they are connected to to report their internal state.

Instead of letting people facing this situation doing horrible
(controller specific) hacks in their code, let's offer a couple of new
entry points that allow a few attributes to be read and set.

Of course, this is a very dangerous thing to do if you don't know what
you doing, and I wouldn't expect most drivers to use this. But this
can also be a life saver at times.

This patch series implement said API, and adds support for this to the
two main ARM interrupt controllers (GIC and GICv3). Available at:

git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/irqchip_state

This has been fairly heavily tested with KVM on ARM, which makes use
of this feature to context switch the timer interrupt (see the last
three patch in the above branch).

Thanks,

	M.

* From v3 [3]
- Rebased on top of 4.0-rc4

* From v2 [2]:
- Rebased on top of 3.19-rc3
- Fixed irq_set_irqchip_state return value

* From v1 [1]:
- Rebased on top of 3.18-rc7 + tip/irq/irqdomain-arm
- Now deals with stacked domains
- Changed the API to be less ambiguous (after review by tglx)
- Added IRQCHIP_STATE_LINE_LEVEL (as requested by Bjorn Anderson)

[1] https://lkml.org/lkml/2014/10/25/134
[2] https://lkml.org/lkml/2014/12/3/612
[3] http://lkml.iu.edu/hypermail/linux/kernel/1501.0/03473.html

Marc Zyngier (3):
  genirq: Allow the irqchip state of an IRQ to be save/restored
  irqchip: GIC: Add support for irq_{get,set}_irqchip_state
  irqchip: GICv3: Add support for irq_{get,set}_irqchip_state

 drivers/irqchip/irq-gic-v3.c | 83 +++++++++++++++++++++++++++++++++-------
 drivers/irqchip/irq-gic.c    | 69 +++++++++++++++++++++++++++++++--
 include/linux/interrupt.h    | 14 +++++++
 include/linux/irq.h          |  6 +++
 kernel/irq/manage.c          | 91 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 246 insertions(+), 17 deletions(-)

-- 
2.1.4
