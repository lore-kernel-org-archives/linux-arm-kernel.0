From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Jun 2010 15:04:46 +0100
Subject: [PATCH 2/4] ARM: atomic ops: reduce critical region in
	atomic64_cmpxchg
In-Reply-To: <1277906688-12065-2-git-send-email-will.deacon@arm.com>
References: <1277906688-12065-1-git-send-email-will.deacon@arm.com>
	<1277906688-12065-2-git-send-email-will.deacon@arm.com>
Message-ID: <1277906688-12065-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to reduce the likelihood of failure in a load/store
exclusive block, the number of intervening instructions should
be kept to a minimum.

This patch hoists a mov operation out of the critical region
in atomic64_cmpxchg.

Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/atomic.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index e9e56c0..4f0f282 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -358,8 +358,8 @@ static inline u64 atomic64_cmpxchg(atomic64_t *ptr, u64 old, u64 new)
 
 	do {
 		__asm__ __volatile__("@ atomic64_cmpxchg\n"
-		"ldrexd		%1, %H1, [%2]\n"
 		"mov		%0, #0\n"
+		"ldrexd		%1, %H1, [%2]\n"
 		"teq		%1, %3\n"
 		"teqeq		%H1, %H3\n"
 		"strexdeq	%0, %4, %H4, [%2]"
-- 
1.6.3.3
