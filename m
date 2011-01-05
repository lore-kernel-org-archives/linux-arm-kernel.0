From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed,  5 Jan 2011 05:05:08 +0300
Subject: [PATCH 4/6] pcmcia: limit pxa2xx_balloon3 subdriver to balloon3
	platform
In-Reply-To: <1294193110-23958-1-git-send-email-dbaryshkov@gmail.com>
References: <1294193110-23958-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1294193110-23958-4-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pxa2xx_balloon3 tries to register pxa2xx-pcmcia device not checking whether
machine is really balloon3, thus messing multi-machine kernels. Fix it up.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/pcmcia/pxa2xx_balloon3.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_balloon3.c b/drivers/pcmcia/pxa2xx_balloon3.c
index dbbdd00..0b1caca 100644
--- a/drivers/pcmcia/pxa2xx_balloon3.c
+++ b/drivers/pcmcia/pxa2xx_balloon3.c
@@ -25,6 +25,8 @@
 
 #include <mach/balloon3.h>
 
+#include <asm/mach-types.h>
+
 #include "soc_common.h"
 
 /*
@@ -128,6 +130,9 @@ static int __init balloon3_pcmcia_init(void)
 {
 	int ret;
 
+	if (!machine_is_balloon3())
+		return -ENODEV;
+
 	balloon3_pcmcia_device = platform_device_alloc("pxa2xx-pcmcia", -1);
 	if (!balloon3_pcmcia_device)
 		return -ENOMEM;
-- 
1.7.2.3
