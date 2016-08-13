From: isubramanian@apm.com (Iyappan Subramanian)
Date: Fri, 12 Aug 2016 22:05:36 -0700
Subject: [PATCH net-next v2 00/12] Fix warning and issues
Message-ID: <1471064748-28033-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set fixes the following warning and issues,

  1. Fix compiler warnings
  	- drivers: net: xgene: Fix compiler warnings
  2. unmap DMA memory on xgene_Enet_delete_bufpoool() 
	- drivers: net: xgene: fix: Add dma_unmap_single
  3. Delete descriptor rings and buffer pools on error
	- drivers: net: xgene: fix: Delete descriptor rings and buffer pools
  4. Fix error desconstruction on probe()
 	- drivers: net: xgene: Fix error deconstruction path
  5. Fix RSS indirection table fields
 	- drivers: net: xgene: Fix RSS indirection table fields
  6. Change the port init sequence as per hardware specification
	- drivers: net: xgene: Change port init sequence
  7. Fix link not recovered after link is down issue
	- drivers: net: xgene: XFI PCS reset when link is down
  8. Fix link up is reported when no SFP+ module is plugged in issue
	- drivers: net: xgene: Poll link status via GPIO
	- dtb: xgene: Add rxlos-gpios property
	- Documentation: dtb: xgene: Add rxlos GPIO mapping
  9. Fix backward compatibility when used with older driver
	- drivers: net: xgene: Fix backward compatibility
	- dtb: xgene: Fix backward compatibility

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Tested-by: Fushen Chen <fchen@apm.com>
---

v2: Address review comments from v1
	- Fixed compiler warnings
	- Removed kbuild fix patch, since Arnd submitted the same
	- Changed Kconfig to select GPIOLIB (to fix kbuild warning)
	- Added rxlos-gpio documentation
	- Fixed backward compatibility with older driver

v1:
	- Initial version
---

Iyappan Subramanian (12):
  drivers: net: xgene: Fix compiler warnings
  drivers: net: xgene: fix: Add dma_unmap_single
  drivers: net: xgene: fix: Delete descriptor rings and buffer pools
  drivers: net: xgene: Fix error deconstruction path
  drivers: net: xgene: Fix RSS indirection table fields
  drivers: net: xgene: Change port init sequence
  drivers: net: xgene: XFI PCS reset when link is down
  drivers: net: xgene: Poll link status via GPIO
  dtb: xgene: Add rxlos-gpios property
  Documentation: dtb: xgene: Add rxlos GPIO mapping
  drivers: net: xgene: Fix backward compatibility
  dtb: xgene: Fix backward compatibility

 .../devicetree/bindings/net/apm-xgene-enet.txt     |  3 +
 arch/arm64/boot/dts/apm/apm-mustang.dts            |  1 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |  2 +-
 drivers/net/ethernet/apm/xgene/Kconfig             |  1 +
 drivers/net/ethernet/apm/xgene/xgene_enet_cle.c    | 17 +++--
 drivers/net/ethernet/apm/xgene/xgene_enet_cle.h    | 10 ++-
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c     | 18 +++---
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h     |  6 ++
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   | 73 ++++++++++++++++------
 drivers/net/ethernet/apm/xgene/xgene_enet_main.h   |  2 +
 drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c  | 53 +++++++++++++++-
 drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.h  |  4 ++
 12 files changed, 150 insertions(+), 40 deletions(-)

-- 
1.9.1
