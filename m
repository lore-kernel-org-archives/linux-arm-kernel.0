From: linux@dominikbrodowski.net (Dominik Brodowski)
Date: Wed, 10 Nov 2010 14:37:46 +0100
Subject: [PATCH 5/5] drivers/pcmcia/soc_common.c: Use printf extension %pV
In-Reply-To: <20101110133657.GA22986@comet.dominikbrodowski.net>
References: <20101110133657.GA22986@comet.dominikbrodowski.net>
Message-ID: <1289396266-23098-5-git-send-email-linux@dominikbrodowski.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joe Perches <joe@perches.com>

Using %pV reduces the number of printk calls and
eliminates any possible message interleaving from
other printk calls.

Signed-off-by: Joe Perches <joe@perches.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: Eric Miao <eric.y.miao@gmail.com>
CC: linux-arm-kernel at lists.infradead.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/pcmcia/soc_common.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index 689e3c0..3753fd0 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -57,11 +57,16 @@ module_param(pc_debug, int, 0644);
 void soc_pcmcia_debug(struct soc_pcmcia_socket *skt, const char *func,
 		      int lvl, const char *fmt, ...)
 {
+	struct va_format vaf;
 	va_list args;
 	if (pc_debug > lvl) {
-		printk(KERN_DEBUG "skt%u: %s: ", skt->nr, func);
 		va_start(args, fmt);
-		vprintk(fmt, args);
+
+		vaf.fmt = fmt;
+		vaf.va = &args;
+
+		printk(KERN_DEBUG "skt%u: %s: %pV", skt->nr, func, &vaf);
+
 		va_end(args);
 	}
 }
-- 
1.7.1
