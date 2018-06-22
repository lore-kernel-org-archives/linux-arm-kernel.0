From: yibin.gong@nxp.com (Robin Gong)
Date: Fri, 22 Jun 2018 01:12:48 +0000
Subject: [PATCH v5 0/7] add virt-dma support for imx-sdma
In-Reply-To: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
References: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
Message-ID: <DB6PR04MB32237203C350E5853C8870DB89750@DB6PR04MB3223.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lucas,
	Would you like to try with the v5 for your Audio/UART case?

-----Original Message-----
From: Robin Gong 
Sent: 2018?6?20? 0:57
To: vkoul at kernel.org; s.hauer at pengutronix.de; l.stach at pengutronix.de; dan.j.williams at intel.com; gregkh at linuxfoundation.org; jslaby at suse.com
Cc: linux-serial at vger.kernel.org; dmaengine at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH v5 0/7] add virt-dma support for imx-sdma

The legacy sdma driver has below limitations or drawbacks:
  1. Hardcode the max BDs number as "PAGE_SIZE / sizeof(*)", and alloc
     one page size for one channel regardless of only few BDs needed
     most time. But in few cases, the max PAGE_SIZE maybe not enough.
  2. One SDMA channel can't stop immediatley once channel disabled which
     means SDMA interrupt may come in after this channel terminated.There
     are some patches for this corner case such as commit "2746e2c389f9",
     but not cover non-cyclic.

The common virt-dma overcomes the above limitations. It can alloc bd dynamically and free bd once this tx transfer done. No memory wasted or maximum limititation here, only depends on how many memory can be requested from kernel. For No.2, such issue can be workaround by checking if there is available descript("sdmac->desc") now once the unwanted interrupt coming. At last the common virt-dma is easier for sdma driver maintain.

Change from v4:
  1. identify lockdep issue which caused by allocate memory with
     'GFP_KERNEL', change to 'GFP_NOWAIT' instead so that lockdep
     ignore check. That also make sense since Audio/uart driver may
     call dma function after spin_lock_irqsave()...
  2. use dma pool instead for bd description allocated,since audio
     driver may call dma_terminate_all in irq. Please refer to 7/7.
  3. remove 7/7 serial patch in v4, since lockdep issued fixed by No.1 

Change from v3:
  1. add two uart patches which impacted by this patchset.
  2. unlock 'vc.lock' before cyclic dma callback and lock again after
     it because some driver such as uart will call dmaengine_tx_status
     which will acquire 'vc.lock' again and dead lock comes out.
  3. remove 'Revert commit' stuff since that patch is not wrong and
     combine two patch into one patch as Sascha's comment.

Change from v2:
  1. include Sascha's patch to make the main patch easier to review.
     Thanks Sacha.
  2. remove useless 'desc'/'chan' in struct sdma_channe.

Change from v1:
  1. split v1 patch into 5 patches.
  2. remove some unnecessary condition check.
  3. remove unnecessary 'pending' list.

Robin Gong (6):
  tty: serial: imx: correct dma cookie status
  dmaengine: imx-sdma: add virt-dma support
  dmaengine: imx-sdma: remove useless 'lock' and 'enabled' in 'struct
    sdma_channel'
  dmaengine: imx-sdma: remove the maximum limitation for bd numbers
  dmaengine: imx-sdma: add sdma_transfer_init to decrease code overlap
  dmaengine: imx-sdma: alloclate bd memory from dma pool

Sascha Hauer (1):
  dmaengine: imx-sdma: factor out a struct sdma_desc from struct
    sdma_channel

 drivers/dma/Kconfig      |   1 +
 drivers/dma/imx-sdma.c   | 400 +++++++++++++++++++++++++++--------------------
 drivers/tty/serial/imx.c |   2 +-
 3 files changed, 235 insertions(+), 168 deletions(-)

--
2.7.4
