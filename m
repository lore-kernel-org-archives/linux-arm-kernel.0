From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 16 Apr 2013 12:58:26 -0700
Subject: [PATCH] clk: Always notify whole subtree when reparenting
In-Reply-To: <afe397e3-c674-4dc3-9f3e-feea9275bb91@TX2EHSMHS023.ehs.local>
References: <afe397e3-c674-4dc3-9f3e-feea9275bb91@TX2EHSMHS023.ehs.local>
Message-ID: <20130416195826.19887.78037@quantum>
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

Hi Soren,

Thanks for the fix.  Some of the core code has changed enough lately
that it is worth going through and consolidating/cleaning up.  For
instance another nice optimization that is related might be something
like:


diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 20ce67f..15e8b41 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1028,6 +1028,9 @@ static int __clk_speculate_rates(struct clk *clk, unsigned long parent_rate)
 	else
 		new_rate = parent_rate;
 
+	if (new_rate == clk->rate)
+		return ret;
+
 	/* abort rate change if a driver returns NOTIFY_BAD or NOTIFY_STOP */
 	if (clk->notifier_count)
 		ret = __clk_notify(clk, PRE_RATE_CHANGE, clk->rate, new_rate);


However it remains to be seen whether any drivers rely on
PRE_RATE_CHANGE notifiers even if the clock rate stays the same.

I don't think I'll take your patch for 3.10 since no one has reported a
bug with it yet, but I'll roll it into a larger cleanup series after the
merge window.

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
