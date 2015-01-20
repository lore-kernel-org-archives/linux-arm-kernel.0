From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 20 Jan 2015 15:32:40 +0000
Subject: [PATCH 0/4] Add sd/emmc support for stih407 family silicon
Message-ID: <1421767964-8798-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds sd/emmc support to the sdhci-st.c driver for stih407
family silicon. The changes mainly involve congiguring some extra glue
registers which configure the controller.

This series also adds support for UHS modes for eMMC. To allow
UHS HS200/SD104 modes to function correctly, due to the
tight timing constriants and data tuning requirement, support
for PVT independent delay management is also added. Two types
of delay management are supported, static delay management and
dynamic delay management (dynamic delay loop), this delay
management is only available on eMMC pads on stih410 and later
silicon.

This has been tested with stih410-b2120 on eMMC and sd, at various
clock speeds. As part of this testing a bug was also found in the
upstream flexgen clock set_rate implementation.

    max-frequency = 200Mhz
    /dev/mmcblk0p1:
     Timing buffered disk reads: 270 MB in  3.02 seconds =  89.54 MB/sec
    
    max-frequency = 100Mhz
    root at debian-armhf:~# hdparm -t /dev/mmcblk0p1
    /dev/mmcblk0p1:
     Timing buffered disk reads: 210 MB in  3.00 seconds =  70.00 MB/sec
    
    max-frequency = 50Mhz
    root at debian-armhf:~# hdparm -t /dev/mmcblk0p1
    /dev/mmcblk0p1:
     Timing buffered disk reads: 118 MB in  3.00 seconds =  39.28 MB/sec

It has also been tested on stih416-b2020 to ensure we have caused no
regressions. Finally the dt documentation has been updated to reflect
the changes in the driver code. Intrestingly it seems we are the first
upstream platform to be using some of the uhs bindings such as
sd-uhs-sdr104.

regards,

Peter.

Peter Griffin (4):
  clk: st: STiH410: Fix pdiv and fdiv divisor when setting rate
  sdhci-st: Add support for stih407 family silicon.
  mmc: sdhci-st: Update ST SDHCI binding documentation.
  ARM: STi: DT: STiH407: Add dt nodes for sdhci and emmc.

 Documentation/devicetree/bindings/mmc/sdhci-st.txt | 100 +++++-
 arch/arm/boot/dts/stih407-family.dtsi              |  30 ++
 arch/arm/boot/dts/stih410-b2120.dts                |  10 +
 arch/arm/boot/dts/stihxxx-b2120.dtsi               |   8 +
 drivers/clk/st/clk-flexgen.c                       |  19 +-
 drivers/mmc/host/sdhci-st.c                        | 351 ++++++++++++++++++++-
 6 files changed, 496 insertions(+), 22 deletions(-)

-- 
1.9.1
