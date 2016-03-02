From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  2 Mar 2016 16:58:52 +0100
Subject: [PATCH 00/14] drivers: use __maybe_unused to hide pm functions
Message-ID: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I found many variations of the bug in these device drivers (and some
USB drivers I already send patches for in a separate series).

In each case, the power management operations structure conditionally
references suspend/resume functions, but the functions are hidden
in an incorrect #ifdef or not hidden at all.

We could try to correct the #ifdefs, but it seems easier to just
mark those functions as __maybe_unused, which has the same effect
but provides better compile-time test coverage and (subjectively)
looks a bit nicer.

I have a patch series that avoids all warnings in ARM randconfig
builds, and I have verified that all these patches fix a warning that
is still present in today's linux-next, and that they do not
introduce new warnings in any configuration I found.

Note that all these drivers are ARM specific, so I assume that
all portable drivers got fixed already when someone rand into
the problem on x86.

There are no dependencies between the patches, so I'd appreciate
subsystem maintainers to put them directly into their git trees.

	Arnd

Arnd Bergmann (14):
  pinctrl: at91: use __maybe_unused to hide pm functions
  irqchip: st: use __maybe_unused to hide st_irq_syscfg_resume
  power: ipaq-micro-battery: use __maybe_unused to hide pm functions
  power: pm2301-charger: use __maybe_unused to hide pm functions
  mfd: ipaq-micro: use __maybe_unused to hide pm functions
  dma: sirf: use __maybe_unused to hide pm functions
  hw_random: exynos: use __maybe_unused to hide pm functions
  scsi: mvumi: use __maybe_unused to hide pm functions
  amd-xgbe: use __maybe_unused to hide pm functions
  wireless: cw1200: use __maybe_unused to hide pm functions_
  input: spear-keyboard: use __maybe_unused to hide pm functions
  keyboard: snvs-pwrkey: use __maybe_unused to hide pm functions
  [media] omap3isp: use IS_ENABLED() to hide pm functions
  ASoC: rockchip: use __maybe_unused to hide st_irq_syscfg_resume

 drivers/char/hw_random/exynos-rng.c         | 10 ++++------
 drivers/dma/sirf-dma.c                      | 10 ++++------
 drivers/input/keyboard/snvs_pwrkey.c        |  4 ++--
 drivers/input/keyboard/spear-keyboard.c     |  6 ++----
 drivers/irqchip/irq-st.c                    |  2 +-
 drivers/media/platform/omap3isp/isp.c       | 13 +------------
 drivers/mfd/ipaq-micro.c                    |  2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-main.c   |  6 ++----
 drivers/net/wireless/st/cw1200/cw1200_spi.c |  9 ++-------
 drivers/net/wireless/st/cw1200/pm.h         |  9 +++++++--
 drivers/pinctrl/pinctrl-at91-pio4.c         |  4 ++--
 drivers/power/ipaq_micro_battery.c          |  4 ++--
 drivers/power/pm2301_charger.c              | 22 ++++++----------------
 drivers/scsi/mvumi.c                        |  4 ++--
 sound/soc/rockchip/rockchip_spdif.c         |  4 ++--
 15 files changed, 40 insertions(+), 69 deletions(-)

-- 
2.7.0
Cc: herbert at gondor.apana.org.au
Cc: k.kozlowski at samsung.com
Cc: dan.j.williams at intel.com
Cc: vinod.koul at intel.com
Cc: baohua at kernel.org
Cc: dmitry.torokhov at gmail.com
Cc: tglx at linutronix.de
Cc: jason at lakedaemon.net
Cc: marc.zyngier at arm.com
Cc: laurent.pinchart at ideasonboard.com
Cc: mchehab at osg.samsung.com
Cc: lee.jones at linaro.org
Cc: kvalo at codeaurora.org
Cc: ludovic.desroches at atmel.com
Cc: linus.walleij at linaro.org
Cc: sre at kernel.org
Cc: dbaryshkov at gmail.com
Cc: JBottomley at odin.com
Cc: martin.petersen at oracle.com
Cc: broonie at kernel.org
Cc: linux-crypto at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: dmaengine at vger.kernel.org
Cc: linux-input at vger.kernel.org
Cc: linux-media at vger.kernel.org
Cc: netdev at vger.kernel.org
Cc: linux-wireless at vger.kernel.org
Cc: linux-gpio at vger.kernel.org
Cc: linux-pm at vger.kernel.org
Cc: linux-scsi at vger.kernel.org
Cc: alsa-devel at alsa-project.org
Cc: linux-rockchip at lists.infradead.org
