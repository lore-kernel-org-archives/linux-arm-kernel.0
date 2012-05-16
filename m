From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 16 May 2012 09:03:44 +0100
Subject: [PATCH 7.2/15] ARM: ux500: Disable SMSC911x platform code
 registration when DT is enabled
In-Reply-To: <CACRpkdaLG+LwNpKX_52+scLrNbezvRXEuCfF5CAb4XFOSD4xag@mail.gmail.com>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdZzAQNJ9ejKJJQJhEPjO9VO+fPHmPeCErg8XOj-dLc3gA@mail.gmail.com>
 <4F967986.6090808@linaro.org> <201205031257.52100.arnd@arndb.de>
 <CACRpkdaLG+LwNpKX_52+scLrNbezvRXEuCfF5CAb4XFOSD4xag@mail.gmail.com>
Message-ID: <4FB35F60.1060709@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/12 18:14, Linus Walleij wrote:
> On Thu, May 3, 2012 at 2:57 PM, Arnd Bergmann<arnd@arndb.de>  wrote:
>
>> This version of the patch looks good, the version that was applied does not.
>> (...)
>> Linus and Lee, what's going on here?
>
> Probably just my screwups when applying Lee's patches out-of-order
> and splitting them.
>
> I saw lee sent a new pull request with his baseline, throw the devcietree
> branch from me out and use his branch instead.

I've just seen another problem with this.

In the pull request was:

> commit dc315c470b6b69018e6b65beb1e5b0d8f737261d
> Author: Lee Jones <lee.jones@linaro.org>
> Date:   Tue Apr 24 10:54:25 2012 +0100
>
>     ARM: ux500: Disable SMSC911x platform code registration when DT is enabled
>
>     Now the SCMC911x is correctly enabled in Device Tree, there is no need
>     to continue registering it from platform code. In fact, if we continue
>     doing so, the system will throw an error on boot.
>
>     SAcked-by: Linus Walleij <linus.walleij@linaro.org>
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>     igned-off-by: Lee Jones <lee.jones@linaro.org>
>
> diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
> index cdf0ecf..d554a8b 100644
> --- a/arch/arm/mach-ux500/board-mop500.c
> +++ b/arch/arm/mach-ux500/board-mop500.c
> @@ -612,7 +612,6 @@ static struct platform_device *snowball_platform_devs[] __initdata = {
>  static struct platform_device *snowball_of_platform_devs[] __initdata = {
>         &snowball_led_dev,
>         &snowball_key_dev,
> -       &snowball_sbnet_dev,
>         &ab8500_device,
>  };

But this made it into arm-soc:

> commit f58546a17c5dc2255c40e4bc4287e06a93b5c9a0
> Author: Lee Jones <lee.jones@linaro.org>
> Date:   Tue Apr 24 10:54:25 2012 +0100
>
>     ARM: ux500: Disable SMSC911x platform code registration when DT is enabled
>
>     Now the SCMC911x is correctly enabled in Device Tree, there is no need
>     to continue registering it from platform code. In fact, if we continue
>     doing so, the system will throw an error on boot.
>
>     Signed-off-by: Lee Jones <lee.jones@linaro.org>
>     Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
> index b885f27..f815015 100644
> --- a/arch/arm/mach-ux500/board-mop500.c
> +++ b/arch/arm/mach-ux500/board-mop500.c
> @@ -605,7 +605,6 @@ static void __init mop500_uart_init(struct device *parent)
>  static struct platform_device *snowball_platform_devs[] __initdata = {
>         &snowball_led_dev,
>         &snowball_key_dev,
> -       &snowball_sbnet_dev,
>         &ab8500_device,
>  };

Somehow the incorrect *_platform_devs[] was amended.

Some kind of git automatic conflict resolution error?

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515 Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
