From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 13 Aug 2010 17:14:44 +0400
Subject: undefined reference to `mmc_pm_notify' when selected MMC without
	PM.
In-Reply-To: <009301cb3ad3$77c8a620$6759f260$%kim@samsung.com>
References: <009301cb3ad3$77c8a620$6759f260$%kim@samsung.com>
Message-ID: <4C654544.5010002@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Kukjin Kim wrote:

> Following is build error when selected MMC without PM.

> drivers/built-in.o: In function `mmc_alloc_host':
> drivers/mmc/core/host.c:108: undefined reference to `mmc_pm_notify'
> make[1]: *** [.tmp_vmlinux1] Error 1
> make: *** [sub-make] Error 2

> That is added from Maxim's ' mmc: fix all hangs related to mmc/sd card
> insert/removal during suspend/resume '
> (commit ID: 4c2ef25fe0b847d2ae818f74758ddb0be1c27d8e)

> Below is temporary patch for avoiding build error.
> But I'm not sure about this... :-(

> ---

> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 0efe631..d80cfdc 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -86,7 +86,9 @@ struct mmc_host *mmc_alloc_host(int extra, struct device
> *dev)
>         init_waitqueue_head(&host->wq);
>         INIT_DELAYED_WORK(&host->detect, mmc_rescan);
>         INIT_DELAYED_WORK_DEFERRABLE(&host->disable,
> mmc_host_deeper_disable);

    Looks like your patch is line-wrapped...

> +#ifdef CONFIG_PM
>         host->pm_notify.notifier_call = mmc_pm_notify;
> +#endif

WBR, Sergei
