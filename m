From: joelf@ti.com (Joel Fernandes)
Date: Mon, 23 Sep 2013 18:05:12 -0500
Subject: [PATCH 0/3] dma: edma: Add cyclic DMA support
Message-ID: <1379977515-3794-1-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series adds Cyclic DMA support to TI EDMA DMA Engine driver.

First we split out the calculations for the Slave DMA case into a separate
function so that we may reuse it for the calculations of Cyclic DMA parameters.
Next patch then adds the actual support for Cyclic DMA, enables interrupts
correctly and uses's the callbacks in virt-dma during interrupts thus
signalling back to the ALSA layer that a period was transmitted.

Some background on motivation for this series:
Currently, only user of Cyclic DMA in EDMA is davinci-pcm driver. As of today,
this driver directly calls into the EDMA private API (arch/arm/common/edma.c)
without going through the DMAEngine.

davinci-pcm in future will be modified to use DMA Engine framework for Cyclic
DMA instead of directly using the Private API. However that's a much larger
effort, involving dealing with ping-pong from SRAM on user's of the Davinci
McASP, etc. As a first step, we add Cyclic DMA support to the EDMA driver so
that this may be used when the actual conversion of davinci-pcm happens.

Tested series along with couple of hacks to davinci-pcm to work with DMA Engine:
git at github.com:joelagnel/linux-kernel.git (branch dma/cyclic)

Joel Fernandes (3):
  dma: edma: Split out PaRAM set calculations into its own function
  dma: edma: Add support for Cyclic DMA
  dma: edma: Increase maximum SG limit to 20

 drivers/dma/edma.c | 350 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 273 insertions(+), 77 deletions(-)

-- 
1.8.1.2
