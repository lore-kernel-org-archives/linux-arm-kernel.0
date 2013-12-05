From: k.khlebnikov@samsung.com (Konstantin Khlebnikov)
Date: Thu, 05 Dec 2013 17:30:16 +0400
Subject: [PATCH 2/2] ARM64: fix framepointer check in unwind_frame
In-Reply-To: <20131205133010.16410.96824.stgit@buzz>
References: <20131205133010.16410.96824.stgit@buzz>
Message-ID: <20131205133016.16410.42062.stgit@buzz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need at least 24 bytes above frame pointer.

Signed-off-by: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
---
 arch/arm64/kernel/stacktrace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index d25459f..c3b6c63 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -43,7 +43,7 @@ int unwind_frame(struct stackframe *frame)
 	low  = frame->sp;
 	high = ALIGN(low, THREAD_SIZE);
 
-	if (fp < low || fp > high || fp & 0xf)
+	if (fp < low || fp > high - 0x18 || fp & 0xf)
 		return -EINVAL;
 
 	frame->sp = fp + 0x10;
