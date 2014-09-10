From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 10 Sep 2014 14:43:17 -0700
Subject: [PATCH v2] clk: Don't hold prepare_lock across debugfs creation
In-Reply-To: <20140906000000.GB22593@codeaurora.org>
References: <CAF6AEGtk=KhW+m-jc6VzH=pHGgnE1Uzq0tYiqqnX0sPHV1rbPQ@mail.gmail.com>
 <1409899069-13313-1-git-send-email-sboyd@codeaurora.org>
 <20140906000000.GB22593@codeaurora.org>
Message-ID: <20140910214317.19023.44430@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2014-09-05 17:00:00)
> On 09/04, Stephen Boyd wrote:
> > 
> > I don't understand why we need to hold the prepare lock around
> > the kref_put(), so I changed the flow so that we don't do this
> > when we unregister a clock.
> 
> Ok we hold the prepare mutex to make sure get and put are serialized.
> Good. Here's the interdiff to move the debugfs unregistration before
> the prepare lock and detect double unregisters without holding
> the prepare lock.

Looks good to me. I've rolled this into the original above and applied
it to clk-next.

Regards,
Mike

> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 3c04d0d69b96..8ca28189e4e9 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -338,10 +338,14 @@ unlock:
>  static void clk_debug_unregister(struct clk *clk)
>  {
>         mutex_lock(&clk_debug_lock);
> -       hlist_del_init(&clk->debug_node);
> -       mutex_unlock(&clk_debug_lock);
> +       if (!clk->dentry)
> +               goto out;
>  
> +       hlist_del_init(&clk->debug_node);
>         debugfs_remove_recursive(clk->dentry);
> +       clk->dentry = NULL;
> +out:
> +       mutex_unlock(&clk_debug_lock);
>  }
>  
>  struct dentry *clk_debugfs_add_file(struct clk *clk, char *name, umode_t mode,
> @@ -2065,14 +2069,15 @@ void clk_unregister(struct clk *clk)
>  {
>         unsigned long flags;
>  
> -       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> -               return;
> +       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
> +               return;
> +
> +       clk_debug_unregister(clk);
>  
>         clk_prepare_lock();
>  
>         if (clk->ops == &clk_nodrv_ops) {
>                 pr_err("%s: unregistered clock: %s\n", __func__, clk->name);
> -               clk_prepare_unlock();
>                 return;
>         }
>         /*
> @@ -2097,11 +2102,9 @@ void clk_unregister(struct clk *clk)
>         if (clk->prepare_count)
>                 pr_warn("%s: unregistering prepared clock: %s\n",
>                                         __func__, clk->name);
> -       clk_prepare_unlock();
> -
> -       clk_debug_unregister(clk);
> -
>         kref_put(&clk->ref, __clk_release);
> +
> +       clk_prepare_unlock();
>  }
>  EXPORT_SYMBOL_GPL(clk_unregister);
>  
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
