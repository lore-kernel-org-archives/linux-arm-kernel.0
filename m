From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 07 Oct 2011 02:41:41 +0530
Subject: [PATCH 0/2] arm: samsung: add device tree support for gic and
	interrupt combiner
Message-ID: <1317935503-11756-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds device tree support for GIC and Interrupt Combiner
controllers in the Exynos4 SoC.

Patch 1 moves the statically mapped timer irqs 11 to 15 to the end of the
statically mapped linux irq space for all s5p platforms. This was required
because, device tree support for gic is based on Rob Herring's "GIC OF
bindings" patchset and that patchset requires hardware irq number to be
equal to GIC interrupt ID. Since GIC interrupt ID starts from zero, the
timer irqs 11 to 15 is moved to the end of the irq space and hardware irqs
are statically mapped to start from zero. I am not sure if statically
mapping hardware irqs starting from zero would be a problem.

Patch 2 adds device tree support for GIC and Interrupt Combiner controllers
on Exynos4. For GIC controller, this patch is based on Rob Herring's,
"[PATCH 0/3] GIC OF bindings" patchset. The concept of irq domain for
interrupt combiner controller is based on Grant's 'simple' irq converter

Thomas Abraham (2):
  arm: samsung: move timer irq numbers to end of linux irq space
  arm: exynos4: add support for dt irq specifier to linux virq conversion

 arch/arm/mach-exynos4/cpu.c                      |   20 +++++++++-
 arch/arm/mach-exynos4/include/mach/entry-macro.S |    1 -
 arch/arm/mach-exynos4/include/mach/irqs.h        |    3 +-
 arch/arm/mach-exynos4/irq-combiner.c             |   44 ++++++++++++++++++++++
 arch/arm/mach-s5p64x0/include/mach/irqs.h        |    4 +-
 arch/arm/mach-s5pc100/include/mach/irqs.h        |    3 +-
 arch/arm/mach-s5pv210/include/mach/irqs.h        |    3 +-
 arch/arm/plat-samsung/include/plat/irqs.h        |    7 ++-
 8 files changed, 72 insertions(+), 13 deletions(-)
