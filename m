From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 10 Apr 2013 18:00:11 -0700
Subject: [PATCH] ARM: msm: Fix uncompess.h tx underrun check
Message-ID: <1365642011-4664-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bit 3 of the SR register is set if there is a tx underrun. If
this bit isn't set, we should loop on the tx ready bit until we
can transmit again. Otherwise we should skip the loop and
transmit immediately. The code is doing the opposite though,
checking for an underrun and then looping on the tx ready bit
causing us to never loop on the tx read bit when the tx buffer
may not be ready.

This doesn't seem to affect my 8960 device too often, but in some
cases I see a lost character or two from the decompressor prints.
This also matches what we do in the assembly in debug-macro.S.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Nobody has noticed this so far so I'm ok waiting for 3.10 on this one. Also
it doesn't improve stability (debug feature) so I don't see a reason to send
it to stable.

 arch/arm/mach-msm/include/mach/uncompress.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-msm/include/mach/uncompress.h b/arch/arm/mach-msm/include/mach/uncompress.h
index fa97a10..9432487 100644
--- a/arch/arm/mach-msm/include/mach/uncompress.h
+++ b/arch/arm/mach-msm/include/mach/uncompress.h
@@ -37,7 +37,7 @@ static void putc(int c)
 	 * Wait for TX_READY to be set; but skip it if we have a
 	 * TX underrun.
 	 */
-	if (UART_DM_SR & 0x08)
+	if (!(UART_DM_SR & 0x08))
 		while (!(UART_DM_ISR & 0x80))
 			cpu_relax();
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
