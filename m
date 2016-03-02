From: carlo@caione.org (Carlo Caione)
Date: Wed, 2 Mar 2016 09:11:06 +0100
Subject: [PATCH v5 2/4] mmc: meson: Add driver for the SD/MMC host found
 on Amlogic Meson SoCs
In-Reply-To: <56D64C9A.3030004@suse.de>
References: <1456596108-1406-1-git-send-email-carlo@caione.org>
 <1456596108-1406-3-git-send-email-carlo@caione.org>
 <56D64C9A.3030004@suse.de>
Message-ID: <CAOQ7t2b0NBuBh913xGenUsdqu2KTfZ-cbkvEfbrhk0vdsQMBaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 2, 2016 at 3:14 AM, Andreas F?rber <afaerber@suse.de> wrote:
> Hi Carlo,
>
> Am 27.02.2016 um 19:01 schrieb Carlo Caione:
>> Add a driver for the SD/MMC host found on the Amlogic Meson SoCs. This
>> is an MMC controller which provides an interface between the application
>> processor and various memory cards. It supports the SD specification
>> v2.0 and the eMMC specification v4.41.
>>
>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>
> Enabling this driver on top of my v2 arm64 gxbb series, I get:
>
>   CC      drivers/mmc/host/meson-mmc.o
> drivers/mmc/host/meson-mmc.c: In function 'meson_mmc_probe':
> drivers/mmc/host/meson-mmc.c:471:12: error: implicit declaration of
> function 'devm_pinctrl_get' [-Werror=implicit-function-declaration]
>   pinctrl = devm_pinctrl_get(&pdev->dev);
>             ^
> drivers/mmc/host/meson-mmc.c:471:10: warning: assignment makes pointer
> from integer without a cast [-Wint-conversion]
>   pinctrl = devm_pinctrl_get(&pdev->dev);
>           ^
> cc1: some warnings being treated as errors
> scripts/Makefile.build:258: recipe for target
> 'drivers/mmc/host/meson-mmc.o' failed
> make[3]: *** [drivers/mmc/host/meson-mmc.o] Error 1
> scripts/Makefile.build:407: recipe for target 'drivers/mmc/host' failed
> make[2]: *** [drivers/mmc/host] Error 2
> scripts/Makefile.build:407: recipe for target 'drivers/mmc' failed
> make[1]: *** [drivers/mmc] Error 2
> Makefile:959: recipe for target 'drivers' failed
> make: *** [drivers] Error 2
>
> Either this is missing a Kconfig dependency on PINCTRL, or should be
> using #ifdef CONFIG_PINCTRL or some other guard.

I think that we can actually drop the whole devm_pinctrl_get().
I'll wait for some comments from Ulf before submitting a fix.

> For gxbb we could just ignore this in the hopes that Nicolas will have a
> working pinctrl driver soon, but it might reappear for COMPILE_TEST.

AFAIR from a discussion with Amlogic it seems that they totally
changed the SD controller in the S905 so probably we will need a new
driver for the gxbb. At this point I also wonder if it's not worthy it
already to change the compatible for this driver to something more
specific for Meson8 / Meson8b.
Probably we will have some more news when the documentation will be available.

Thank you for testing this,

-- 
Carlo Caione
