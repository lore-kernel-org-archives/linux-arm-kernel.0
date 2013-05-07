From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 07 May 2013 13:59:53 -0700
Subject: [PATCH] clk: Always notify whole subtree when reparenting
In-Reply-To: <afe397e3-c674-4dc3-9f3e-feea9275bb91@TX2EHSMHS023.ehs.local>
References: <afe397e3-c674-4dc3-9f3e-feea9275bb91@TX2EHSMHS023.ehs.local>
Message-ID: <20130507205953.4542.62609@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Soren Brinkmann (2013-04-16 10:06:50)
> A clock's notifier count only reflects notifiers which are registered
> directly for that clock. A reparent operation though affects the whole
> subtree because of a potential rate change.
> When issuing the pre rate change notifications only the notifier count
> for the clock to be changed is considered and notifiers for subclocks
> may never be called. Resulting in clocks in the subtree which have
> registered notifiers, may receive a POST_- or ABORT_RATE_CHANGE
> notification, without a PRE_RATE_CHANGE_NOTIFICATION.
> Therefore always traverse the whole subtree when issueing pre rate
> change notifications during a reparent operation.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> This should probably be considered an RFC. There may be smarter ways to
> resolve this issue. E.g. forward notifier counts upstream the way it is done
> with enable counts.
> 

I've taken this patch for 3.11.

Thanks,
Mike

>         S?ren
> 
> 
>  drivers/clk/clk.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 20ce67f..1179cb5 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1481,8 +1481,7 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
>         }
>  
>         /* propagate PRE_RATE_CHANGE notifications */
> -       if (clk->notifier_count)
> -               ret = __clk_speculate_rates(clk, p_rate);
> +       ret = __clk_speculate_rates(clk, p_rate);
>  
>         /* abort if a driver objects */
>         if (ret & NOTIFY_STOP_MASK)
> -- 
> 1.8.2.1
