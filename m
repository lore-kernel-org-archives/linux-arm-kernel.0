From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri,  2 Dec 2016 15:05:42 +0000
Subject: [RFC v3 PATCH 24/25] scsi: bnx2i: bnx2fc: add dependency on MMU
In-Reply-To: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
References: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480691143-19845-25-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both SCSI_BNX2_ISCSI and SCSI_BNX2X_FCOE select CNIC which it turn
select UIO. The later one is dependant on MMU, so while fixing CNIC
for NOMMU build (by adding explicit dependency on MMU) following
warning shows up:

warning: (SCSI_BNX2_ISCSI && SCSI_BNX2X_FCOE) selects CNIC which has
unmet direct dependencies (NETDEVICES && ETHERNET &&
NET_VENDOR_BROADCOM && PCI && (IPV6 || IPV6=n) && MMU)

Fix it with making SCSI_BNX2_ISCSI and SCSI_BNX2X_FCOE dependant on
MMU.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 drivers/scsi/bnx2fc/Kconfig |    1 +
 drivers/scsi/bnx2i/Kconfig  |    1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/scsi/bnx2fc/Kconfig b/drivers/scsi/bnx2fc/Kconfig
index d401a09..7862f72 100644
--- a/drivers/scsi/bnx2fc/Kconfig
+++ b/drivers/scsi/bnx2fc/Kconfig
@@ -1,5 +1,6 @@
 config SCSI_BNX2X_FCOE
 	tristate "QLogic FCoE offload support"
+	depends on MMU
 	depends on PCI
 	depends on (IPV6 || IPV6=n)
 	depends on LIBFC
diff --git a/drivers/scsi/bnx2i/Kconfig b/drivers/scsi/bnx2i/Kconfig
index ba30ff8..0549267 100644
--- a/drivers/scsi/bnx2i/Kconfig
+++ b/drivers/scsi/bnx2i/Kconfig
@@ -1,5 +1,6 @@
 config SCSI_BNX2_ISCSI
 	tristate "QLogic NetXtreme II iSCSI support"
+	depends on MMU
 	depends on NET
 	depends on PCI
 	depends on (IPV6 || IPV6=n)
-- 
1.7.9.5
