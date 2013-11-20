From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 21 Nov 2013 02:48:04 +0400
Subject: [PATCH 2/2] pcmcia: sa1111: pass sa1111_dev to jornada720-specific
 code
In-Reply-To: <1384987684-10692-1-git-send-email-dbaryshkov@gmail.com>
References: <1384987684-10692-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1384987684-10692-3-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass sa1111_dev to platform-specific init code, as it is done by lubbock
and neponset. This removes a compilation warnings:

drivers/pcmcia/sa1111_jornada720.c: In function 'pcmcia_jornada720_init':
drivers/pcmcia/sa1111_jornada720.c:105:3: warning: passing argument 1 of 'sa1111_set_io_dir' from incompatible pointer type [enabled by default]
In file included from drivers/pcmcia/sa1111_jornada720.c:15:0:
arch/arm/include/asm/hardware/sa1111.h:463:6: note: expected 'struct sa1111_dev *' but argument is of type 'struct device *'
drivers/pcmcia/sa1111_jornada720.c:106:3: warning: passing argument 1 of 'sa1111_set_io' from incompatible pointer type [enabled by default]
In file included from drivers/pcmcia/sa1111_jornada720.c:15:0:
arch/arm/include/asm/hardware/sa1111.h:464:6: note: expected 'struct sa1111_dev *' but argument is of type 'struct device *'
drivers/pcmcia/sa1111_jornada720.c:107:3: warning: passing argument 1 of 'sa1111_set_sleep_io' from incompatible pointer type [enabled by default]
In file included from drivers/pcmcia/sa1111_jornada720.c:15:0:
arch/arm/include/asm/hardware/sa1111.h:465:6: note: expected 'struct sa1111_dev *' but argument is of type 'struct device *'
drivers/pcmcia/sa1111_jornada720.c:111:5: warning: passing argument 1 of 'sa1111_pcmcia_add' from incompatible pointer type [enabled by default]
In file included from drivers/pcmcia/sa1111_jornada720.c:18:0:
drivers/pcmcia/sa1111_generic.h:15:5: note: expected 'struct sa1111_dev *' but argument is of type 'struct device *'

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/pcmcia/sa1111_generic.c    | 2 +-
 drivers/pcmcia/sa1111_generic.h    | 2 +-
 drivers/pcmcia/sa1111_jornada720.c | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pcmcia/sa1111_generic.c b/drivers/pcmcia/sa1111_generic.c
index a353186..53299f8 100644
--- a/drivers/pcmcia/sa1111_generic.c
+++ b/drivers/pcmcia/sa1111_generic.c
@@ -200,7 +200,7 @@ static int pcmcia_probe(struct sa1111_dev *dev)
 	pcmcia_badge4_init(dev);
 #endif
 #ifdef CONFIG_SA1100_JORNADA720
-	pcmcia_jornada720_init(&dev->dev);
+	pcmcia_jornada720_init(dev);
 #endif
 #ifdef CONFIG_ARCH_LUBBOCK
 	pcmcia_lubbock_init(dev);
diff --git a/drivers/pcmcia/sa1111_generic.h b/drivers/pcmcia/sa1111_generic.h
index 86b9cc8..e74ecfd 100644
--- a/drivers/pcmcia/sa1111_generic.h
+++ b/drivers/pcmcia/sa1111_generic.h
@@ -19,7 +19,7 @@ extern void sa1111_pcmcia_socket_state(struct soc_pcmcia_socket *, struct pcmcia
 extern int sa1111_pcmcia_configure_socket(struct soc_pcmcia_socket *, const socket_state_t *);
 
 extern int pcmcia_badge4_init(struct sa1111_dev *);
-extern int pcmcia_jornada720_init(struct device *);
+extern int pcmcia_jornada720_init(struct sa1111_dev *);
 extern int pcmcia_lubbock_init(struct sa1111_dev *);
 extern int pcmcia_neponset_init(struct sa1111_dev *);
 
diff --git a/drivers/pcmcia/sa1111_jornada720.c b/drivers/pcmcia/sa1111_jornada720.c
index 3baa3ef..ac60cd7 100644
--- a/drivers/pcmcia/sa1111_jornada720.c
+++ b/drivers/pcmcia/sa1111_jornada720.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/io.h>
 
 #include <mach/hardware.h>
 #include <asm/hardware/sa1111.h>
@@ -91,7 +92,7 @@ static struct pcmcia_low_level jornada720_pcmcia_ops = {
 	.nr			= 2,
 };
 
-int pcmcia_jornada720_init(struct device *dev)
+int pcmcia_jornada720_init(struct sa1111_dev *dev)
 {
 	int ret = -ENODEV;
 
-- 
1.8.4.2
