From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 19 Mar 2018 22:47:42 -0400
Subject: [PATCH v4 0/6] ib: Eliminate duplicate barriers on weakly-ordered
 archs
Message-ID: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
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
- group patches together into subsystems ib:...
- collect reviewed and tested bys
- scrub barrier()

Sinan Kaya (6):
  RDMA/bnxt_re: Eliminate duplicate barriers on weakly-ordered archs
  IB/mlx4: Eliminate duplicate barriers on weakly-ordered archs
  RDMA/i40iw: Eliminate duplicate barriers on weakly-ordered archs
  infiniband: cxgb4: Eliminate duplicate barriers on weakly-ordered
    archs
  IB/nes: Eliminate duplicate barriers on weakly-ordered archs
  RDMA/qedr: eliminate duplicate barriers on weakly-ordered archs #2

 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  8 ++++----
 drivers/infiniband/hw/cxgb4/t4.h           | 14 +++++++-------
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c   |  6 ++++--
 drivers/infiniband/hw/i40iw/i40iw_osdep.h  |  1 +
 drivers/infiniband/hw/i40iw/i40iw_uk.c     |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_utils.c  | 11 +++++++++++
 drivers/infiniband/hw/mlx4/qp.c            |  4 ++--
 drivers/infiniband/hw/nes/nes.h            |  5 +++++
 drivers/infiniband/hw/nes/nes_hw.c         | 21 ++++++++++++++-------
 drivers/infiniband/hw/nes/nes_mgt.c        | 15 ++++++++++-----
 drivers/infiniband/hw/nes/nes_nic.c        |  2 +-
 drivers/infiniband/hw/nes/nes_utils.c      |  3 ++-
 drivers/infiniband/hw/nes/nes_verbs.c      |  5 +++--
 drivers/infiniband/hw/qedr/verbs.c         |  4 ++--
 14 files changed, 67 insertions(+), 34 deletions(-)

-- 
2.7.4
