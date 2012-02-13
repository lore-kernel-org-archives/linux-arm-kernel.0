From: b32955@freescale.com (Huang Shijie)
Date: Mon, 13 Feb 2012 13:25:54 +0800
Subject: [PATCH v5 0/2] patch set about the MXS-DMA
Message-ID: <1329110756-14434-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

patch 1: move the mxs dma header to a more common place.
	Beside the mx23/mx28, the apbh-dma is also used by MX50 and MX6Q.
	So move the mxs dma header file to a more common place, and rename
	it to mxs-dma.h

patch 2: rewrite the last parameter of mxs_dma_prep_slave_sg().
	In the new GPMI version, some hardware behavior changes.
	The WAIT4END bit should be set in the middle one of the ECC READ page DMA chain.
	The DMA chain should be set like this:

          +-----+               +-----+                      +-----+
          | cmd | ------------> | cmd | ------------------>  | cmd |
          +-----+               +-----+                      +-----+
                                   ^                            ^
                                   |                            |
                                   |                            |
                              set WAIT4END here too        set WAIT4END here

        So rewrite the last parameter of mxs_dma_prep_slave_sg(), use the
	dma_ctrl_flags to set the proper DMA bit for DMA Command Structure.
	And change the relative drivers with the dma_ctrl_flags.

TEST:
	Tested the mxs-mmc driver and gpmi-nand drive with the two patches
	in MX28 board.

v4 --> v5:
	[1] remove GPMI_IS_MX6Q(), make the mxs and mx6q use the same code.
		
v3 --> v4:
	[1] create a new folder include/linux/fsl/ for store the Freescale's
	    header files.
	[2] add more CCs.

v2 --> v3:
	[1] remove field gpmi_version, use GPMI_IS_MX6Q() instead.

v1 --> v2:
	[1] squash the trial patches into single patch.
	[2] use the dma_ctrl_flags.


Huang Shijie (2):
  mxs-dma : move the mxs dma.h to a more common place
  mxs-dma : rewrite the last parameter of mxs_dma_prep_slave_sg()

 drivers/dma/mxs-dma.c                              |   34 +++++++++++++++++---
 drivers/mmc/host/mxs-mmc.c                         |   12 +++---
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c              |   19 +++++++---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h             |    2 +-
 .../mach/dma.h => include/linux/fsl/mxs-dma.h      |    0
 sound/soc/mxs/mxs-pcm.c                            |    2 +-
 sound/soc/mxs/mxs-pcm.h                            |    2 +-
 sound/soc/mxs/mxs-saif.c                           |    2 +-
 8 files changed, 52 insertions(+), 21 deletions(-)
 rename arch/arm/mach-mxs/include/mach/dma.h => include/linux/fsl/mxs-dma.h (100%)
