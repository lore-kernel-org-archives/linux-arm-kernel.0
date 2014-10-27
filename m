From: vigneshr@ti.com (Vignesh R)
Date: Mon, 27 Oct 2014 16:38:27 +0530
Subject: [PATCH 0/4] Touchscreen performance related fixes
Message-ID: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches fix TSC defects related to lag in touchscreen
performance and cursor jump at touch release. The lag was result of
udelay in TSC interrupt handler. Cursor jump due to false pen-up event.
The patches implement Advisory 1.0.31 in silicon errata of am335x-evm
to avoid false pen-up events and remove udelay. The advisory says to use
steps 1 to 4 for ADC and 5 to 16 for TSC (assuming 4 wire TSC and 4 channel
ADC). Further the X co-ordinate must be the last one to be sampled just
before charge step. The first two patches implement the required changes. 

A DT parameter to configure the duration of tsc charge step. It represents
number of ADC clock cycles to wait between applying the step configuration
registers and going back to the IDLE state. The charge delay value can vary
across boards. Configuring correct value of charge delay is important to avoid
false pen-up events. Hence it is necessary to expose charge-delay value as
DT parameter. The pen-up detection happens immediately after the charge step
so this does in fact function as a hardware knob for adjusting the amount of
settling time.

After applying these changes false pen-up events have not be observed and
smooth circles can be drawn on touch screen. The performance is much better
in recognizing quick movement across the screen. No lag or cursor jump is
observed.

Brad Griffis (2):
  input: touchscreen: ti_am335x_tsc Interchange touchscreen and ADC
    steps
  input: touchscreen: ti_am335x_tsc: Remove udelay in interrupt handler

Vignesh R (2):
  arm: boot: dts: am335x-evm: Make charge delay a DT parameter for tsc
  input: touchscreen: ti_am335x_tsc: Use charge delay DT parameter

 .../bindings/input/touchscreen/ti-tsc-adc.txt      |  13 +++
 arch/arm/boot/dts/am335x-evm.dts                   |   1 +
 drivers/iio/adc/ti_am335x_adc.c                    |   2 +-
 drivers/input/touchscreen/ti_am335x_tsc.c          | 106 ++++++++++-----------
 drivers/mfd/ti_am335x_tscadc.c                     |   7 +-
 include/linux/mfd/ti_am335x_tscadc.h               |   4 +-
 6 files changed, 76 insertions(+), 57 deletions(-)

-- 
1.9.1
