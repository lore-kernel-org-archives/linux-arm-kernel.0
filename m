From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Jul 2011 09:49:01 +0100
Subject: [PATCH v8 00/14] Consolidating GIC per-cpu interrupts
Message-ID: <1309855755-6261-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current GIC per-cpu interrupts (aka PPIs) suffer from a number of
problems:

- They use a completely separate scheme to handle the interrupts,
  mostly because the PPI concept doesn't really match the kernel view
  of an interrupt.
- PPIs can only be used by the timer code, unless we add more low-level
  assembly code.
- The local timer code can only be used by devices generating PPIs,
  and not SPIs.
- At least one platform (msm) has started implementing its own
  alternative scheme.
- Some low-level code gets duplicated, as usual...

The proposed solution is to let the GIC code expose the PPIs as
something that the kernel can manage. Instead of having a single
interrupt number shared on all cores, make the interrupt number be
different on each CPU.

This enables the use of the normal kernel API (request_irq() and
friends) and the elimination of some low level code. It also serves as
the basis of the GIC device tree support code. On the other side, it
causes quite a bit of churn in the timer code.

Previous versions of this series have received ACKs from some platform
maintainers, but so far there has been very little comment on the core
code. As I now have quite a large number of patches relying on this
series (local timers as devices, device tree support for GIC and TWD),
I'd be grateful for at least a hint indicating that this is going in
the right direction. Or not.

This patch set is based on 3.0-rc5. Tested on PB-11MP, Tegra2
(Harmony) and SMDK-V310. Also available in the "gic_ppi_map" branch of
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
