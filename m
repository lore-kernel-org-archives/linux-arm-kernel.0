From: adrian.hunter@intel.com (Adrian Hunter)
Date: Fri, 22 Apr 2016 15:48:05 +0300
Subject: [PATCH 10/23] mmc: core: disable auto retune during card
 detection process
In-Reply-To: <1460741387-23815-11-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-11-git-send-email-aisheng.dong@nxp.com>
Message-ID: <571A1D85.3020200@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/04/16 20:29, Dong Aisheng wrote:
> During card detection process, mmc core may sends commands
> to detect if card is still exist in mmc_rescan for removable
> card which may trigger mmc retuning process after a bit time
> of runtime pm suspend.
> Obviously this retuning process is meaningless for card remove
> case, so we disable mmc_retune in mmc_detect_change() for it.
> For card insert case, the mmc_retune will be enabled normally
> in its card initialization process later in mmc_execute_tuning().
> So disable it at first has no side effection.

We don't assume that the card has been removed, which is why we send
commands to find out if it is still there.  If it is still there, this
change will have incorrectly disabled re-tuning.

Do you have an actual problem with the way it works now?

> 
> CC: stable <stable@vger.kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/mmc/core/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 52bfaf0..76d0802 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1888,6 +1888,7 @@ static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
>  		pm_wakeup_event(mmc_dev(host), 5000);
>  
>  	host->detect_change = 1;
> +	mmc_retune_disable(host);
>  	mmc_schedule_delayed_work(&host->detect, delay);
>  }
>  
> 
