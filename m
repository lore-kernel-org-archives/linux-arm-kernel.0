From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Feb 2013 12:30:55 +0000
Subject: [GIT PULL] ARM: OMAP: Audio support via omap-twl4030 and pwm
 support
In-Reply-To: <20130204195251.GS22517@atomide.com>
References: <50FE64DC.2030808@ti.com> <510788B9.9050907@ti.com>
 <20130130220532.GA22517@atomide.com> <20130204195251.GS22517@atomide.com>
Message-ID: <20130205123055.GA17852@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 11:52:51AM -0800, Tony Lindgren wrote:
> @@ -245,7 +245,7 @@ static int sdp3430_twl_gpio_setup(struct device *dev,
>  	return 0;
>  }
>  
> -static struct twl4030_gpio_platform_data sdp3430_gpio_data = {
> +static struct twl4030_gpio_platform_data __initdata sdp3430_gpio_data = {
>  	.pulldowns	= BIT(2) | BIT(6) | BIT(8) | BIT(13)
>  				| BIT(16) | BIT(17),
>  	.setup		= sdp3430_twl_gpio_setup,

Seeing platform data marked with __initdata makes me extremely nervous.
Are you _absolutely_ _sure_ that this data either:

(a) gets copied before use, or
(b) is not used after kernel init

?

Normally, platform data is passed via a pointer in struct device to
drivers, and drivers either store a pointer to it, or if the driver is
unbound/rebound, they can access it well after init time.

Certainly marking a function pointed to by platform data as __init looks
very very wrong.
