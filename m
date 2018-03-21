From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 21 Mar 2018 14:56:04 -0400
Subject: [PATCH REPOST v4 0/7] netdev: intel: Eliminate duplicate barriers on
 weakly-ordered archs
Message-ID: <1521658572-26354-1-git-send-email-okaya@codeaurora.org>
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

repost:
- split into intel specific patches

Changes since v3:
- https://www.spinics.net/lists/arm-kernel/msg641851.html
- group patches together into subsystems net:...
- collect reviewed and tested bys
- scrub barrier()

Sinan Kaya (7):
  i40e/i40evf: Eliminate duplicate barriers on weakly-ordered archs
  ixgbe: eliminate duplicate barriers on weakly-ordered archs
  igbvf: eliminate duplicate barriers on weakly-ordered archs
  igb: eliminate duplicate barriers on weakly-ordered archs
  ixgbevf: keep writel() closer to wmb()
  ixgbevf: eliminate duplicate barriers on weakly-ordered archs
  fm10k: Eliminate duplicate barriers on weakly-ordered archs

 drivers/net/ethernet/intel/fm10k/fm10k_main.c     | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.c       | 8 ++++----
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c     | 4 ++--
 drivers/net/ethernet/intel/igb/igb_main.c         | 4 ++--
 drivers/net/ethernet/intel/igbvf/netdev.c         | 4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 8 ++++----
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      | 5 -----
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 4 ++--
 8 files changed, 18 insertions(+), 23 deletions(-)

-- 
2.7.4
