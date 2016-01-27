From: stripathi@apm.com (Suman Tripathi)
Date: Wed, 27 Jan 2016 15:19:54 +0530
Subject: [PATCH v2 0/3] ata: Fixes related to edge trigger latch for
 ahci_xgene driver.
Message-ID: <1453888197-11368-1-git-send-email-stripathi@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set implements a workaround for an errate in the APM
X-Gene SATA host controller with edge interrupt. The HOST_IRQ_STAT
misses the edge interrupt from the PORT_IRQ_STAT when clearing the
HOST_IRQ_STAT and reporting the PORT_IRQ_STAT happens in same clock
cycle. It also implements the capability to override generic interrupt
handler.

v1 change:
* Implement the capability for LDD to override interrupt handler.

* ahci_xgene driver implements the edge trigger interrupt handler.

v2 change:
* Remove the AHCI_HFLAG_EDGE_IRQ frim libahci.

Signed-off-by: Suman Tripathi <stripathi@apm.com>

Suman Tripathi (3):
  ata: Remove the AHCI_HFLAG_EDGE_IRQ support from libahci.
  libahci: Implement the capability to override the generic ahci
    interrupt     handler.
  ahci_xgene: Implement the workaround to fix the missing of edge
    interrupt for HOST_IRQ_STAT.

 drivers/ata/ahci.h       |    5 ++-
 drivers/ata/ahci_xgene.c |   86 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/libahci.c    |   53 +++++-----------------------
 3 files changed, 98 insertions(+), 46 deletions(-)
