From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Dec 2011 10:04:56 -0800
Subject: [PATCH 01/10] GPIO: gpio-generic: Move initialization up to
 postcore
In-Reply-To: <1323634328-856-2-git-send-email-jkrzyszt@tis.icnet.pl>
References: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <1323634328-856-2-git-send-email-jkrzyszt@tis.icnet.pl>
Message-ID: <20111212180456.GF31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111211 11:41]:
> This will allow boards with custom memory mapped GPIO ports to set up
> and use those port pins while initializing devices from arch init.

Care to explain a bit more why you need to initialize those devices
early on?

Usually moving things earlier and earlier is an endless loop 
adding more and more nasty dependencies..

I'd rather see things getting initialized later as regular
device drivers so we have decent kernel error messages when
something goes wrong without having to enable debug_ll.

Regards,

Tony


> Created against linux-3.2-rc5.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> ---
>  drivers/gpio/gpio-generic.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-generic.c b/drivers/gpio/gpio-generic.c
> index 4e24436..a6eaf38 100644
> --- a/drivers/gpio/gpio-generic.c
> +++ b/drivers/gpio/gpio-generic.c
> @@ -528,7 +528,7 @@ static int __init bgpio_platform_init(void)
>  {
>  	return platform_driver_register(&bgpio_driver);
>  }
> -module_init(bgpio_platform_init);
> +postcore_initcall(bgpio_platform_init);
>  
>  static void __exit bgpio_platform_exit(void)
>  {
> -- 
> 1.7.3.4
> 
