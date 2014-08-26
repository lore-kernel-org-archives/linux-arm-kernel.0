From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Aug 2014 15:13:19 +0100
Subject: [PATCH 00/11] Fix arm64 issues highlighted by sparse and smatch
Message-ID: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

After the static checking talk at kernel summit, I felt empowered to go
and run sparse and smatch over the arm64 defconfig. As I anticipated,
this spotted a few issues in the arch code, so I've fixed up the ones
that aren't just noise in this series. Most are simply incorrect
address space annotations, but fixing these is useful for spotting real
issues in the future.

I don't think any of these fix critical bugs, but they all deserve to be
addressed. I tagged the compat watchpoint fix for stable, as that code
has been broken since we merged the architecture port.

Cheers,

Will

Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Jean Pihet <jean.pihet@linaro.org>

--->8

Will Deacon (11):
  KVM: ARM/arm64: fix non-const declaration of function returning const
  KVM: ARM/arm64: fix broken __percpu annotation
  KVM: ARM/arm64: avoid returning negative error code as bool
  KVM: ARM/arm64: return -EFAULT if copy_from_user fails in
    set_timer_reg
  KVM: vgic: return int instead of bool when checking I/O ranges
  KVM: vgic: declare probe function pointer as const
  irqchip: gic: make gic_default_routable_irq_domain_ops static
  irqchip: gic-v3: declare rdist as __percpu pointer to __iomem pointer
  arm64: ptrace: fix compat hardware watchpoint reporting
  arm64: ptrace: fix compat reg getter/setter return values
  arm64: perf: don't rely on layout of pt_regs when grabbing sp or pc

 arch/arm/include/asm/kvm_host.h        |  2 +-
 arch/arm/kvm/arm.c                     |  2 +-
 arch/arm/kvm/coproc.c                  |  2 +-
 arch/arm/kvm/guest.c                   |  2 +-
 arch/arm64/include/asm/hw_breakpoint.h |  1 -
 arch/arm64/include/asm/kvm_host.h      |  4 ++--
 arch/arm64/kernel/perf_regs.c          |  6 ++++++
 arch/arm64/kernel/ptrace.c             | 13 +++++++++----
 arch/arm64/kvm/guest.c                 |  2 +-
 arch/arm64/kvm/sys_regs.c              |  2 +-
 drivers/irqchip/irq-gic-v3.c           |  2 +-
 drivers/irqchip/irq-gic.c              |  2 +-
 virt/kvm/arm/vgic.c                    |  6 +++---
 13 files changed, 28 insertions(+), 18 deletions(-)

-- 
2.1.0.rc1
