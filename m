From: robherring2@gmail.com (Rob Herring)
Date: Fri,  3 Feb 2012 16:35:08 -0600
Subject: [PATCH v4 0/4] generic irq chip domain support
Message-ID: <1328308512-22594-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This series adds irq domain support for generic irq chip and updates
pl061 gpio and imx tzic to use it.

Once again, this is has been significantly re-worked from the previous
version. It's simply not possible to add domain support in a transparent
way. So now a wrapper function is added to setup a domain and alloc and
setup N gen irq chips.

There was some discussion about supporting multiple banks of less than 32
irqs per bank. Looking at all users of generic irq chip, this doesn't
appear to be needed. All users are either a single generic irq chip per
node or have 32 irqs per bank. Both are supported by this patch series.
If bank masking is needed, it can be added later.

This is based on Grant Likely's irq domain work and is available here:

git://sources.calxeda.com/kernel/linux.git pl061-domain-v4

Rob

Rob Herring (4):
  ARM: kconfig: always select IRQ_DOMAIN
  irq: add irq_domain support to generic-chip
  ARM: imx: add irq domain support to tzic
  gpio: pl061: enable interrupts with DT style binding

 .../devicetree/bindings/gpio/pl061-gpio.txt        |   15 ++
 arch/arm/Kconfig                                   |    2 +-
 arch/arm/common/Kconfig                            |    2 -
 arch/arm/plat-mxc/tzic.c                           |   23 ++--
 drivers/gpio/gpio-pl061.c                          |   48 +++---
 include/linux/irq.h                                |   15 ++
 kernel/irq/generic-chip.c                          |  154 +++++++++++++++++---
 7 files changed, 198 insertions(+), 61 deletions(-)

-- 
1.7.5.4
