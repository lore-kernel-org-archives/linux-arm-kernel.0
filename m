From: rafael@kernel.org (Rafael J. Wysocki)
Date: Wed, 27 Jan 2016 00:14:54 +0100
Subject: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
In-Reply-To: <20160126224804.GB19432@atomide.com>
References: <20160126224804.GB19432@atomide.com>
Message-ID: <CAJZ5v0i79X5JjOZiu4cOZ0Esd5BxAvutF8d17asDzq9ECcML-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 11:48 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> Looks like commit 5de85b9d57ab ("PM / runtime: Re-init runtime
> PM states at probe error and driver unbind") broke PM on at least
> omap3. It seems we now need to additionally also call
> pm_runtime_dont_use_autosuspend() to get things working again?
>
> The following fixes idling on omap3, but I'm wondering if we
> should do something in pm_runtime_reinit() instead?

Well, does it actually help if you add
pm_runtime_dont_use_autosuspend(dev) to pm_runtime_reinit()?

> 8< ---------------------
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2232,6 +2232,7 @@ err_irq:
>                 dma_release_channel(host->tx_chan);
>         if (host->rx_chan)
>                 dma_release_channel(host->rx_chan);
> +       pm_runtime_dont_use_autosuspend(host->dev);
>         pm_runtime_put_sync(host->dev);
>         pm_runtime_disable(host->dev);
>         if (host->dbclk)
> --


Thanks,
Rafael
