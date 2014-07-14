From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Jul 2014 15:19:04 +0100
Subject: [PATCH v4 5/7] watchdog: moxart: Register restart handler with
 restart notifier
In-Reply-To: <1405265431-4561-6-git-send-email-linux@roeck-us.net>
References: <1405265431-4561-1-git-send-email-linux@roeck-us.net>
 <1405265431-4561-6-git-send-email-linux@roeck-us.net>
Message-ID: <20140714141904.GA1112@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 13, 2014 at 04:30:29PM +0100, Guenter Roeck wrote:
> diff --git a/drivers/watchdog/moxart_wdt.c b/drivers/watchdog/moxart_wdt.c
> index 4aa3a8a..5080b50 100644
> --- a/drivers/watchdog/moxart_wdt.c
> +++ b/drivers/watchdog/moxart_wdt.c
[...]
> -static void moxart_wdt_restart(enum reboot_mode reboot_mode, const char *cmd)
> +static int moxart_restart_notify(struct notifier_block *this,
> +				 unsigned long mode, void *cmd)
>  {
> -	writel(1, moxart_restart_ctx->base + REG_COUNT);
> -	writel(0x5ab9, moxart_restart_ctx->base + REG_MODE);
> -	writel(0x03, moxart_restart_ctx->base + REG_ENABLE);
> +	struct moxart_wdt_dev *moxart_wdt = container_of(this,
> +							 struct moxart_wdt_dev,
> +							 restart_notifier);
> +	writel(1, moxart_wdt->base + REG_COUNT);
> +	writel(0x5ab9, moxart_wdt->base + REG_MODE);
> +	writel(0x03, moxart_wdt->base + REG_ENABLE);
> +
> +	return NOTIFY_DONE;
>  }

Wondering whether NOTIFY_OK or even NOTIFY_STOP_MASK is better here.

-- 
Catalin
