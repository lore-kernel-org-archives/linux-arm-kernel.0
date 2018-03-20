From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 19 Mar 2018 22:42:15 -0400
Subject: [PATCH v4 00/17] netdev: Eliminate duplicate barriers on
 weakly-ordered archs
Message-ID: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>
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

Changes since v3:
- https://www.spinics.net/lists/arm-kernel/msg641851.html
- group patches together into subsystems net:... 
- collect reviewed and tested bys
- scrub barrier()


Sinan Kaya (17):
  i40e/i40evf: Eliminate duplicate barriers on weakly-ordered archs
  ixgbe: eliminate duplicate barriers on weakly-ordered archs
  igbvf: eliminate duplicate barriers on weakly-ordered archs
  igb: eliminate duplicate barriers on weakly-ordered archs
  ixgbevf: keep writel() closer to wmb()
  ixgbevf: eliminate duplicate barriers on weakly-ordered archs
  fm10k: Eliminate duplicate barriers on weakly-ordered archs
  drivers: net: cxgb: Eliminate duplicate barriers on weakly-ordered
    archs
  net: qla3xxx: Eliminate duplicate barriers on weakly-ordered archs
  qlcnic: Eliminate duplicate barriers on weakly-ordered archs
  bnx2x: Eliminate duplicate barriers on weakly-ordered archs
  net: cxgb4/cxgb4vf: Eliminate duplicate barriers on weakly-ordered
    archs
  net: cxgb3: Eliminate duplicate barriers on weakly-ordered archs
  net: qlge: Eliminate duplicate barriers on weakly-ordered archs
  bnxt_en: Eliminate duplicate barriers on weakly-ordered archs
  qed/qede: Eliminate duplicate barriers on weakly-ordered archs
  net: ena: Eliminate duplicate barriers on weakly-ordered archs

 drivers/net/ethernet/amazon/ena/ena_com.c          |  6 ++++--
 drivers/net/ethernet/amazon/ena/ena_eth_com.h      | 22 ++++++++++++++++++++--
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |  4 ++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |  9 ++++++++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h    |  4 ++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   | 21 +++++++++++----------
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c  |  2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c   |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          | 11 ++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  2 +-
 drivers/net/ethernet/chelsio/cxgb/sge.c            |  2 +-
 drivers/net/ethernet/chelsio/cxgb3/adapter.h       |  7 +++++++
 drivers/net/ethernet/chelsio/cxgb3/sge.c           | 19 ++++++++++---------
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h         |  6 ++++++
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    | 13 +++++++------
 drivers/net/ethernet/chelsio/cxgb4/sge.c           | 12 ++++++------
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c         |  2 +-
 drivers/net/ethernet/chelsio/cxgb4vf/adapter.h     | 14 ++++++++++++++
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c         | 18 ++++++++++--------
 drivers/net/ethernet/intel/fm10k/fm10k_main.c      |  4 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  8 ++++----
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  4 ++--
 drivers/net/ethernet/intel/igb/igb_main.c          |  4 ++--
 drivers/net/ethernet/intel/igbvf/netdev.c          |  4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  8 ++++----
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h       |  5 -----
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |  4 ++--
 drivers/net/ethernet/qlogic/qed/qed.h              |  5 ++++-
 drivers/net/ethernet/qlogic/qed/qed_hw.c           | 12 ++++++++++++
 drivers/net/ethernet/qlogic/qed/qed_hw.h           | 14 ++++++++++++++
 drivers/net/ethernet/qlogic/qed/qed_int.c          |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.c           |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.c          |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_vf.c           |  7 ++++---
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c    |  2 +-
 drivers/net/ethernet/qlogic/qede/qede_fp.c         |  4 ++--
 drivers/net/ethernet/qlogic/qla3xxx.c              |  4 ++--
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |  2 +-
 drivers/net/ethernet/qlogic/qlge/qlge.h            | 17 +++++++++++++++++
 drivers/net/ethernet/qlogic/qlge/qlge_main.c       |  2 +-
 include/linux/qed/qed_if.h                         | 17 +++++++++++++----
 42 files changed, 215 insertions(+), 96 deletions(-)

-- 
2.7.4
