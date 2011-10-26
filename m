From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 25 Oct 2011 19:19:43 -0700
Subject: [PATCH] hvc_dcc: Fix duplicate character inputs
Message-ID: <1319595583-29546-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reading from the DCC grabs a character from the buffer and
clears the status bit. Since this is a context-changing
operation, instructions following the character read that rely on
the status bit being accurate need to be synchronized with an
ISB.

In this case, the status bit check needs to execute after the
character read otherwise we run the risk of reading the character
and checking the status bit before the read can clear the status
bit in the first place. When this happens, the user will see the
same character they typed twice, instead of once.

Add an ISB after the read and the write, so that the status check
is synchronized with the read/write operations.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/tty/hvc/hvc_dcc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
index 435f6fa..44fbeba 100644
--- a/drivers/tty/hvc/hvc_dcc.c
+++ b/drivers/tty/hvc/hvc_dcc.c
@@ -46,6 +46,7 @@ static inline char __dcc_getchar(void)
 
 	asm volatile("mrc p14, 0, %0, c0, c5, 0	@ read comms data reg"
 		: "=r" (__c));
+	isb();
 
 	return __c;
 }
@@ -55,6 +56,7 @@ static inline void __dcc_putchar(char c)
 	asm volatile("mcr p14, 0, %0, c0, c5, 0	@ write a char"
 		: /* no output register */
 		: "r" (c));
+	isb();
 }
 
 static int hvc_dcc_put_chars(uint32_t vt, const char *buf, int count)
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
