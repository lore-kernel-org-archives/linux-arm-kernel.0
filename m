From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 25 Mar 2018 10:39:14 -0400
Subject: [PATCH v7 0/7] netdev: Eliminate duplicate barriers on weakly-ordered
 archs
Message-ID: <1521988761-30344-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code includes wmb() followed by writel() in multiple places. writel()
already has a barrier on some architectures like arm64.

This ends up CPU observing two barriers back to back before executing the
register write.

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

I did a regex search for wmb() followed by writel() in each drivers
directory.
I scrubbed the ones I care about in this series.

I considered "ease of change", "popular usage" and "performance critical
path" as the determining criteria for my filtering.

We used relaxed API heavily on ARM for a long time but
it did not exist on other architectures. For this reason, relaxed
architectures have been paying double penalty in order to use the common
drivers.

Now that relaxed API is present on all architectures, we can go and scrub
all drivers to see what needs to change and what can remain.

We start with mostly used ones and hope to increase the coverage over time.
It will take a while to cover all drivers.

Feel free to apply patches individually.

Changes since v6:
- bring back amazon ena and add mmiowb, remove
  ena_com_write_sq_doorbell_rel(). 
- remove extra mmiowb in bnx2x
- correct spelling mistake in  bnx2x: Replace doorbell barrier() with wmb()


Sinan Kaya (7):
  net: qla3xxx: Eliminate duplicate barriers on weakly-ordered archs
  qlcnic: Eliminate duplicate barriers on weakly-ordered archs
  bnx2x: Replace doorbell barrier() with wmb()
  bnx2x: Eliminate duplicate barriers on weakly-ordered archs
  net: qlge: Eliminate duplicate barriers on weakly-ordered archs
  bnxt_en: Eliminate duplicate barriers on weakly-ordered archs
  net: ena: Eliminate duplicate barriers on weakly-ordered archs

 drivers/net/ethernet/amazon/ena/ena_com.c           |  8 ++++++--
 drivers/net/ethernet/amazon/ena/ena_eth_com.h       |  8 ++++++--
 drivers/net/ethernet/amazon/ena/ena_netdev.c        |  5 +++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h         | 12 ++++++++----
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c     |  5 +++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h     |  4 ++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c |  5 +++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c    |  4 ++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c    |  4 +++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c           |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h           |  9 +++++++++
 drivers/net/ethernet/qlogic/qla3xxx.c               |  5 +++--
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c |  2 +-
 drivers/net/ethernet/qlogic/qlge/qlge.h             | 16 ++++++++++++++++
 drivers/net/ethernet/qlogic/qlge/qlge_main.c        |  3 ++-
 15 files changed, 68 insertions(+), 24 deletions(-)

-- 
2.7.4
