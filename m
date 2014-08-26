From: jcm@redhat.com (Jon Masters)
Date: Tue, 26 Aug 2014 16:23:38 -0400
Subject: [PATCH V2] setup: Move unmask of async interrupts after possible
 earlycon setup
Message-ID: <1409084618-14693-1-git-send-email-jcm@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel wants to enable reporting of asynchronous interrupts (i.e.
System Errors) as early as possible. But if this happens too early then
any pending System Error on initial entry into the kernel may never be
reported where a user can see it. This situation will occur if the kernel
is configured with CONFIG_PANIC_ON_OOPS set and (default or command line)
enabled, in which case the kernel will panic as intended, however the
associated logging messages indicating this failure condition will remain
only in the kernel ring buffer and never be flushed out to the (not yet
configured) console. Therefore, this patch moves the enabling of
asynchronous interrupts during early setup to as early as reasonable,
but after parsing any possible earlycon parameters setting up earlycon.

Signed-off-by: Jon Masters <jcm@redhat.com>
---
 arch/arm64/kernel/setup.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index f6f0ccf..f849b88 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -362,11 +362,6 @@ u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
 
 void __init setup_arch(char **cmdline_p)
 {
-	/*
-	 * Unmask asynchronous aborts early to catch possible system errors.
-	 */
-	local_async_enable();
-
 	setup_processor();
 
 	setup_machine_fdt(__fdt_pointer);
@@ -382,6 +377,12 @@ void __init setup_arch(char **cmdline_p)
 
 	parse_early_param();
 
+	/*
+	 *  Unmask asynchronous aborts after bringing up possible earlycon.
+	 * (Report possible System Errors once we can report this occurred)
+	 */
+	local_async_enable();
+
 	efi_init();
 	arm64_memblock_init();
 
-- 
1.8.3.1
