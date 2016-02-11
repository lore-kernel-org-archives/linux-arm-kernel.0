From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 11 Feb 2016 22:23:14 +0100
Subject: [PATCH 0/4] Fix pxa dma requestor lines
Message-ID: <1455225798-9510-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serie aims at fixing a bug which arose in the pxa_dma driver, which needs
to know the number of requestor lines which are connected to the DMA IP.

The current implementation of pxa_dma is limited to 32 lines, which pxa27x has
75 lines and pxa3xx has 100 of them. As a consequence, DMA clients with a
requestor greater that 32 are not working, namely the pxa_camera driver.

The proposed fix by Vinod is to make the driver aware of the number of lines,
which is done by this patchset.

I'd like to have this reviewed and then taken through the PXA tree. For this
I'll need :
 - Rob/Grant/Kumar/Ian ack on patch 1/4
 - Haojian's ack on patch 2/4
 - Vinod's ack on patch 4/4

Thanks in advance.

--
Robert

Robert Jarzmik (4):
  dma: mmp_pdma: Add the #requestors DT property documentation
  dmaengine: mmp-pdma: add number of requestors
  ARM: pxa: add the number of DMA requestor lines
  dmaengine: pxa_dma: fix the maximum requestor line

 Documentation/devicetree/bindings/dma/mmp-dma.txt |  2 ++
 arch/arm/boot/dts/pxa27x.dtsi                     |  1 +
 arch/arm/boot/dts/pxa3xx.dtsi                     |  1 +
 arch/arm/mach-pxa/devices.c                       |  3 ++-
 arch/arm/mach-pxa/pxa25x.c                        |  2 +-
 arch/arm/mach-pxa/pxa27x.c                        |  2 +-
 arch/arm/mach-pxa/pxa3xx.c                        |  2 +-
 arch/arm/plat-pxa/include/plat/dma.h              |  2 +-
 drivers/dma/pxa_dma.c                             | 33 +++++++++++++++--------
 include/linux/platform_data/mmp_dma.h             |  1 +
 10 files changed, 33 insertions(+), 16 deletions(-)

-- 
2.1.4
