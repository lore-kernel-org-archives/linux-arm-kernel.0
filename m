From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 24 Mar 2012 15:03:01 +0530
Subject: [PATCH v5 0/2] ARM: Exynos: Add irq_domain and device tree support for
 combiner
Message-ID: <1332581583-16100-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v4:
- In patch 2/2, removed the #ifdef CONFIF_OF around irq_of_parse_and_map() as
  suggested by Grant Likely. Hence this patch series depends on the patch
  with subject "of/irq: add empty irq_of_parse_and_map() for non-dt builds".

- Rebased to the latest kgene/for-next branch which now includes support for
  Exynos5. Since this patchset modifies portions of code that are common for
  both Exynos4 and Exynos5, there are minor modifications in this patch series
  to accommodate Exynos5 dt support as well.

- v4 of this patchset was acked by Grant Likely and Rob Herring. This patch
  series (v5) has minor modifications over v4 to include Exynos5 support. Since
  those modifications are minor (not related to irq_domain or dt functionality),
  I am retaining the Ack from Grant and Rob for this series.

Changes since v3:
- In dt case, the use of fixed gic linux irq number to map the combiner
  interrupt output is removed. This is replaced with the interrupt number
  obtained from the gic irq domain. (Thanks to Rob Herring and Grant
  Likely for this suggestion).
- Split the patch into two parts - irq_domain and device tree support
  addition.

Changes since v2:
- Rebased to Grant's irqdomain/next branch.

Changes since v1:
- Includes all changes suggested by Rob Herring.
- Tested with SPARSE_IRQ enabled.

This patchset adds irq_domain and device tree support for the Exynos Interrupt
Combiner controller.

The first patch adds a common irq domain for the interrupts managed by the
interrupt combiners. All the instances of irq combiner reference the common irq
domain for translating hardware interrupts to linux irq number.

The second patch adds a interrupt specifier translator to support device tree
based instantiation. It can translate interrupt specifiers for device nodes
which use combiner as their interrupt parent.

This patchset is based on
http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git [for-next]

with all patches merged from
http://git.secretlab.ca/git/linux-2.6.git [irqdomain/next]

Thomas Abraham (2):
  ARM: Exynos: Add irq_domain support for interrupt combiner
  ARM: Exynos: Add device tree support for interrupt combiner

 .../bindings/arm/samsung/interrupt-combiner.txt    |   52 ++++++++
 arch/arm/mach-exynos/common.c                      |  138 ++++++++++++++-----
 2 files changed, 153 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/interrupt-combiner.txt
