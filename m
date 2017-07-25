From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 25 Jul 2017 17:55:01 +0200
Subject: [PATCH 0/8] net: mvpp2: add TX interrupts support
Message-ID: <20170725155509.10574-1-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

So far, the mvpp2 driver was using an hrtimer to handle TX
completion. This patch series adds support for using TX interrupts
(for each CPU) on PPv2.2, the variant of the IP used on Marvell Armada
7K/8K.

This series has been tested on Marvell Armada 7K (PPv2.2) and Armada
375 (PPv2.1).

Dave:

 - This series depends on the previous series sent by Antoine T?nart
   "net: mvpp2: MAC/GoP configuration and optional PHYs". Functionally
   speaking there is no real dependency, but we touch in a few areas
   the same piece of code, so I based my patch series on top of
   Antoine's.

 - Please do not apply the last patch of this series "arm64: dts:
   marvell: add TX interrupts for PPv2.2", it will be taken by the ARM
   mvebu maintainers.

Thanks!

Thomas

Thomas Petazzoni (8):
  net: mvpp2: fix MVPP21_ISR_RXQ_GROUP_REG definition
  net: mvpp2: remove RX queue group reset code
  net: mvpp2: introduce per-port nrxqs/ntxqs variables
  net: mvpp2: move from cpu-centric naming to "software thread" naming
  net: mvpp2: introduce queue_vector concept
  net: mvpp2: add support for TX interrupts and RX queue distribution
    modes
  dt-bindings: net: marvell-pp2: update interrupt-names with TX
    interrupts
  arm64: dts: marvell: add TX interrupts for PPv2.2

 .../devicetree/bindings/net/marvell-pp2.txt        |  33 +-
 .../boot/dts/marvell/armada-cp110-master.dtsi      |  21 +-
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |  21 +-
 drivers/net/ethernet/marvell/mvpp2.c               | 638 +++++++++++++++------
 4 files changed, 534 insertions(+), 179 deletions(-)

-- 
2.9.4
