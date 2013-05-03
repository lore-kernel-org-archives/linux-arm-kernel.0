From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  3 May 2013 15:31:46 +0100
Subject: [PATCH 00/63] dmaengine: Convert to correct API & Device Tree
 handling
Message-ID: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As requested, this is the whole shebang. The first few patches are
the Device Tree adaptions. Then we move into some driver refactoring
basing on the fact that channel configuration should not be carried
out during channel allocation, but during a separate invocation of
dmaengine_slave_config(). Then we convert some of the clients over
to the new API. And finally, we provide all of the Device Tree
bindings to start requesting and configuration channels without the
use of platform data.

 Documentation/devicetree/bindings/dma/ste-dma40.txt |   66 ++++++++++++
 Documentation/devicetree/bindings/usb/ux500-usb.txt |   50 +++++++++
 arch/arm/boot/dts/dbx5x0.dtsi                       |   81 ++++++++++++--
 arch/arm/mach-ux500/board-mop500-audio.c            |   68 +++---------
 arch/arm/mach-ux500/board-mop500-sdi.c              |   56 +++-------
 arch/arm/mach-ux500/board-mop500.c                  |   85 +++++----------
 arch/arm/mach-ux500/board-mop500.h                  |    1 +
 arch/arm/mach-ux500/cpu-db8500.c                    |   74 ++++---------
 arch/arm/mach-ux500/devices-db8500.c                |  123 +--------------------
 arch/arm/mach-ux500/ste-dma40-db8500.h              |  193 ++++++++++++---------------------
 arch/arm/mach-ux500/usb.c                           |   47 +++-----
 drivers/crypto/ux500/cryp/cryp.h                    |    7 +-
 drivers/crypto/ux500/cryp/cryp_core.c               |   31 +++++-
 drivers/crypto/ux500/hash/hash_alg.h                |    5 +-
 drivers/crypto/ux500/hash/hash_core.c               |   24 ++++-
 drivers/dma/ste_dma40.c                             |  509 +++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------
 drivers/dma/ste_dma40_ll.c                          |  189 ++++++++++++++++----------------
 drivers/dma/ste_dma40_ll.h                          |    3 +-
 drivers/usb/musb/ux500.c                            |   61 ++++++++++-
 drivers/usb/musb/ux500_dma.c                        |   59 +++++-----
 include/linux/platform_data/dma-ste-dma40.h         |   41 ++-----
 include/linux/platform_data/usb-musb-ux500.h        |    5 +-
 sound/soc/ux500/ux500_pcm.c                         |   10 +-
 23 files changed, 903 insertions(+), 885 deletions(-)
