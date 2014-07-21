From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jul 2014 14:06:10 +0200
Subject: [PATCH 12/12] ARM: tegra: Convert PMC to a driver
In-Reply-To: <20140717110652.GA18383@ulmo>
References: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
 <111661024.qGiugVUugr@wuerfel> <20140717110652.GA18383@ulmo>
Message-ID: <6373493.kzO00ziuYq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 July 2014 13:06:53 Thierry Reding wrote:
> 
> We could go all the way and make it include/soc/tegra/*.h for better
> namespacing. I guess either way would be fine, really, since the number
> of files in those directories should be small by definition, so we
> should be able to do without the extra SoC directory, too. I have a
> slight preference for a separate SoC directory, do you have any
> objections?

I'm fine with it either way. I just noticed that you have now
moved the file, which resulted in a build error:

../drivers/ata/ahci_tegra.c:27:35: fatal error: linux/tegra-powergate.h: No such file or directory
 #include <linux/tegra-powergate.h>
                                   ^
compilation terminated.
make[4]: *** [drivers/ata/ahci_tegra.o] Error 1

so somebody needs to pick up this patch:

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index d30bb21afd67..d7c6b1f550cd 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -24,8 +24,8 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
-#include <linux/tegra-powergate.h>
 #include <linux/regulator/consumer.h>
+#include <soc/tegra/pmc.h>
 #include "ahci.h"
 
 #define SATA_CONFIGURATION_0				0x180


I haven't checked which trees are affected of if you have already posted
a patch to do this.

	Arnd
