From: sunil.kovvuri@gmail.com (sunil.kovvuri at gmail.com)
Date: Wed, 13 Jul 2016 11:29:24 +0530
Subject: [PATCH v2 00/15] net: thunderx: Add support for 81xx and 83xx
Message-ID: <1468389579-482-1-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

This patch series adds support for VNIC on 81xx and 83xx SOCs.
81xx/83xx is different from 88xx in terms of capabilities and different
types of interfaces supported (eg: QSGMII, RGMII) and have DLMs instead
of QLMs which allows single BGX to have interfaces of different LMAC types.

Also included some patches which are common for all 88xx/81xx/83xx
SOCs like using netdev's name while registering irqs, reset receive
queue stats and some cleanup changes.

Changes from v1:
Fixed warning reported by kbuild test robot in patch
"Enable mailbox interrupts on 81xx/83xx"

Jerin Jacob (1):
  net: thunderx: Reset RXQ HW stats when interface is brought down

Radoslaw Biernacki (1):
  net: thunderx: Improvement for MBX interface debug messages

Sunil Goutham (13):
  net: thunderx: Moved HW capability info from macros to structure
  net: thunderx: Add VNIC's PCI devid on future chips
  net: thunderx: Add support for 81xx and 83xx chips
  net: thunderx: Set queue count based on number of CPUs
  net: thunderx: Enable CQE_RX desc's extension fields
  net: thunderx: Enable mailbox interrupts on 81xx/83xx
  net: thunderx: Support for different LMAC types within BGX
  net: thunderx: Add 81xx support to BGX driver
  net: thunderx: Add QSGMII interface type support
  net: thunderx: Add RGMII interface type support
  net: thunderx: Use netdev's name for naming VF's interrupts
  net: thunderx: Use skb_add_rx_frag() for split buffer Rx pkts
  net: thunderx: Don't set mac address for secondary Qset VFs

 drivers/net/ethernet/cavium/Kconfig                |  10 +
 drivers/net/ethernet/cavium/thunder/Makefile       |   1 +
 drivers/net/ethernet/cavium/thunder/nic.h          |  85 +++--
 drivers/net/ethernet/cavium/thunder/nic_main.c     | 362 ++++++++++++++----
 drivers/net/ethernet/cavium/thunder/nic_reg.h      |   2 +
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |  51 ++-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |  59 +--
 drivers/net/ethernet/cavium/thunder/nicvf_queues.h |   5 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c  | 410 ++++++++++++++-------
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h  |  28 +-
 drivers/net/ethernet/cavium/thunder/thunder_xcv.c  | 237 ++++++++++++
 11 files changed, 949 insertions(+), 301 deletions(-)
 create mode 100644 drivers/net/ethernet/cavium/thunder/thunder_xcv.c

-- 
2.7.4
