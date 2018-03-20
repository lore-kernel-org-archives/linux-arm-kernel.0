From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 19 Mar 2018 22:50:00 -0400
Subject: [PATCH v4 0/7] scsi: Eliminate duplicate barriers on weakly-ordered
 archs
Message-ID: <1521514207-10695-1-git-send-email-okaya@codeaurora.org>
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
- group patches together into subsystems scsi:...
- collect reviewed and tested bys
- scrub barrier()

Sinan Kaya (7):
  scsi: hpsa: Eliminate duplicate barriers on weakly-ordered archs
  scsi: megaraid: eliminate duplicate barriers on weakly-ordered archs
  scsi: dpt_i2o: eliminate duplicate barriers on weakly-ordered archs
  scsi: lpfc: Eliminate duplicate barriers on weakly-ordered archs
  scsi: ipr: Eliminate duplicate barriers on weakly-ordered archs
  scsi: bnx2i: Eliminate duplicate barriers on weakly-ordered archs
  scsi: csiostor: Eliminate duplicate barriers on weakly-ordered archs

 drivers/scsi/bnx2i/bnx2i_hwi.c              | 2 +-
 drivers/scsi/csiostor/csio_hw.h             | 4 ++++
 drivers/scsi/csiostor/csio_wr.c             | 2 +-
 drivers/scsi/dpt_i2o.c                      | 6 +++---
 drivers/scsi/hpsa.h                         | 2 +-
 drivers/scsi/ipr.c                          | 7 ++++---
 drivers/scsi/lpfc/lpfc_sli.c                | 4 ++--
 drivers/scsi/megaraid/megaraid_mbox.c       | 8 ++++----
 drivers/scsi/megaraid/megaraid_mbox.h       | 2 ++
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 4 ++--
 10 files changed, 24 insertions(+), 17 deletions(-)

-- 
2.7.4
