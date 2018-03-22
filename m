From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 22 Mar 2018 12:26:46 -0400
Subject: [PATCH v5 0/3] ib: Eliminate duplicate barriers on weakly-ordered
 archs
Message-ID: <1521736009-23387-1-git-send-email-okaya@codeaurora.org>
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

Changes since v4:
- collect reviewed and acked bys
- drop cxgb4

Sinan Kaya (3):
  RDMA/bnxt_re: Eliminate duplicate barriers on weakly-ordered archs
  RDMA/i40iw: Eliminate duplicate barriers on weakly-ordered archs
  RDMA/qedr: eliminate duplicate barriers on weakly-ordered archs #2

 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  9 +++++----
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c   |  6 ++++--
 drivers/infiniband/hw/i40iw/i40iw_osdep.h  |  1 +
 drivers/infiniband/hw/i40iw/i40iw_uk.c     |  3 ++-
 drivers/infiniband/hw/i40iw/i40iw_utils.c  | 11 +++++++++++
 drivers/infiniband/hw/qedr/verbs.c         |  4 ++--
 6 files changed, 25 insertions(+), 9 deletions(-)

-- 
2.7.4
