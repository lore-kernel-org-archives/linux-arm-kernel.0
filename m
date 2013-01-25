From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 22:44:02 +0000
Subject: [PATCH 03/19] ARM: msm: proc_comm_boot_wait should not be __init
In-Reply-To: <1359153858-31992-1-git-send-email-arnd@arndb.de>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359153858-31992-1-git-send-email-arnd@arndb.de>
Message-ID: <1359153858-31992-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

msm_smd_probe is a driver probe function and may get
called after the __init time, so it must not call
any __init function, as the link-time warning reports.
Take away the __init annotation on proc_comm_boot_wait
to fix this.

Without this patch, building msm_defconfig results in:

WARNING: vmlinux.o(.text+0xb048): Section mismatch in reference from the function msm_smd_probe() to the function .init.text:proc_comm_boot_wait()
The function msm_smd_probe() references
the function __init proc_comm_boot_wait().
This is often because msm_smd_probe lacks a __init
annotation or the annotation of proc_comm_boot_wait is wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: David Brown <davidb@codeaurora.org>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Cc: linux-arm-msm at vger.kernel.org
---
 arch/arm/mach-msm/proc_comm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-msm/proc_comm.h b/arch/arm/mach-msm/proc_comm.h
index 12da4ca..e8d043a 100644
--- a/arch/arm/mach-msm/proc_comm.h
+++ b/arch/arm/mach-msm/proc_comm.h
@@ -253,6 +253,6 @@ enum {
 		(((drvstr) & 0xF) << 17))
 
 int msm_proc_comm(unsigned cmd, unsigned *data1, unsigned *data2);
-void __init proc_comm_boot_wait(void);
+void proc_comm_boot_wait(void);
 
 #endif
-- 
1.8.0
