From: sedat.dilek@gmail.com (Sedat Dilek)
Date: Tue, 17 Jul 2012 13:33:13 +0200
Subject: [PATCH -next] random: Remove remaining relicts of
 rand_initialize_irq()
Message-ID: <1342524793-2522-1-git-send-email-sedat.dilek@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rand_initialize_irq() was removed here:

commit 946672f548682905d8ecdab33bb6e2c705418505
"random: remove rand_initialize_irq()"

The AB3100 mfd-driver is the only driver still using it and breaks
with the following error-messages in linux-next (next-20120717):
...
drivers/built-in.o: In function `ab3100_probe':
ab3100-core.c:(.devinit.text+0xbf97): undefined reference to `rand_initialize_irq'

Fix this issue and remove all remaining relicts of rand_initialize_irq().

Might be worth to fold-in these changes into the original commit.

Tested against linux-next (next-20120717) on a Ubuntu/precise AMD64 host.

[ v2: Polish up subject and commit message ]

Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 arch/ia64/kernel/irq_ia64.c |    1 -
 drivers/mfd/ab3100-core.c   |    2 --
 include/linux/random.h      |    2 --
 3 files changed, 5 deletions(-)

diff --git a/arch/ia64/kernel/irq_ia64.c b/arch/ia64/kernel/irq_ia64.c
index 5c3e088..1034884 100644
--- a/arch/ia64/kernel/irq_ia64.c
+++ b/arch/ia64/kernel/irq_ia64.c
@@ -23,7 +23,6 @@
 #include <linux/ioport.h>
 #include <linux/kernel_stat.h>
 #include <linux/ptrace.h>
-#include <linux/random.h>	/* for rand_initialize_irq() */
 #include <linux/signal.h>
 #include <linux/smp.h>
 #include <linux/threads.h>
diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
index e799050..78fca29 100644
--- a/drivers/mfd/ab3100-core.c
+++ b/drivers/mfd/ab3100-core.c
@@ -934,8 +934,6 @@ static int __devinit ab3100_probe(struct i2c_client *client,
 					IRQF_ONESHOT, "ab3100-core", ab3100);
 	if (err)
 		goto exit_no_irq;
-	/* This real unpredictable IRQ is of course sampled for entropy */
-	rand_initialize_irq(client->irq);
 
 	err = abx500_register_ops(&client->dev, &ab3100_ops);
 	if (err)
diff --git a/include/linux/random.h b/include/linux/random.h
index 29e217a..ac621ce 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -48,8 +48,6 @@ struct rnd_state {
 
 #ifdef __KERNEL__
 
-extern void rand_initialize_irq(int irq);
-
 extern void add_device_randomness(const void *, unsigned int);
 extern void add_input_randomness(unsigned int type, unsigned int code,
 				 unsigned int value);
-- 
1.7.9.5
