From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue,  2 Sep 2014 14:00:46 +0100
Subject: [PATCH v11 12/19] serial: kgdb_nmi: No CON_ENABLED by default
In-Reply-To: <1409662853-29313-1-git-send-email-daniel.thompson@linaro.org>
References: <1408466769-20004-1-git-send-email-daniel.thompson@linaro.org>
 <1409662853-29313-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1409662853-29313-13-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At present this console is selectively enabled/disabled by NULL checking
arch_kgdb_ops.enable_nmi. In practice this requires the architecture
dependant code to implement some kind of control (e.g. module arguments)
to enable/disable the feature.

The kernel already provide the perfectly adequade console= argument to
do this. Let's us that instead, if nothing else, it makes any
documentation architecture neutral.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/tty/serial/kgdb_nmi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index 6ec7501..129dc5b 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -46,6 +46,8 @@ static atomic_t kgdb_nmi_num_readers = ATOMIC_INIT(0);
 
 static int kgdb_nmi_console_setup(struct console *co, char *options)
 {
+	arch_kgdb_ops.enable_nmi(1);
+
 	/* The NMI console uses the dbg_io_ops to issue console messages. To
 	 * avoid duplicate messages during kdb sessions we must inform kdb's
 	 * I/O utilities that messages sent to the console will automatically
@@ -77,7 +79,7 @@ static struct console kgdb_nmi_console = {
 	.setup  = kgdb_nmi_console_setup,
 	.write	= kgdb_nmi_console_write,
 	.device	= kgdb_nmi_console_device,
-	.flags	= CON_PRINTBUFFER | CON_ANYTIME | CON_ENABLED,
+	.flags	= CON_PRINTBUFFER | CON_ANYTIME,
 	.index	= -1,
 };
 
@@ -354,7 +356,6 @@ int kgdb_register_nmi_console(void)
 	}
 
 	register_console(&kgdb_nmi_console);
-	arch_kgdb_ops.enable_nmi(1);
 
 	return 0;
 err_drv_reg:
-- 
1.9.3
