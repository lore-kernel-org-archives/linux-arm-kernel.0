From: Guangyu.Chen@freescale.com (Nicolin Chen)
Date: Wed, 8 Jan 2014 16:45:54 +0800
Subject: [PATCH 0/2] Fix SSI audio function regression when using ROM firmware
Message-ID: <1389170756-22351-1-git-send-email-Guangyu.Chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously we added dual-fifo script support for SSI and SDMA, meanwhile, we
switched the default script in DT to this new script. However, there're still
quite a few people using the old version or even ROM firmware which means they
don't provide any firmware to SDMA driver. In these cases, the SDMA driver'd
fail to load essential script then the audio function broken.

This series of patches mainly fix this issue by assigning a default script
number for ROM firmware case and reverting the default script in DT so that
all kinds of users would continue to run it with or without firmware.

We might later need to figure out a better solution to ensure both SDMA driver
and SSI driver could adaptively switch the new script to the old one when V2
firmware isn't provided.

This series of patches are based on Vinod's repository.

Nicolin Chen (2):
  Revert "ARM: dts: imx: use dual-fifo sdma script for ssi"
  dma: imx-sdma: Assign a default script number for ROM firmware cases

 arch/arm/boot/dts/imx51.dtsi   |  4 ++--
 arch/arm/boot/dts/imx53.dtsi   |  4 ++--
 arch/arm/boot/dts/imx6qdl.dtsi | 12 ++++++------
 arch/arm/boot/dts/imx6sl.dtsi  | 12 ++++++------
 drivers/dma/imx-sdma.c         |  4 ++++
 5 files changed, 20 insertions(+), 16 deletions(-)

-- 
1.8.4
