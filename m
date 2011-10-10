From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 10 Oct 2011 13:41:26 +0530
Subject: [PATCH 0/3] ARM: Samsung: Add device tree support for GIC and
	Interrupt Combiner
Message-ID: <1318234289-22041-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds device tree support for GIC and Interrupt Combiner modules
in Exynos4 SoC.

Patch 1 moves the statically mapped timer irqs 11 to 15 to the end of the
statically mapped linux irq space for all s5p platforms. This patch is
applicable for s5p64x0, s5pc100, s5pv210 and exynos4.

For all these platforms, the five hardware timer irqs are connected to GIC/VIC
at some hardware irq number (in exynos it is GIC_ID 69 to 73 for five timers).
When any of these hardware interrupt occurs, its interrupt handler calls
generic_handle_irq() with linux irq number 11/12/13/14/15 for timer 0/1/2/3/4
as the parameter. The code that needs to be notified about the timer interrupts
would have already registered its handler for either of the interrupts 11 to 15.

Instead of using linux irq number 11 to 15 to which consumers of timer interrupt
attach their handler, this interrupt range is moved to the end of linux irq
space used. So there will be no interrupts statically mapped between 0 to 31.

The GIC/VIC hardware interrupts, which were previously statically mapped to
start from linux irq 32 are now moved to start from linux irq 0. In case of
exynos, GIC_ID[0] (which is SGI[0]) which was previously at linux irq 32, will
not be at linux irq 0. This was required to use Rob Herring's GIC OF bindings
patches for Exynos4.

Patch 2 adds a interceptor for all ioremap calls targeted towards any of the
statically remapped memory region. This was required because the GIC OF
binding's patchset ioremaps the GIC memory-mapped regions in the gic_of_init()
function. Without this patch, there would be two separate remap for GIC
controller, one statically remapped and the other dynamically remapped by the
gic_of_init() function.

Patch 3 adds device tree support for GIC and Interrupt Combiner controllers on
Exynos4. For GIC controller, this patch is based on Rob Herring's,
"[PATCH 0/3] GIC OF bindings" patchset. The concept of irq domain for interrupt
combiner controller is based on Grant's 'simple' irq converter

This patchset is based on the following tree:
https://github.com/kgene/linux-samsung.git   branch: for-next

Patch 1 is tested on smdk6450, smdkc100, smdkv210.
Patch 1 to 3 are tested on smdkv310.


Thomas Abraham (3):
  arm: samsung: move timer irq numbers to end of linux irq space
  ARM: Exynos4: Add ioremap interceptor for statically remapped regions
  ARM: Exynos4: Add support for dt irq specifier to linux virq conversion

 .../devicetree/bindings/irq/samsung-combiner.txt   |   24 ++++++++++
 arch/arm/mach-exynos4/cpu.c                        |   36 +++++++++++++++-
 arch/arm/mach-exynos4/include/mach/entry-macro.S   |    1 -
 arch/arm/mach-exynos4/include/mach/io.h            |    4 ++
 arch/arm/mach-exynos4/include/mach/irqs.h          |    3 +-
 arch/arm/mach-exynos4/irq-combiner.c               |   45 ++++++++++++++++++++
 arch/arm/mach-s5p64x0/include/mach/irqs.h          |    4 +-
 arch/arm/mach-s5pc100/include/mach/irqs.h          |    3 +-
 arch/arm/mach-s5pv210/include/mach/irqs.h          |    3 +-
 arch/arm/plat-samsung/include/plat/irqs.h          |    7 ++-
 10 files changed, 117 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/irq/samsung-combiner.txt
