From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat,  5 Jul 2014 08:54:45 -0300
Subject: [PATCH v2 net-next 0/3] Network driver for Armada 375 SoC
Message-ID: <1404561288-11720-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes from v1:
  * Marcin Wojtas is the author of the driver, so I fixed authorship
    for patch 1/3:
    "ethernet: Add new driver for Marvell Armada 375 network unit"

This patchset adds a new network driver to support the network controller
in Armada 375 SoC.

The network interfaces share a common hardware unit called Packet Processor,
which contains a common register space and per-port register spaces.
    
The new network unit has different RXQ and TXQ management. The ports
associate so-called per-port "logical queues" which are mapped to "physical
queues". The latter are shared among the ports.

Fo the egress part, the mapping for each port is predefined by hardware.
The egress path incorporates so-called aggregation queues (one per CPU),
from where the data is passed to the physical queues and then via prefetch
buffer to the TxDMA.
    
The ingress path has a Parser and Classifier (PnC) and a Buffer Manager (BM)
whose usage is obligatory. We are only implementing a simple configuration
for the Parser and Classifier, yet the code is considerably large.
    
This network unit has other optional features like xPON, WoL, Hardware
Forwarding, and more. This initial commit doesn't provide support for these.
    
The mvpp2 network driver has been written by Marcin Wojtas and then reviewed
and cleaned up by Ezequiel Garcia.

Ezequiel Garcia (2):
  ARM: mvebu: Add support for the network controller in Armada 375 SoC
  ARM: mvebu: Enable the network controller in Armada 375 DB board

Marcin Wojtas (1):
  ethernet: Add new driver for Marvell Armada 375 network unit

 .../devicetree/bindings/net/marvell-pp2.txt        |   61 +
 arch/arm/boot/dts/armada-375-db.dts                |   26 +
 arch/arm/boot/dts/armada-375.dtsi                  |   31 +
 drivers/net/ethernet/marvell/Kconfig               |    8 +
 drivers/net/ethernet/marvell/Makefile              |    1 +
 drivers/net/ethernet/marvell/mvpp2.c               | 6378 ++++++++++++++++++++
 6 files changed, 6505 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/marvell-pp2.txt
 create mode 100644 drivers/net/ethernet/marvell/mvpp2.c

-- 
1.9.1
