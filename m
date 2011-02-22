From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 23 Feb 2011 02:30:28 +0300
Subject: [PATCH] colibri : don't register pxa2xx-pcmcia nodes on non-colibri
	platforms
Message-ID: <1298417428-25064-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PXA supports multi-machine kernels since long ago. However a kernel
compiled with support for colibri and any other PXA machine and with
PCMCIA enabled will barf at runtime about duplicate registration of
pxa2xx-pcmcia device. Fix that.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/pcmcia/pxa2xx_colibri.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_colibri.c b/drivers/pcmcia/pxa2xx_colibri.c
index c3f7219..a520395 100644
--- a/drivers/pcmcia/pxa2xx_colibri.c
+++ b/drivers/pcmcia/pxa2xx_colibri.c
@@ -181,6 +181,9 @@ static int __init colibri_pcmcia_init(void)
 {
 	int ret;
 
+	if (!machine_is_colibri() && !machine_is_colibri320())
+		return -ENODEV;
+
 	colibri_pcmcia_device = platform_device_alloc("pxa2xx-pcmcia", -1);
 	if (!colibri_pcmcia_device)
 		return -ENOMEM;
-- 
1.7.2.3
