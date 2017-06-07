From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed,  7 Jun 2017 11:08:19 +0200
Subject: [PATCH 0/3] arm64: hi6220-hikey: Fix Bluetooth support
Message-ID: <1496826502-1339-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit ea452678734e ("arm64: dts: hikey: Fix WiFi support") indeed managed
to fix the WiFi support for the Hikey board. However, it also caused the
Bluetooth to break.

The reason to the problem is because part of the fixes for WiFi, involved
explicitly to start manage the external clock for the TI WiLink chip, as it's
needed to properly power on/off WiFi. Then, because the Bluetooth driver,
hci_ll, don't manage the clock, it fails to initialize Bluetooth.

This small series add support and DT bindings for the external clock, now
properly managed by the hci_ll driver during power on/off. On top of that, the
external clock is added to the Bluetooth DT node in the Hikey DTS file.

The regression has been reported by John Stultz, running a Hikey board with
UEFI based boot. I have confirmed that there is no regressions with u-boot as
we still don't have bluetooth working on that set up. I intend to fix that as
well, although in second step and not being part of a fixup series.

John, can you please confirm/test this on your Hikey board using UEFI!?

Perhaps this can go in via the bluetooth git, when respective patches has got
an ack. Or whatever you think is best.

Ulf Hansson (3):
  dt-bindings: net: Add binding for the external clock for TI WiLink
  Bluetooth: hci_ll: Add support for the external clock
  arm64: dts: hikey: Add external clock to the Bluetooth node

 Documentation/devicetree/bindings/net/ti,wilink-st.txt |  6 ++++++
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts         |  2 ++
 drivers/bluetooth/hci_ll.c                             | 14 +++++++++++++-
 3 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.7.4
