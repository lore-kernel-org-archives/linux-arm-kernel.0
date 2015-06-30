From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 30 Jun 2015 09:45:20 +0200
Subject: [PATCH 0/7] ARM: shmobile: Move gpio ranges from C code to DT
Message-ID: <1435650327-2542-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Linus, Alex, Laurent, Simon, Magnus,

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
  c. Patches 5-7 do a few more cleanups in the sh-pfc gpio code.

Dependencies:
  - This series applies against next-next-20150630.
  - Part a must go in first, to avoid regressions.
    In addition, it's a prerequisite for "ARM: shmobile: armadillo800eva
    dts: Add pinctrl and gpio-hog for lcdc0", which has been queued up
    already in Simon's dt-for-v4.3 branch. Perhaps it can still be
    reordered?
  - While I didn't notice any bad behavior by having part a only, part b
    should go in immediately after part a. Hence I think it's best if
    Simon can take this one, too.
  - Part c is independent (it doesn't touch the same code), so it can go
    in before or after the other parts, or in parallel.

Thanks for applying!

Geert Uytterhoeven (7):
  ARM: shmobile: r8a73a4 dtsi: Add missing "gpio-ranges" to gpio node
  ARM: shmobile: r8a7740 dtsi: Add missing "gpio-ranges" to gpio node
  ARM: shmobile: sh73a0 dtsi: Add missing "gpio-ranges" to gpio node
  pinctrl: sh-pfc: Stop calling gpiochip_add_pin_range() on DT platforms
  pinctrl: sh-pfc: Remove empty gpio_function_free()
  pinctrl: sh-pfc: Move sh_pfc_add_gpiochip() up
  pinctrl: sh-pfc: Confine legacy function GPIOs to SH

 arch/arm/boot/dts/r8a73a4.dtsi  |   7 +++
 arch/arm/boot/dts/r8a7740.dtsi  |   1 +
 arch/arm/boot/dts/sh73a0.dtsi   |   3 +
 drivers/pinctrl/sh-pfc/core.h   |   2 +
 drivers/pinctrl/sh-pfc/gpio.c   | 128 ++++++++++++++++++++++------------------
 drivers/pinctrl/sh-pfc/sh_pfc.h |   2 +
 6 files changed, 87 insertions(+), 56 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
