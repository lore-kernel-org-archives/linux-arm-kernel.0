From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Oct 2015 15:23:50 +0200
Subject: [PATCH 0/5] Fix regression introduced by set_irq_flags() removal
Message-ID: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas, Jason, Marc, Rob,

In commit d17cab4451df ("irqchip: Kill off set_irq_flags usage"), Rob
Herring modified the irqchip drivers to not use the ARM-specific
set_irq_flags() and instead rely on various functions provided by the
core irq subsystem.

While his commit was supposed to have no functional effect, it in fact
does have one effect: the IRQ_NOAUTOEN flag used to be *cleared* for
all interrupts and it is now *set* by default.

Thanks to this flag being *cleared* by default, the irq-armada-370-xp
was able to properly re-enable per-CPU interrupts at resume time. Now
that this flag is *set*, the irqd_irq_disabled() function no longer
indicates that such per-CPU interrupts are enabled (and in fact a
CPU-global flag to tell whether a per-CPU is enabled or not is
silly). Due to this, our local timer per-CPU interrupt is no longer
re-enabled at resume time on Armada XP, on the boot CPU, which causes
a hang at resume time.

This is a regression between 4.2 (where suspend/resume works fine) and
4.3-rc (where suspend/resume is broken). Reverting d17cab4451df1 on
top of 4.3-rc makes the problem go away (of course you also need to
revert eb811129ed9ea so that set_irq_flags is re-introduced).

The minimal fix would be to clear the IRQ_NOAUTOEN flag so that we get
back to the original situation. However, this does not really seem
like the right fix.

Instead, this patch series proposes to add an is_enabled_percpu_irq()
function to the core irq subsystem, which is then used by the
irq-armada-370-xp to find out if such or such per-CPU interrupt should
be re-enabled at resume time on the boot CPU.

The organization of the patch series is as follows:

 - PATCH 1 introduces the is_enabled_percpu_irq() function.

 - PATCH 2 does a minor refactoring of armada_xp_mpic_secondary_init()
   to prepare the following patch.

 - PATCH 3 changes the irq-armada-370-xp driver to use the
   is_enabled_percpu_irq() to re-enable the per-CPU interrupts on the
   boot CPU at resume time, and also modifies the secondary CPU
   notifier to re-enable per-CPU interrupts if needed.

 - PATCH 4 and 5 are further cleanups/improvements to the
   irq-armada-370-xp, which are not needed to fix the problem.

Since this is fixing a regression introduced between 4.2 and 4.3-rc,
it would be great if patches 1 to 3 could be merged in 4.3. The last
two patches are only cosmetic, so merging them for 4.4 is of course
the way to go.

Thanks,

Thomas

Thomas Petazzoni (5):
  kernel: irq: implement is_enabled_percpu_irq()
  irqchip: armada-370-xp: prepare additions to
    armada_xp_mpic_secondary_init()
  irqchip: armada-370-xp: re-enable per-CPU interrupts at resume time
  irqchip: armada-370-xp: re-order register definitions
  irqchip: armada-370-xp: document the overall driver logic

 drivers/irqchip/irq-armada-370-xp.c | 151 +++++++++++++++++++++++++++++++-----
 include/linux/interrupt.h           |   1 +
 kernel/irq/chip.c                   |   5 ++
 kernel/irq/internals.h              |   1 +
 kernel/irq/manage.c                 |  19 +++++
 5 files changed, 158 insertions(+), 19 deletions(-)

-- 
2.6.2
