From: cburden@codeaurora.org (Cassidy Burden)
Date: Tue, 28 Jul 2015 12:09:24 -0700
Subject: [PATCH] lib: Make _find_next_bit helper function inline
Message-ID: <1438110564-19932-1-git-send-email-cburden@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've tested Yury Norov's find_bit reimplementation with the test_find_bit
module (https://lkml.org/lkml/2015/3/8/141) and measured about 35-40%
performance degradation on arm64 3.18 run with fixed CPU frequency.

The performance degradation appears to be caused by the
helper function _find_next_bit. After inlining this function into
find_next_bit and find_next_zero_bit I get slightly better performance
than the old implementation:

find_next_zero_bit          find_next_bit
old      new     inline     old      new     inline
26       36      24         24       33      23
25       36      24         24       33      23
26       36      24         24       33      23
25       36      24         24       33      23
25       36      24         24       33      23
25       37      24         24       33      23
25       37      24         24       33      23
25       37      24         24       33      23
25       36      24         24       33      23
25       37      24         24       33      23

Signed-off-by: Cassidy Burden <cburden@codeaurora.org>
Cc: Alexey Klimov <klimov.linux@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Daniel Borkmann <dborkman@redhat.com>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
Cc: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: Mark Salter <msalter@redhat.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Thomas Graf <tgraf@suug.ch>
Cc: Valentin Rothberg <valentinrothberg@gmail.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
---
 lib/find_bit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/find_bit.c b/lib/find_bit.c
index 18072ea..d0e04f9 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -28,7 +28,7 @@
  * find_next_zero_bit.  The difference is the "invert" argument, which
  * is XORed with each fetched word before searching it for one bits.
  */
-static unsigned long _find_next_bit(const unsigned long *addr,
+static inline unsigned long _find_next_bit(const unsigned long *addr,
 		unsigned long nbits, unsigned long start, unsigned long invert)
 {
 	unsigned long tmp;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
