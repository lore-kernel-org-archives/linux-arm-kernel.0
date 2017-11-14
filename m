From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 14 Nov 2017 11:53:34 +0100
Subject: [PATCH v3 0/4] Various nb8800 tweaks
Message-ID: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The main feature in this series is suspend/resume support (patch 4).
It is implemented by closing the device on suspend, and reopening it
on resume. To achieve this, HW inits are moved to ndo_open (patch 3).

After some back and forth with the HW dev, it turns out that the "raw" IP
does not support disabling DMA in software, so I want to get rid of the
nb8800_dma_stop() hack. Since there is no standard way to disable DMA,
I dropped generic support (patch 1).

The HW dev has also stated that it is safe to tweak the flow control bit
in the NB8800_RXC_CR register at any time (patch 2) i.e. no need for
special handling when RX DMA is enabled, despite the documentation stating:

> The Receive Channel Control Register holds channel enable, mode, endian,
> DMA control, and interrupt control information.  This register can only be
> written when the Receive DMA Channel is idle - the Enable bit in it is "0".

Marc Gonzalez (4):
  net: nb8800: Drop generic support
  net: nb8800: Simplify nb8800_pause_config()
  net: nb8800: Move HW init to ndo_open()
  net: nb8800: Add support for suspend/resume

 drivers/net/ethernet/aurora/nb8800.c | 189 +++++++++++------------------------
 drivers/net/ethernet/aurora/nb8800.h |   4 +-
 2 files changed, 63 insertions(+), 130 deletions(-)
