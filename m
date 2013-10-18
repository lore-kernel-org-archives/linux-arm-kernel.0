From: dianders@chromium.org (Doug Anderson)
Date: Fri, 18 Oct 2013 14:55:59 -0700
Subject: [PATCH v3 0/3] Prevent races when doing read-modify-write of INTMASK
In-Reply-To: <1382126905-14654-1-git-send-email-dianders@chromium.org>
References: <1382126905-14654-1-git-send-email-dianders@chromium.org>
Message-ID: <1382133362-31747-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bing Zhao at Marvell discovered a race in the way that dw_mmc was
doing a read-modify-write of the INTMASK register.  This 2-patch
series attempts to fix the problem using a simple spinlock.  In order
to do so cleanly, we include a patch to tidy up the way that we
disable low power mode when using SDIO interrupts.

This patch series was not tested on ToT Linux other than basic
compiling and booting, since we don't have the whole Marvell SDIO
stack up and running in mainline yet.  This series is based on
mmc-next (e76b855 mmc: sdhci-esdhc-imx: set actual_clock in clock
setting) merged atop mainlinx Linux.

Changes in v3:
- Add fixup to pandora_wl1251_init_card().

Changes in v2:
- Core patch new for this version.
- Fixed "|" to "&".
- intmask_lock renamed to irq_lock

Doug Anderson (3):
  mmc: core: Support the optional init_card() callback for MMC and SD
  mmc: dw_mmc: Cleanup disable of low power mode w/ SDIO interrupts
  mmc: dw_mmc: Protect read-modify-write of INTMASK with a lock

 arch/arm/mach-omap2/board-omap3pandora.c | 14 +++---
 drivers/mmc/core/mmc.c                   |  6 +++
 drivers/mmc/core/sd.c                    |  7 ++-
 drivers/mmc/host/dw_mmc.c                | 79 +++++++++++++++++++-------------
 drivers/mmc/host/dw_mmc.h                |  1 +
 include/linux/mmc/dw_mmc.h               |  6 +++
 6 files changed, 74 insertions(+), 39 deletions(-)

-- 
1.8.4
