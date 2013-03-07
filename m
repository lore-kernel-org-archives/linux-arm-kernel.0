From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu,  7 Mar 2013 22:26:27 +0100
Subject: [PATCH 2/9] console: switch to kfifo_dump_str
In-Reply-To: <1362691594-32286-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130307212523.GK4401@game.jcrosoft.org>
 <1362691594-32286-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1362691594-32286-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 common/console.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/common/console.c b/common/console.c
index beb37bd..243d402 100644
--- a/common/console.c
+++ b/common/console.c
@@ -55,6 +55,11 @@ static struct kfifo __console_output_fifo;
 static struct kfifo *console_input_fifo = &__console_input_fifo;
 static struct kfifo *console_output_fifo = &__console_output_fifo;
 
+static void console_output_dump(unsigned char ch)
+{
+	console_putc(CONSOLE_STDOUT, ch);
+}
+
 static int console_std_set(struct device_d *dev, struct param_d *param,
 		const char *val)
 {
@@ -86,14 +91,12 @@ static int console_std_set(struct device_d *dev, struct param_d *param,
 	dev_param_set_generic(dev, param, active);
 
 	if (initialized < CONSOLE_INIT_FULL) {
-		char ch;
 		initialized = CONSOLE_INIT_FULL;
 		PUTS_LL("Switch to console [");
 		PUTS_LL(dev_name(dev));
 		PUTS_LL("]\n");
 		barebox_banner();
-		while (kfifo_getc(console_output_fifo, &ch) == 0)
-			console_putc(CONSOLE_STDOUT, ch);
+		kfifo_dump_str(console_output_fifo, console_output_dump);
 	}
 
 	return 0;
-- 
1.7.10.4
