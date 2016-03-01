From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Mar 2016 23:12:20 +0100
Subject: [PATCH] pcmcia: db1xxx: use correct irq_to_gpio helper
Message-ID: <1547427.xN2rd1Mon4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the removal of asm/gpio.h and asm/mach-au1x00/gpio.h, the db1xxx_ss
pcmcia driver picked up the wrong irq_to_gpio function from the generic
headers.

This restores the old __au_irq_to_gpio() implementation, but keeps
it local to the only file that uses it.

It would be nicer to just pass the gpio number from platform code,
but restoring the previous implementation seems safer.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: stable at vger.kernel.org # v4.3
Fixes: 832f5dacfa0b ("MIPS: Remove all the uses of custom gpio.h")
---
I think this is now the last holdout of the irq_to_gpio function,
and it's been broken for a while. Maybe Ralf can queue it up through
the MIPS tree along with the other fix for irq_to_gpio?

Linus, maybe you can queue up the include/linux/gpio.h change to
remove the function as well for 4.6. We have two users of this function
on MIPS that are already broken, and adding the patch turns the
runtime bug into a compile-time bug, which seems like a good thing
to me. The other patch is already queued in the mips tree.

diff --git a/drivers/pcmcia/db1xxx_ss.c b/drivers/pcmcia/db1xxx_ss.c
index 4c2fa05b4589..41f28879bfef 100644
--- a/drivers/pcmcia/db1xxx_ss.c
+++ b/drivers/pcmcia/db1xxx_ss.c
@@ -35,6 +35,19 @@
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/bcsr.h>
+#include <asm/mach-au1x00/gpio-au1000.h>
+#include <asm/mach-au1x00/gpio-au1300.h>
+
+static inline int __au_irq_to_gpio(unsigned int irq)
+{
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1000...ALCHEMY_CPU_AU1200:
+		return alchemy_irq_to_gpio(irq);
+	case ALCHEMY_CPU_AU1300:
+		return au1300_irq_to_gpio(irq);
+	}
+	return -EINVAL;
+}
 
 #define MEM_MAP_SIZE	0x400000
 #define IO_MAP_SIZE	0x1000
@@ -83,7 +96,7 @@ static int db1200_card_inserted(struct db1x_pcmcia_sock *sock)
 /* carddetect gpio: low-active */
 static int db1000_card_inserted(struct db1x_pcmcia_sock *sock)
 {
-	return !gpio_get_value(irq_to_gpio(sock->insert_irq));
+	return !gpio_get_value(__au_irq_to_gpio(sock->insert_irq));
 }
 
 static int db1x_card_inserted(struct db1x_pcmcia_sock *sock)
