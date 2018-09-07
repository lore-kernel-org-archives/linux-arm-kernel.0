From: valentin.schneider@arm.com (Valentin Schneider)
Date: Fri,  7 Sep 2018 21:13:20 +0100
Subject: [PATCH 1/1] arm64: defconfig: Update UFSHCD for Hi3660 soc
Message-ID: <1536351200-1427-1-git-send-email-valentin.schneider@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7ee7ef24d02d ("scsi: arm64: defconfig: enable configs for
Hisilicon ufs") enabled the Hisilicon UFS, which means that we can
flash a rootfs to the on-board flash. However, as it stands, the
kernel gets stuck on:

[    3.360733] Waiting for root device /dev/sdd10...

That seems to be because even though we have SCSI_UFS_HISI=y,
SCSI_UFSHCD and SCSI_UFSHCD_PLATFORM are set to 'm', which means the
required drivers won't be built-in.

We need those to load the rootfs and then load the modules, so set
them as built-ins.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/arm64/configs/defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index db8d364..ab7f80a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -193,8 +193,8 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_SAS_ATA=y
 CONFIG_SCSI_HISI_SAS=y
 CONFIG_SCSI_HISI_SAS_PCI=y
-CONFIG_SCSI_UFSHCD=m
-CONFIG_SCSI_UFSHCD_PLATFORM=m
+CONFIG_SCSI_UFSHCD=y
+CONFIG_SCSI_UFSHCD_PLATFORM=y
 CONFIG_SCSI_UFS_HISI=y
 CONFIG_SCSI_UFS_QCOM=m
 CONFIG_ATA=y
-- 
2.7.4
