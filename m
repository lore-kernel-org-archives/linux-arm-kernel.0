From: b29396@freescale.com (Dong Aisheng)
Date: Thu, 21 Jul 2011 12:36:54 +0800
Subject: [PATCH v5 0/4] ASoC: mxs: add audio support
Message-ID: <1311223018-9553-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to Liam's comment, i redo the patch set based on the for-next
branch on Mark's sound-2.6 tree.
The based one is [PATCH v4 00/10] ARM: mxs: add audio support.

For asoc part (1-4), only one change is updating mxs_pcm_new
since this API has been updated to pass in the runtime data only
For mxs part, no changes made.

This patch series is to add audio support based on saif for mxs platform.
The driver only supports playback currently.
For capturing, due to hardware limitation that we have to use two saif
instances to implement full duplex (playback & recording), we need to
figure out a good design to fit in ASoC as the following work.

In addition, we simply just support master mode since saif tx can
only work as a master due to hw limitation(rx can work in both
master & slave mode).

Tested on MX28EVK.

For the ASoC-patches (1-4):
 Tested-by: Wolfram Sang <w.sang@pengutronix.de>
For the mach-mxs-Patches (5-10):
 Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

Changes since v4:
 * ASoC: mxs: add mxs-pcm driver
	update mxs_pcm_new due to this API's parameter number is changed.

Changes since v3:
This version only has one patch changed with another two for rebase
the changed one.
 * [PATCH v4 06/10] ARM: mxs: add saif device
	Drop DIGCTRL-handling based on Wolfram's comment
 * [PATCH v4 07/10] ARM: mxs: add sgtl5000 i2c device
 	Resend for rebase [PATCH v4 06/10] ARM: mxs: add saif device
 * [PATCH v4 08/10] ARM: mxs: add mxs-sgtl5000 device
 	Resend for rebase [PATCH v4 06/10] ARM: mxs: add saif device

changes since v2:
 * mxs-pcm
    - fix wrong periods_max.
    - For robustness replace the channels_min check with a check
      for the relevant substream being present
 * mxs-saif
    - Add IRQ_NONE handle
    - improve mxs_saif_set_clk to make it more easy to read
    - correct return value
    - request_irq sequence changed to after ioremap
 * mxs-sgtl5000
    - clean up a few unused code
 * Kconfig&Makefile
    - SND_SOC_MXS_SGTL5000 should depend on I2C in Kconfig
 * mxs
    - Select MXS_I2C in kconfig for mxs-sgtl5000

changes since v1:
 * export saif mclk control interface to machine driver.
   Machine driver can decide whether it needs to use mclk supplied by
   saif according to its requirement.
 * error checking improvement
 * remove a few unneccesary code

Dong Aisheng (4):
  ASoC: mxs: add mxs-pcm driver
  ASoC: mxs: add mxs-saif driver
  ASoC: mxs: add mxs-sgtl5000 machine driver
  ASoC: mxs: add asoc configuration files

 sound/soc/Kconfig            |    1 +
 sound/soc/Makefile           |    1 +
 sound/soc/mxs/Kconfig        |   20 ++
 sound/soc/mxs/Makefile       |   10 +
 sound/soc/mxs/mxs-pcm.c      |  359 ++++++++++++++++++++++
 sound/soc/mxs/mxs-pcm.h      |   43 +++
 sound/soc/mxs/mxs-saif.c     |  677 ++++++++++++++++++++++++++++++++++++++++++
 sound/soc/mxs/mxs-saif.h     |  130 ++++++++
 sound/soc/mxs/mxs-sgtl5000.c |  165 ++++++++++
 9 files changed, 1406 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/mxs/Kconfig
 create mode 100644 sound/soc/mxs/Makefile
 create mode 100644 sound/soc/mxs/mxs-pcm.c
 create mode 100644 sound/soc/mxs/mxs-pcm.h
 create mode 100644 sound/soc/mxs/mxs-saif.c
 create mode 100644 sound/soc/mxs/mxs-saif.h
 create mode 100644 sound/soc/mxs/mxs-sgtl5000.c
