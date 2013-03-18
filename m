From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Mon, 18 Mar 2013 15:00:46 +0100
Subject: [PATCH v3 0/9] refactoring for mask_cache
In-Reply-To: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com>
Message-ID: <1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,
here is a patchset to address the issue found with Orion, in incremental
stages as Thomas suggested.
a) we introduce the new fields and pointer (though only the shared one is used)
b) we convert all drivers to use it 
c) we rename the field so to force the use of the per-ct pointer
d) we add per-ct mask cache, provided the new flag 
   IRQ_GC_SEPARATE_MASK_REGISTERS is enabled
e) we enable the flag for orion-gpio and mvebu drivers

So even though I'm also providing changes for mvebu, I only
tested the patch on a 3.0.40 kernel with the plat-orion/gpio.c driver.
We currently do not have a working 3.6+ configuration for our Kirkwood
boards (3.6 is apparently where this mvebu gpio driver was introduced),
so I would be glad if someone could give it a try.
I also have no idea whether the three Marvell variants all have separate
mask registers (which is what the last patch assumes).

Gerlando Falauto (9):
  genirq: cosmetic: remove cur_regs
  genirq: add mask_cache and pmask_cache into struct irq_chip_type
  gpio: mvebu: convert to usage of *pmask_cache within irq_chip_type
  MIPS: JZ4740: convert to usage of *pmask_cache within irq_chip_type
  ARM: SAMSUNG: convert to usage of *pmask_cache within irq_chip_type
  genirq: rename mask_cache to shared_mask_cache
  genirq: handle separate mask registers
  orion-gpio: enable IRQ_GC_SEPARATE_MASK_REGISTERS
  gpio: mvebu: enable IRQ_GC_SEPARATE_MASK_REGISTERS

 arch/arm/plat-orion/gpio.c            |    3 +-
 arch/arm/plat-samsung/irq-vic-timer.c |    6 ++--
 arch/mips/jz4740/irq.c                |    3 +-
 drivers/gpio/gpio-mvebu.c             |   23 ++++++++------
 include/linux/irq.h                   |    9 ++++--
 kernel/irq/generic-chip.c             |   55 +++++++++++++++++++++------------
 6 files changed, 64 insertions(+), 35 deletions(-)

-- 
1.7.10.1
