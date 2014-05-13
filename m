From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 13 May 2014 13:30:27 +0300
Subject: [PATCH v2 0/5] ARM/DT: edma: Get IP configuration from hardware
Message-ID: <1399977032-26469-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changes sicne v1:
- added missing patch to remove the memset from edma_of_parse_dt()

We are requesting redundant information via DT for the driver since the very same
data is available in the HW: by reading and decoding the content of CCCFG
register we can get:
Number of channels: NUM_DMACH
Number of regions: NUM_REGN
Number of slots (PaRAM sets): NUM_PAENTRY
Number of TC/EQ: NUM_EVQUE

So these does not need to be provided by the DT binding.

The driver will no longer look for these properties from DT and they can be
removed from the binding documentation and from the dtsi files as well.
The change will not introduce regression when new kernel is booted using older
DTB (since we just ignore the mentioned properties).

Regards,
Peter
---
Peter Ujfalusi (5):
  ARM: edma: No need to clean the pdata in edma_of_parse_dt()
  ARM: edma: Get IP information from HW when booting with DT
  dt/bindings: ti,edma: Remove redundant properties from documentation
  ARM: dts: am33xx: Remove obsolete properties from edma node
  ARM: dts: am4372: Remove obsolete properties from edma node

 Documentation/devicetree/bindings/dma/ti-edma.txt |   6 -
 arch/arm/boot/dts/am33xx.dtsi                     |   3 -
 arch/arm/boot/dts/am4372.dtsi                     |   3 -
 arch/arm/common/edma.c                            | 130 +++++++++++++---------
 4 files changed, 79 insertions(+), 63 deletions(-)

-- 
1.9.3
