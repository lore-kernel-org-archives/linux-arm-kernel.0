From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 17 Dec 2015 09:39:32 +0100
Subject: [PATCH v3] net/macb: add support for resetting PHY using GPIO
In-Reply-To: <6382531.CWmTLTEYMq@wuerfel> (Arnd Bergmann's message of "Wed, 16
 Dec 2015 20:10:14 +0100")
References: <1450290690-32369-1-git-send-email-gregory.clement@free-electrons.com>
 <6382531.CWmTLTEYMq@wuerfel>
Message-ID: <874mfhtqnv.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
 
 On mer., d?c. 16 2015, Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday 16 December 2015 19:31:30 Gregory CLEMENT wrote:
>> diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
>> index 88c1e1a..35661aa 100644
>> --- a/drivers/net/ethernet/cadence/macb.c
>> +++ b/drivers/net/ethernet/cadence/macb.c
>> @@ -28,6 +28,7 @@
>>  #include <linux/phy.h>
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>> +#include <linux/of_gpio.h>
>>  #include <linux/of_mdio.h>
>>  #include <linux/of_net.h>
>
> Is this the patch that is already in linux-next?

I've just checked and it is the v2 which is in linux-next. David applied
it on Monday in his next branche but I was not aware of it.

David,

if I remebered well you do not remove patch from yout branch.  So would
you agree to take a follow-up patch on top of 5833e0526820 "net/macb:
add support for resetting PHY using GPIO" ?

I will fix the error found by Arnd and also use a better device tree
binding (more future proof).

Thanks,

Gregory

>
> I needed an additional
>
> #include <linux/gpio/consumer.h>
>
> to avoid this build error on randconfig builds without GPIOLIB:
>
>     drivers/net/ethernet/cadence/macb.c: In function 'macb_probe':
>     drivers/net/ethernet/cadence/macb.c:2908:19: error: implicit declaration of function 'devm_gpiod_get_optional' [-Werror=implicit-function-declaration]
>       bp->reset_gpio = devm_gpiod_get_optional(&bp->pdev->dev, "phy-reset",
>                        ^
>     drivers/net/ethernet/cadence/macb.c:2909:8: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function)
>             GPIOD_OUT_HIGH);
>             ^
>     drivers/net/ethernet/cadence/macb.c:2909:8: note: each undeclared identifier is reported only once for each function it appears in
>     drivers/net/ethernet/cadence/macb.c: In function 'macb_remove':
>     drivers/net/ethernet/cadence/macb.c:2979:3: error: implicit declaration of function 'gpiod_set_value' [-Werror=implicit-function-declaration]
>
>
> 	Arnd

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
