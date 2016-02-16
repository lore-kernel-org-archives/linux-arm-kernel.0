From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 16 Feb 2016 21:08:18 +0800
Subject: [PATCH v5 00/13] mmc: use sdhci_pltfm_init for private allocation and
 clean up
Message-ID: <1455628111-5583-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches are to complete the TODOs in Commit 0e748234293f ("mmc:
sdhci: Add size for caller in init+register"), I.E:

- todo: migrate clients to using allocation this way
- todo: remove priv variable once migration is complete

Since v4:
 - based on Ulf's latest next branch
 - add Adrian's Ack for all patches, add Thierry's Ack and Test for patch 11
   add S?ren Ack for patch 5.

Since v3:
 - based on v4.5-rc1
 - add Ludovic's ack for sdhci-of-at91 changes
 - fix use-after-free in some drivers: some host drivers still needs to
   access sdhci_pltfm_host->private after sdhci_pltfm_unregister(), but
   the private should be already freed by sdhci_pltfm_unregister.
 - add patch5 to fix one clk bug in sdhci_arasan_remove(). IMHO, It's
   better to add this patch to fixes rather than waiting for next merge
   window

Since v2:
 - based on mmc next tree and remove all priv usage introduced in newly
   commits in this tree
 - don't break two lines if sdhci_pltfm_init() call could be put into
   one line. Thank Ludovic Desroches.

Since v1:
 - add new patch03 to factorise sdhci_msm_pdata outisde of sdhci_msm_host.
   This is to fix drivers/mmc/host/sdhci-msm.c:440:32: warning: 'msm_host'
   is used uninitialized in this function [-Wuninitialized]
 - Add Arnd's Ack for all patches except patch3 which is new in v2


Jisheng Zhang (13):
  mmc: sdhci-bcm2835: use sdhci_pltfm_init for private allocation
  mmc: sdhci-esdhc-imx: use sdhci_pltfm_init for private allocation
  mmc: sdhci-msm: factorise sdhci_msm_pdata outisde of sdhci_msm_host
  mmc: sdhci-msm: use sdhci_pltfm_init for private allocation
  mmc: sdhci-of-arasan: fix clk issue in sdhci_arasan_remove()
  mmc: sdhci-of-arasan: use sdhci_pltfm_init for private allocation
  mmc: sdhci-of-at91: use sdhci_pltfm_init for private allocation
  mmc: sdhci-of-esdhc: use sdhci_pltfm_init for private allocation
  mmc: sdhci-pxav3: use sdhci_pltfm_init for private allocation
  mmc: sdhci-st: use sdhci_pltfm_init for private allocation
  mmc: sdhci-tegra: use sdhci_pltfm_init for private allocation
  mmc: sdhci-pxav2: remove unnecessary assignment of pltfm_host->priv
  mmc: sdhci-pltfm: remove priv variable from sdhci_pltfm_host

 drivers/mmc/host/sdhci-bcm2835.c   | 14 +++----------
 drivers/mmc/host/sdhci-esdhc-imx.c | 38 ++++++++++++++++--------------------
 drivers/mmc/host/sdhci-msm.c       | 25 +++++++++++-------------
 drivers/mmc/host/sdhci-of-arasan.c | 33 +++++++++++++++----------------
 drivers/mmc/host/sdhci-of-at91.c   | 33 ++++++++++++++-----------------
 drivers/mmc/host/sdhci-of-esdhc.c  | 19 +++++++++---------
 drivers/mmc/host/sdhci-pltfm.h     |  1 -
 drivers/mmc/host/sdhci-pxav2.c     |  1 -
 drivers/mmc/host/sdhci-pxav3.c     | 20 ++++++++-----------
 drivers/mmc/host/sdhci-st.c        | 40 +++++++++++++++++++-------------------
 drivers/mmc/host/sdhci-tegra.c     | 21 +++++++-------------
 11 files changed, 106 insertions(+), 139 deletions(-)

-- 
2.7.0
