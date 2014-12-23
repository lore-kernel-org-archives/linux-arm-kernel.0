From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 23 Dec 2014 13:09:34 +0300
Subject: [PATCH] ARM: sa1100: clear RCSR_SMR on resume
Message-ID: <1419329374-4372-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

StrongARM core uses RCSR SMR bit to tell to bootloader that it was reset
by entering the sleep mode. After we have resumed, there is little point
in having that bit enabled. Moreover, if this bit is set before reboot,
the bootloader can become confused. Thus clear the SMR bit on resume
just before clearing the scratchpad (resume address) register.

Cc: stable at vger.kernel.org
Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sa1100/pm.c b/arch/arm/mach-sa1100/pm.c
index 6645d1e..34853d5 100644
--- a/arch/arm/mach-sa1100/pm.c
+++ b/arch/arm/mach-sa1100/pm.c
@@ -81,6 +81,7 @@ static int sa11x0_pm_enter(suspend_state_t state)
 	/*
 	 * Ensure not to come back here if it wasn't intended
 	 */
+	RCSR = RCSR_SMR;
 	PSPR = 0;
 
 	/*
-- 
2.1.3
