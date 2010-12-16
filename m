From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 16 Dec 2010 08:49:32 -0800
Subject: [PATCH v1] OMAP: GPIO: Correct IP version message during boot
In-Reply-To: <1292508586-21651-1-git-send-email-charu@ti.com> (Charulatha
	Varadarajan's message of "Thu, 16 Dec 2010 19:39:46 +0530")
References: <1292508586-21651-1-git-send-email-charu@ti.com>
Message-ID: <8739pxhdcz.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Varadarajan, Charulatha" <charu@ti.com> writes:

> With the commit 9a748053f5f58a77cd71864f1d7b804175b0e47d whose subject is
> "OMAP: GPIO: Make omap_gpio_show_rev bank specific" (see [1]),
> the IP version information for all the banks are shown during bootup,
> but it does not show the bank number.
>
> Use dev_info instead of printk in omap_gpio_show_rev() so that the
> bank id is displayed along with the IP version
>
> [1] http://www.spinics.net/lists/arm-kernel/msg105872.html

A related question, the commit above also changed the GPIO revision
display from one-time to once per bank.  Do we need to know the GPIO HW
revision for each bank, or can we assume it's the same for all banks?

Kevin

> Signed-off-by: Varadarajan, Charulatha <charu@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/plat-omap/gpio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 8d493b9..47aeaeb 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -1554,7 +1554,7 @@ static void __init omap_gpio_show_rev(struct gpio_bank *bank)
>  	else
>  		return;
>  
> -	printk(KERN_INFO "OMAP GPIO hardware version %d.%d\n",
> +	dev_info(bank->dev, "hardware version %d.%d\n",
>  		(rev >> 4) & 0x0f, rev & 0x0f);
>  }
