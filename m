From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 15 Mar 2018 21:04:50 -0400
Subject: [PATCH v2 0/6] Eliminate duplicate barriers on weakly-ordered archs
Message-ID: <1521162296-19729-1-git-send-email-okaya@codeaurora.org>
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
I scrubbed the ones I care about and posted this series. Note also that
I have one Infiniband patch in the series.

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

Changes since v1:

i40e/i40evf: Eliminate duplicate barriers on weakly-ordered archs
missed writel calls in:
i40e:
  i40e_program_fdir_filter
  i40e_clean_rx_irq
  i40e_tx_map
i40evf:
  i40e_clean_rx_irq
  i40e_tx_map

ixgbe: eliminate duplicate barriers on weakly-ordered archs
missed the writel at the end of ixgbe_tx_map

RDMA/qedr: eliminate duplicate barriers on weakly-ordered archs
dropped since applied

igbvf: eliminate duplicate barriers on weakly-ordered archs
missed the writel at the end of igbvf_tx_queue_adv()

igb: eliminate duplicate barriers on weakly-ordered archs
missed the writel at the end of igb_tx_map()

e1000: eliminate duplicate barriers on weakly-ordered archs
dropped

ixgbevf: eliminate duplicate barriers on weakly-ordered archs
split into two and remove extra barrier.

Sinan Kaya (6):
  i40e/i40evf: Eliminate duplicate barriers on weakly-ordered archs
  ixgbe: eliminate duplicate barriers on weakly-ordered archs
  igbvf: eliminate duplicate barriers on weakly-ordered archs
  igb: eliminate duplicate barriers on weakly-ordered archs
  ixgbevf: keep writel() closer to wmb()
  ixgbevf: eliminate duplicate barriers on weakly-ordered archs

 drivers/net/ethernet/intel/i40e/i40e_txrx.c       | 8 ++++----
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c     | 4 ++--
 drivers/net/ethernet/intel/igb/igb_main.c         | 4 ++--
 drivers/net/ethernet/intel/igbvf/netdev.c         | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 8 ++++----
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      | 5 -----
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 4 ++--
 7 files changed, 16 insertions(+), 21 deletions(-)

-- 
2.7.4
