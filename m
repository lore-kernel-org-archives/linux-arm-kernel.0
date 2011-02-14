From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Feb 2011 20:02:22 +0000
Subject: [PATCH] Ensure predictable endian state on signal handler entry
Message-ID: <20110214200222.GD31103@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure a predictable endian state when entering signal handlers.  This
avoids programs which use SETEND to momentarily switch their endian
state from having their signal handlers entered with an unpredictable
endian state.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
--

 arch/arm/kernel/signal.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 907d5a6..abaf844 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -474,7 +474,9 @@ setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 	unsigned long handler = (unsigned long)ka->sa.sa_handler;
 	unsigned long retcode;
 	int thumb = 0;
-	unsigned long cpsr = regs->ARM_cpsr & ~PSR_f;
+	unsigned long cpsr = regs->ARM_cpsr & ~(PSR_f | PSR_E_BIT);
+
+	cpsr |= PSR_ENDSTATE;
 
 	/*
 	 * Maybe we need to deliver a 32-bit signal to a 26-bit task.
