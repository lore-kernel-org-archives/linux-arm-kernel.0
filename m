From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 30 Apr 2015 16:22:27 +0800
Subject: [PATCH v2 0/2] PCI: designware: improve iATU programming and usage
Message-ID: <1430382149-1645-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The outbound iATU programming functions are similar, so PATCH1 consolidates
them into one.

Most transactions' type are cfg0 and MEM, so current iATU usage is not
balanced. PATCH2 adopts idea from Minghuan Lian <Minghuan.Lian@freescale.com>:

 http://www.spinics.net/lists/linux-pci/msg40440.html

to change the iATU allocation: iATU0 for cfg and IO, iATU1 for MEM.

Changes since v1:
- remove outbound iATU programming for IO in dw_pcie_host_init, since it can
  be done by berlin_pcie_{rd|wr}_other_conf() latter.
- only do outbound iATU programming for MEM if pp->ops->rd_other_conf is not
  set. Thank Fabrice Gasnier to point out "some platforms doesn't have support
  for ATU"

Jisheng Zhang (2):
  PCI: designware: consolidate outbound iATU programming functions
  PCI: designware: use iATU0 for cfg and IO, iATU1 for MEM

 drivers/pci/host/pcie-designware.c | 142 ++++++++++++++++---------------------
 1 file changed, 60 insertions(+), 82 deletions(-)

-- 
2.1.4
