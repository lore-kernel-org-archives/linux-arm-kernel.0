From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Sat,  4 Nov 2017 13:30:52 +0900
Subject: [PATCH -next 1/2] arm: kprobes: Fix kretprobe test to check correct
 counter
In-Reply-To: <150976982219.2012.12861503668350308669.stgit@devbox>
References: <150976982219.2012.12861503668350308669.stgit@devbox>
Message-ID: <150976985182.2012.15495311380682779381.stgit@devbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

test_kretprobe() uses jprobe_func_called at the
last test, but it must check kretprobe_handler_called.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm/probes/kprobes/test-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
index 1c98a87786ca..9c3ceba69015 100644
--- a/arch/arm/probes/kprobes/test-core.c
+++ b/arch/arm/probes/kprobes/test-core.c
@@ -451,7 +451,7 @@ static int test_kretprobe(long (*func)(long, long))
 	}
 	if (!call_test_func(func, false))
 		return -EINVAL;
-	if (jprobe_func_called == test_func_instance) {
+	if (kretprobe_handler_called == test_func_instance) {
 		pr_err("FAIL: kretprobe called after unregistering\n");
 		return -EINVAL;
 	}
