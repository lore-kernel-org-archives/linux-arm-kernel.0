From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu,  3 Feb 2011 15:48:35 -0800
Subject: [PATCHv2 2/3] hvc_dcc: Simplify put_chars()/get_chars() loops
In-Reply-To: <1296776916-21018-1-git-send-email-sboyd@codeaurora.org>
References: <20110203221742.GA4159@kroah.com>
	<1296776916-21018-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1296776916-21018-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Casting and anding with 0xff is unnecessary in
hvc_dcc_put_chars() since buf is already a char[].
__dcc_get_char() can't return an int less than 0 since it only
returns a char. Simplify the if statement in hvc_dcc_get_chars()
to take this into account.

Cc: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/tty/hvc/hvc_dcc.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
index 155ec10..ad23cc8 100644
--- a/drivers/tty/hvc/hvc_dcc.c
+++ b/drivers/tty/hvc/hvc_dcc.c
@@ -89,7 +89,7 @@ static int hvc_dcc_put_chars(uint32_t vt, const char *buf, int count)
 		while (__dcc_getstatus() & DCC_STATUS_TX)
 			cpu_relax();
 
-		__dcc_putchar((char)(buf[i] & 0xFF));
+		__dcc_putchar(buf[i]);
 	}
 
 	return count;
@@ -99,15 +99,11 @@ static int hvc_dcc_get_chars(uint32_t vt, char *buf, int count)
 {
 	int i;
 
-	for (i = 0; i < count; ++i) {
-		int c = -1;
-
+	for (i = 0; i < count; ++i)
 		if (__dcc_getstatus() & DCC_STATUS_RX)
-			c = __dcc_getchar();
-		if (c < 0)
+			buf[i] = __dcc_getchar();
+		else
 			break;
-		buf[i] = c;
-	}
 
 	return i;
 }
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
