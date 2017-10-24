From: opendmb@gmail.com (Doug Berger)
Date: Tue, 24 Oct 2017 12:54:44 -0700
Subject: [PATCH v2 0/7] gpio: brcmstb: improved interrupt and wake support
Message-ID: <20171024195451.30535-1-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set collects a number of improvements to the GPIO driver
used by Broadcom Set-Top-Box devices.

Primarily they are aimed at correcting problems with the interrupt
controller implementation, but they also extend the functionality for
waking on GPIO interrupts.

V2:
  - Added Linus' patch to remove pin2mask introduced between v1 and v2
  - Added additional detail to the commit messages based on feedback
  - Removed "gpio: brcmstb: enable masking of interrupts when changing
    type" at Gregory Fong's request.
  - renamed variables for consistent use of offset as relative to a bank
    and hwirq is relative to the device (i.e. first bank of a device)
  - renamed GIO_REG_COUNT to NUMBER_OF_GIO_REGISTERS for clarity
  - renamed regs to saved_regs for clarity
  - corrected multi-line comment style
  - used true and false instead of 1 and 0 with bool type
  - converted wake_mask to need_wakeup_event boolean for clarity

Doug Berger (6):
  gpio: brcmstb: allow all instances to be wakeup sources
  gpio: brcmstb: release the bgpio lock during irq handlers
  gpio: brcmstb: switch to handle_level_irq flow
  gpio: brcmstb: correct the configuration of level interrupts
  gpio: brcmstb: consolidate interrupt domains
  gpio: brcmstb: implement suspend/resume/shutdown

Linus Walleij (1):
  gpio: brcmstb: Do not use gc->pin2mask()

 drivers/gpio/Kconfig        |   2 +-
 drivers/gpio/gpio-brcmstb.c | 418 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 320 insertions(+), 100 deletions(-)

-- 
2.14.1
