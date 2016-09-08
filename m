From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  8 Sep 2016 10:11:32 +0100
Subject: [PATCH 0/4] ARM: MMC: USB: Fix clocking
Message-ID: <20160908091136.17301-1-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before we had critical-clock support, it was not possible to boot a kernel
without using the 'clk_ignore_unused' kernel command-line parameter.  This
was due to the existance of inter-connect clocks which weren't associated
with any physical device and thus could not be handled (think get, enable,
disable) correctly.  As a consequence the platform would catastrophically
fail when the Common Clock Framework tried to disable unused clocks.

Now we do have critical-clock support, it has identified some additional
clocks which are required for the successful functioning of some key IP.

With the introduction of critical-clock support in v4.8, our developers'
default configuration is to run with 'clk_ignore_unused' removed.  This
patch-set ensures they can achieve successful boot when a) booting from
an SD Card and when b) booting using USB->Eth adaptors for NFS booting.

Please consider this set for your respective -fixes branches for
inclusion into the v4.8-rcs.

Lee Jones (4):
  ARM: dts: STiH410: Handle interconnect clock required by EHCI/OHCI
    (USB)
  ARM: dts: STiH407-family: Provide interconnect clock for consumption
    in ST SDHCI
  dt-bindings: mmc: sdhci-st: Mention the discretionary "icn" clock
  mmc: sdhci-st: Handle interconnect clock

 Documentation/devicetree/bindings/mmc/sdhci-st.txt |  2 +-
 arch/arm/boot/dts/stih407-family.dtsi              | 10 ++++++----
 arch/arm/boot/dts/stih410.dtsi                     | 12 ++++++++----
 drivers/mmc/host/sdhci-st.c                        | 15 ++++++++++++++-
 4 files changed, 29 insertions(+), 10 deletions(-)

-- 
2.9.3
