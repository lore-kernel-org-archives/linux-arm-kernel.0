From: eric.auger@linaro.org (Eric Auger)
Date: Fri, 29 Jan 2016 14:43:06 +0000
Subject: [PATCH] vfio: pci: fix oops in case of vfio_msi_set_vector_signal
 failure
Message-ID: <1454078586-5431-1-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case vfio_msi_set_vector_signal fails we tear down everything.
In the tear down loop we compare int j against unsigned start. Given
the arithmetic conversion I think it is converted into an unsigned and
becomes 0xffffffff, leading to the loop being entered again and things
turn bad when accessing vdev->msix[vector].vector. So let's use int
parameters instead.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 drivers/vfio/pci/vfio_pci_intrs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 3b3ba15..510c48d 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -374,8 +374,8 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_device *vdev,
 	return 0;
 }
 
-static int vfio_msi_set_block(struct vfio_pci_device *vdev, unsigned start,
-			      unsigned count, int32_t *fds, bool msix)
+static int vfio_msi_set_block(struct vfio_pci_device *vdev, int start,
+			      int count, int32_t *fds, bool msix)
 {
 	int i, j, ret = 0;
 
-- 
1.9.1
