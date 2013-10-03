From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu,  3 Oct 2013 14:19:17 +0200
Subject: [PATCH v3 0/4] watchdog: at91sam9_wdt: handle already configured wdt
Message-ID: <1380802761-32279-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series is a porposal to enhance the sam9 watchdog timer support.

The at91sam9 watchdog timer can only be configured once, and the current
implementation tries to configure it in a static way:
- 2 seconds timeout
- wdt restart every 500ms

If the timer has already been configured with different values, it returns an
error and do not create any watchdog device.

This is not critical if the watchdog is disabled, but if it has been enabled
with different timeout values it will lead to a SoC reset.

This patch series tries to address this issue by adapting the heartbeat value
according the WDT timer config:
- it first tries to configure the timer as requested.
- if it fails it fallbacks to the current config, adapting its heartbeat timer
to the needs

This patch series also move to a dynamically allocated at91wdt device instead
of the static instance. I'm not sure this is the best solution, so please tell
me if you prefer to keep static instance of watchdog.

It adds a new at91 wdt type: software. This new type make use of the at91 wdt
interrupt to trigger a software reboot.

Finally it adds several properties to the device tree bindings.

Best Regards,
Boris

Changes since v2:
 - fix documentation
 - rework the heartbeat computation to get a more flexible behaviour
 - fix xx_to_yy macros
 - modify warning and error messages
 - remove unneeded parenthesis in arithmetic operations
 - use devm functions to map io memory
 - remove unneeded devm_kfree calls

Change since v1:
 - fix typo in documentaion
 - fix irq dt definition for sama5d3 SoC

Boris BREZILLON (4):
  watchdog: at91sam9_wdt: better watchdog support
  watchdog: at91sam9_wdt: update device tree doc
  ARM: at91/dt: add sam9 watchdog default options to SoCs
  ARM: at91/dt: add watchdog properties to kizbox board

 .../devicetree/bindings/watchdog/atmel-wdt.txt     |   30 +-
 arch/arm/boot/dts/at91sam9260.dtsi                 |    5 +
 arch/arm/boot/dts/at91sam9263.dtsi                 |    5 +
 arch/arm/boot/dts/at91sam9g45.dtsi                 |    5 +
 arch/arm/boot/dts/at91sam9n12.dtsi                 |    5 +
 arch/arm/boot/dts/at91sam9x5.dtsi                  |    5 +
 arch/arm/boot/dts/kizbox.dts                       |    6 +
 arch/arm/boot/dts/sama5d3.dtsi                     |    5 +
 drivers/watchdog/at91sam9_wdt.c                    |  301 ++++++++++++++------
 9 files changed, 282 insertions(+), 85 deletions(-)

-- 
1.7.9.5
