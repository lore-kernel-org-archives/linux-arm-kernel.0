From: will.deacon@arm.com (Will Deacon)
Date: Thu, 22 Feb 2018 14:00:50 +0000
Subject: [PATCH 2/9] arm64: signal: Force SIGKILL for unknown signals in
 force_signal_inject
In-Reply-To: <1519308057-4953-1-git-send-email-will.deacon@arm.com>
References: <1519308057-4953-1-git-send-email-will.deacon@arm.com>
Message-ID: <1519308057-4953-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For signals other than SIGKILL or those with siginfo_layout(signal, code)
== SIL_FAULT then force_signal_inject does not initialise the siginfo_t
properly. Since the signal number is determined solely by the caller,
simply WARN on unknown signals and force to SIGKILL.

Reported-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/traps.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index c478d8e27649..3f52c07b4bf4 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -331,6 +331,12 @@ void force_signal_inject(int signal, int code, unsigned long address)
 		break;
 	}
 
+	/* Force signals we don't understand to SIGKILL */
+	if (WARN_ON(signal != SIGKILL ||
+		    siginfo_layout(signal, code) != SIL_FAULT)) {
+		signal = SIGKILL;
+	}
+
 	if (unhandled_signal(current, signal) &&
 	    show_unhandled_signals_ratelimited()) {
 		pr_info("%s[%d]: %s: pc=%08llx\n",
-- 
2.1.4
