From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 2 Mar 2016 03:14:50 +0100
Subject: [PATCH v5 2/4] mmc: meson: Add driver for the SD/MMC host found
 on Amlogic Meson SoCs
In-Reply-To: <1456596108-1406-3-git-send-email-carlo@caione.org>
References: <1456596108-1406-1-git-send-email-carlo@caione.org>
 <1456596108-1406-3-git-send-email-carlo@caione.org>
Message-ID: <56D64C9A.3030004@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Carlo,

Am 27.02.2016 um 19:01 schrieb Carlo Caione:
> Add a driver for the SD/MMC host found on the Amlogic Meson SoCs. This
> is an MMC controller which provides an interface between the application
> processor and various memory cards. It supports the SD specification
> v2.0 and the eMMC specification v4.41.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>

Enabling this driver on top of my v2 arm64 gxbb series, I get:

  CC      drivers/mmc/host/meson-mmc.o
drivers/mmc/host/meson-mmc.c: In function 'meson_mmc_probe':
drivers/mmc/host/meson-mmc.c:471:12: error: implicit declaration of
function 'devm_pinctrl_get' [-Werror=implicit-function-declaration]
  pinctrl = devm_pinctrl_get(&pdev->dev);
            ^
drivers/mmc/host/meson-mmc.c:471:10: warning: assignment makes pointer
from integer without a cast [-Wint-conversion]
  pinctrl = devm_pinctrl_get(&pdev->dev);
          ^
cc1: some warnings being treated as errors
scripts/Makefile.build:258: recipe for target
'drivers/mmc/host/meson-mmc.o' failed
make[3]: *** [drivers/mmc/host/meson-mmc.o] Error 1
scripts/Makefile.build:407: recipe for target 'drivers/mmc/host' failed
make[2]: *** [drivers/mmc/host] Error 2
scripts/Makefile.build:407: recipe for target 'drivers/mmc' failed
make[1]: *** [drivers/mmc] Error 2
Makefile:959: recipe for target 'drivers' failed
make: *** [drivers] Error 2

Either this is missing a Kconfig dependency on PINCTRL, or should be
using #ifdef CONFIG_PINCTRL or some other guard.

For gxbb we could just ignore this in the hopes that Nicolas will have a
working pinctrl driver soon, but it might reappear for COMPILE_TEST.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
