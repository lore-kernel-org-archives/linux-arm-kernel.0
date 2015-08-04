From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  4 Aug 2015 15:55:13 +0200
Subject: [PATCH v2 0/6] ARM: shmobile: Move gpio ranges from C code to DT
Message-ID: <1438696519-13727-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series moves the setup of the GPIO-PFC pin mapping for
Renesas PFC/GPIO combos from C code to DT, and does some cleanups.
The move to DT is needed to make the GPIO hogging mechanism work, cfr.
the discussion following "[PATCH] [RFC] gpio: Retry deferred GPIO
hogging on pin range change" (https://lkml.org/lkml/2015/6/16/455).

The series consists of 3 parts:
  a. Patches 1-3 add the missing "gpio-ranges" properties to the dtsi
     files for all affected SoCs,
  b. Patch 4 disables the C code to set up the mapping on DT platforms
     (it's still needed on SH or ARM-legacy),
  c. Patches 5-6 do a few more cleanups in the sh-pfc gpio code.

Changes compared to v1 ("[PATCH 0/7] ARM: shmobile: Move gpio ranges
from C code to DT",
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/353124.html):
  - Add check for CONFIG_OF and pfc->dev->of_node,
  - #ifdef out the code instead of introducing helper and dummy
    functions,
  - Drop "pinctrl: sh-pfc: Move sh_pfc_add_gpiochip() up", as it's no
    longer needed due to the #ifdefs,
  - Add Acked-by.

Dependencies:
  - This series applies against renesas-devel-20150803-v4.2-rc5,
  - Part a must go in first, to avoid regressions,
  - While I didn't notice any bad behavior by having part a only, part b
    should go in immediately after part a. Hence I think it's best if
    Simon can take this one, too.
  - Part c is independent (it doesn't touch the same code), so it can go
    in before or after the other parts, or in parallel.

Given this fixes the LCD on r8a7740/armadillo, which is a regression
introduced by the removal of armadillo-legacy support, I think at least
patch 2 should be queued for v4.3.

Thanks for applying!

Geert Uytterhoeven (6):
  ARM: shmobile: r8a73a4 dtsi: Add missing "gpio-ranges" to gpio node
  ARM: shmobile: r8a7740 dtsi: Add missing "gpio-ranges" to gpio node
  ARM: shmobile: sh73a0 dtsi: Add missing "gpio-ranges" to gpio node
  pinctrl: sh-pfc: Stop calling gpiochip_add_pin_range() on DT platforms
  pinctrl: sh-pfc: Remove empty gpio_function_free()
  pinctrl: sh-pfc: Confine legacy function GPIOs to SH

 arch/arm/boot/dts/r8a73a4.dtsi  |  7 ++++++
 arch/arm/boot/dts/r8a7740.dtsi  |  1 +
 arch/arm/boot/dts/sh73a0.dtsi   |  3 +++
 drivers/pinctrl/sh-pfc/core.h   |  2 ++
 drivers/pinctrl/sh-pfc/gpio.c   | 49 +++++++++++++++++++++++------------------
 drivers/pinctrl/sh-pfc/sh_pfc.h |  2 ++
 6 files changed, 43 insertions(+), 21 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
