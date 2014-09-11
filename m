From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 11 Sep 2014 10:55:59 +0200
Subject: [PATCH v3 0/8] rtc: at91sam9: add DT support
Message-ID: <1410425767-17874-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds DT support to the atmel at91sam9 RTC driver.

It also removes any machine specific inclusions to prepare the migration
to multi platform kernel support, and retain the slow clock to prevent
the CCF from disabling it at the end of boot.

Johan, let me know if this version addresses part of your concerns.
I'm open to any suggestion/rework to address other previously discussed
issues, as long as it does not end up in a dead-end (like the discussion
you had last year):
 - the fact that the RTT block could be used for something that is not
   an RTC
 - the fact that referencing the GPBR node and defining a GPBR register
   number to store RTC time info could be considered as an HW config and
   not an HW description and thus should not be described in the DT
 - other things I don't remember :-)
  

Best Regards,

Boris

Changes since v2:
 - make use of syscon/regmap to avoid directly requesting/mapping a GPBR
   memory region in the RTT driver

Changes since v1:
 - remove non CCF specific case by adding the appropriate clk_lookup
   entries in arch/arm/mach-at91/<soc-name>.c files

Boris BREZILLON (8):
  rtc: at91sam9: remove references to mach specific headers
  rtc: at91sam9: use standard readl/writel functions instead of raw
    versions
  rtc: at91sam9: replace devm_ioremap by devm_ioremap_resource
  rtc: at91sam9: add DT support
  rtc: at91sam9: make use of syscon/regmap to access GPBR registers
  ARM: at91: add clk_lookup entry for RTT devices
  rtc: at91sam9: use clk API instead of relying on AT91_SLOW_CLOCK
  rtc: at91sam9: add DT bindings documentation

 .../devicetree/bindings/rtc/atmel,at91sam9-rtc.txt |  24 ++++
 arch/arm/mach-at91/at91sam9260.c                   |   2 +
 arch/arm/mach-at91/at91sam9261.c                   |   2 +
 arch/arm/mach-at91/at91sam9263.c                   |   4 +
 arch/arm/mach-at91/at91sam9g45.c                   |   2 +
 arch/arm/mach-at91/at91sam9rl.c                    |   2 +
 arch/arm/mach-at91/clock.c                         |   2 +-
 arch/arm/mach-at91/clock.h                         |   1 +
 drivers/rtc/Kconfig                                |   1 +
 drivers/rtc/rtc-at91sam9.c                         | 132 ++++++++++++++++-----
 10 files changed, 142 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt

-- 
1.9.1
