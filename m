From: schwab@suse.de (Andreas Schwab)
Date: Tue, 26 Feb 2013 17:55:54 +0100
Subject: [PATCH] arm64: fix padding computation in struct ucontext
Message-ID: <mvmy5ebt3ol.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The expression to compute the padding needed to fill the uc_sigmask field
to 1024 bits actually computes the padding needed for 1080 bits.
Fortunately, due to the 16-byte alignment of the following field
(uc_mcontext) the definition in glibc contains enough bytes of padding
after uc_sigmask so that the overall offsets and size match in both
definitions.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 arch/arm64/include/asm/ucontext.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/ucontext.h b/arch/arm64/include/asm/ucontext.h
index bde9607..42e04c8 100644
--- a/arch/arm64/include/asm/ucontext.h
+++ b/arch/arm64/include/asm/ucontext.h
@@ -22,7 +22,7 @@ struct ucontext {
 	stack_t		  uc_stack;
 	sigset_t	  uc_sigmask;
 	/* glibc uses a 1024-bit sigset_t */
-	__u8		  __unused[(1024 - sizeof(sigset_t)) / 8];
+	__u8		  __unused[1024 / 8 - sizeof(sigset_t)];
 	/* last for future expansion */
 	struct sigcontext uc_mcontext;
 };
-- 
1.8.1.4


-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
