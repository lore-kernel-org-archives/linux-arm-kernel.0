From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed,  8 Jul 2015 18:16:47 +0100
Subject: [PATCH v2 1/5] drivers: firmware: psci: add INVALID_ADDRESS return
 value
In-Reply-To: <1436375811-10529-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1436375811-10529-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1436375811-10529-2-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PSCI 1.0 introduces the INVALID_ADDRESS return value for functions
that take an address as input parameter (eg CPU_SUSPEND).

This patch adds INVALID_ADDRESS return value to kernel code and
updates the PSCI to linux error conversion to take it into account.

The kernel error value associated to INVALID_ADDRESS is set to
the error returned when the PSCI error code is INVALID_PARAMETERS
to comply with current call sites expected return value, given
that the kernel at present has no use for the additional error
information reported.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/firmware/psci.c   | 1 +
 include/uapi/linux/psci.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 81b70da..62d9bc1 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -78,6 +78,7 @@ static int psci_to_linux_errno(int errno)
 	case PSCI_RET_NOT_SUPPORTED:
 		return -EOPNOTSUPP;
 	case PSCI_RET_INVALID_PARAMS:
+	case PSCI_RET_INVALID_ADDRESS:
 		return -EINVAL;
 	case PSCI_RET_DENIED:
 		return -EPERM;
diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index 310d83e..64469e6 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -86,5 +86,6 @@
 #define PSCI_RET_INTERNAL_FAILURE		-6
 #define PSCI_RET_NOT_PRESENT			-7
 #define PSCI_RET_DISABLED			-8
+#define PSCI_RET_INVALID_ADDRESS		-9
 
 #endif /* _UAPI_LINUX_PSCI_H */
-- 
2.2.1
