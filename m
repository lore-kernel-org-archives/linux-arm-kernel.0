From: labbott@redhat.com (Laura Abbott)
Date: Tue,  6 Dec 2016 15:50:53 -0800
Subject: [PATCHv5 07/11] drivers: firmware: psci: Use __pa_symbol for kernel
 symbol
In-Reply-To: <1481068257-6367-1-git-send-email-labbott@redhat.com>
References: <1481068257-6367-1-git-send-email-labbott@redhat.com>
Message-ID: <1481068257-6367-8-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__pa_symbol is technically the macro that should be used for kernel
symbols. Switch to this as a pre-requisite for DEBUG_VIRTUAL which
will do bounds checking.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v5: Split off from arm64 __pa_symbol conversion
---
 drivers/firmware/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 8263429..9defbe2 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -383,7 +383,7 @@ static int psci_suspend_finisher(unsigned long index)
 	u32 *state = __this_cpu_read(psci_power_state);
 
 	return psci_ops.cpu_suspend(state[index - 1],
-				    virt_to_phys(cpu_resume));
+				    __pa_symbol(cpu_resume));
 }
 
 int psci_cpu_suspend_enter(unsigned long index)
-- 
2.7.4
