From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 01 Dec 2010 00:22:58 +0000
Subject: [PATCH v5] ARM: s3c244x: Fix mess with gpio {set,
	get}_pull callbacks
In-Reply-To: <1291147949-18812-1-git-send-email-anarsoul@gmail.com>
References: <4CF55785.5090403@metafoo.de>
	<1291147949-18812-1-git-send-email-anarsoul@gmail.com>
Message-ID: <4CF59562.7000501@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/11/10 20:12, Vasily Khoruzhick wrote:
> Currently the {set,get}_pull callbacks of the s3c24xx_gpiocfg_default structure
> are initalized via s3c_gpio_{get,set}pull_1up. This results in a linker
> error when only CONFIG_CPU_S3C2442 is selected:
> 
> arch/arm/plat-s3c24xx/built-in.o:(.data+0x13f4): undefined reference to
> `s3c_gpio_getpull_1up'
> arch/arm/plat-s3c24xx/built-in.o:(.data+0x13f8): undefined reference to
> `s3c_gpio_setpull_1up'
> 
> The s3c2442 has pulldowns instead of pullups compared to the s3c2440.
> The method of controlling them is the same though.
> So this patch modifies the existing s3c_gpio_{get,set}pull_1up helper functions
> to take an additional parameter deciding whether the pin has a pullup or pulldown.
> The s3c_gpio_{get,set}pull_1{down,up} functions then wrap that functions passing
> either S3C_GPIO_PULL_UP or S3C_GPIO_PULL_DOWN.
> 
> Furthermore this patch sets up the s3c24xx_gpiocfg_default.{get,set}_pull fields
> in the s3c244{0,2}_map_io function to the new pulldown helper functions.
> 
> Based on patch from "Lars-Peter Clausen" <lars@metafoo.de>

Ok, I think this is the best solution. I'll apply it tomorrow
if there's nothing else I can think of.
