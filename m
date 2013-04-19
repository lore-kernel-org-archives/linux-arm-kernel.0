From: gang.chen@asianux.com (Chen Gang)
Date: Fri, 19 Apr 2013 18:53:07 +0800
Subject: [PATCH] ARM64: kernel: compiling issue,
 duplicate definition of early_console
In-Reply-To: <516E66F9.9070904@asianux.com>
References: <5152DB83.8080703@asianux.com>
 <20130327115509.GA1603@MacBook-Pro.local> <5152DFF1.2090000@asianux.com>
 <515BE49C.8040601@asianux.com> <515C14FD.4040703@codeaurora.org>
 <515C2808.70406@asianux.com> <516E66F9.9070904@asianux.com>
Message-ID: <51712213.4060607@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  when compiling with allmodconfig.
    early_console is already defined as an extern global pointer.

  need let it point to the object which we intend to (like ARM32 done).


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm64/kernel/early_printk.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/early_printk.c
b/arch/arm64/kernel/early_printk.c
index ac974f4..fbb6e18 100644
--- a/arch/arm64/kernel/early_printk.c
+++ b/arch/arm64/kernel/early_printk.c
@@ -95,7 +95,7 @@ static void early_write(struct console *con, const
char *s, unsigned n)
 	}
 }

-static struct console early_console = {
+static struct console early_console_dev = {
 	.name =		"earlycon",
 	.write =	early_write,
 	.flags =	CON_PRINTBUFFER | CON_BOOT,
@@ -145,7 +145,8 @@ static int __init setup_early_printk(char *buf)
 		early_base = early_io_map(paddr, EARLYCON_IOBASE);

 	printch = match->printch;
-	register_console(&early_console);
+	early_console = &early_console_dev;
+	register_console(&early_console_dev);

 	return 0;
 }
-- 
1.7.7.6
