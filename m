From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 02 Mar 2015 11:21:28 +0100
Subject: [PATCH] platform/chrome: add missing include in cros_ec_lpc driver
In-Reply-To: <6172990.aK27bmg5kF@wuerfel>
References: <6172990.aK27bmg5kF@wuerfel>
Message-ID: <54F439A8.2010606@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On 03/02/2015 11:01 AM, Arnd Bergmann wrote:
> The newly added cros_ec_lpc driver is meant for x86 but can
> also be built on other architectures. However, the original
> version causes a compile error when built on ARM because
> of a missing #include:
> 
> drivers/platform/chrome/cros_ec_lpc.c: In function 'ec_response_timed_out':
> drivers/platform/chrome/cros_ec_lpc.c:40:3: error: implicit declaration of function 'inb' [-Werror=implicit-function-declaration]
>    if (!(inb(EC_LPC_ADDR_HOST_CMD) & EC_LPC_STATUS_BUSY_MASK))
>    ^
> 
> This includes linux/io.h to make it compile reliably.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: ec2f33ab582bf ("platform/chrome: Add cros_ec_lpc driver for x86 devices")
> Cc: Bill Richardson <wfrichar@chromium.org>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Olof Johansson <olof@lixom.net>
> 
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index 822fdb36ded9..f00bf4d246a1 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -23,6 +23,7 @@
>  
>  #include <linux/dmi.h>
>  #include <linux/delay.h>
> +#include <linux/io.h>
>  #include <linux/mfd/cros_ec.h>
>  #include <linux/mfd/cros_ec_commands.h>
>  #include <linux/module.h>
> 

I posted the exact same patch [0] on Friday along with other two fixes [1].

Besides this build error fix, in the series there is another patch to make
the driver depends on X86 || COMPILE_TEST which I believe is the best trade
off to avoid building it unnecesarily on ARM but still get build coverage.

Best regards,
Javier

[0]: https://lkml.org/lkml/2015/2/27/9
[1]: https://lkml.org/lkml/2015/2/27/10
