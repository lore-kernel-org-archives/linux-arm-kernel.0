From: stefan@the2masters.de (Stefan Hellermann)
Date: Fri, 23 Feb 2018 21:17:48 +0100
Subject: [PATCH] net: Allow mac_pton() to work on non-NULL terminated strings
In-Reply-To: <20180223182006.GA2116@avx2>
References: <20180223182006.GA2116@avx2>
Message-ID: <20180223201748.14328-1-stefan@the2masters.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 4904dbda41c8 ("ARM: orion5x: use mac_pton() helper") crashes my
QNAP TS-209 NAS early on boot.

The boot code for the TS-209 is looping through an ext2 filesystem on a
384kB mtd partition (factory configuration put there by QNAP). There it
looks on every 1kB boundary if there is a valid MAC address. The
filesystem has a 1kB block size, so this seems to work.

On my device the MAC address is on the 37th 1kB block. But: On the 27th
block is a large file (1,5kB) without 0 bytes inside. The code in
qnap_tsx09_find_mac_addr() maps 1kB into memory (not a whole file or the
whole 384kB) and then calls qnap_tsx09_check_mac_addr() -> mac_pton() ->
strlen() on this memory block. as there is no 0 byte in the file on the
27th block, strlen() runs into bad memory and the machine panics. The old
code had no strlen().

Actually mac_pton() doesn't need to call strlen(), the following loop
catches short strings quite nicely. The strlen() seems to be an
optimization for calls to mac_pton with empty string. But this is rarely
the case and this is not a hot path. Remove it to reduce code size and
speed up calls with an not empty string.

Besides fixing the crash there is are other users interested in
this change, see https://patchwork.ozlabs.org/patch/851008/

Fixes: 4904dbda41c8 ("ARM: orion5x: use mac_pton() helper")
Signed-off-by: Stefan Hellermann <stefan@the2masters.de>
Cc: <stable@vger.kernel.org> [4.4+]
---
 lib/net_utils.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/net_utils.c b/lib/net_utils.c
index af525353395d..9d38da67ee44 100644
--- a/lib/net_utils.c
+++ b/lib/net_utils.c
@@ -8,10 +8,6 @@ bool mac_pton(const char *s, u8 *mac)
 {
 	int i;
 
-	/* XX:XX:XX:XX:XX:XX */
-	if (strlen(s) < 3 * ETH_ALEN - 1)
-		return false;
-
 	/* Don't dirty result unless string is valid MAC. */
 	for (i = 0; i < ETH_ALEN; i++) {
 		if (!isxdigit(s[i * 3]) || !isxdigit(s[i * 3 + 1]))
-- 
2.11.0
