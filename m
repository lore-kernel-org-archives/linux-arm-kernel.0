From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  5 Oct 2012 16:55:25 +0200
Subject: [PATCH 11/16] pcmcia: sharpsl: don't discard sharpsl_pcmcia_ops
In-Reply-To: <1349448930-23976-1-git-send-email-arnd@arndb.de>
References: <1349448930-23976-1-git-send-email-arnd@arndb.de>
Message-ID: <1349448930-23976-12-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sharpsl_pcmcia_ops structure gets passed into
sa11xx_drv_pcmcia_probe, where it gets accessed at run-time,
unlike all other pcmcia drivers that pass their structures
into platform_device_add_data, which makes a copy.

This means the gcc warning is valid and the structure
must not be marked as __initdata.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Pavel Machek <pavel@suse.cz>
Cc: linux-pcmcia at lists.infradead.org
Cc: Jochen Friedrich <jochen@scram.de>
Cc: stable at vger.kernel.org
---
 drivers/pcmcia/pxa2xx_sharpsl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/pxa2xx_sharpsl.c b/drivers/pcmcia/pxa2xx_sharpsl.c
index b066273..7dd879c 100644
--- a/drivers/pcmcia/pxa2xx_sharpsl.c
+++ b/drivers/pcmcia/pxa2xx_sharpsl.c
@@ -194,7 +194,7 @@ static void sharpsl_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
 	sharpsl_pcmcia_init_reset(skt);
 }
 
-static struct pcmcia_low_level sharpsl_pcmcia_ops __initdata = {
+static struct pcmcia_low_level sharpsl_pcmcia_ops = {
 	.owner                  = THIS_MODULE,
 	.hw_init                = sharpsl_pcmcia_hw_init,
 	.socket_state           = sharpsl_pcmcia_socket_state,
-- 
1.7.10
