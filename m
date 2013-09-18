From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 17 Sep 2013 21:16:43 -0700
Subject: question about clk notifier in common clock tree
In-Reply-To: <CAAXpJNvPvqr9+Zu1dUMssa0oorEH7Yc=so93i0UJjdNXKyh45A@mail.gmail.com>
References: <CAAXpJNvPvqr9+Zu1dUMssa0oorEH7Yc=so93i0UJjdNXKyh45A@mail.gmail.com>
Message-ID: <CAPtuhTgvOca7V0a4+fEEBX2ad-FzPQWyuu7zBBNkhaja7rgUGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 7:17 PM, zhoujie wu <zhoujiewu@gmail.com> wrote:
> Hi Mike,
>
> Now in our platform, we are using clk notifer to adjust voltage before
> clock rate change or after rate change.
>
> But for some clock modules, it even have to adjust voltage when clock
> enable and disable.
> For example, when it is working(clock enabled), it requires voltage
> 1.2V. When it finished its work, it could release it's voltage
> requirement.
> Do you think if it is ok we also send out notifier in __clk_prepare
> and __clk_unprepare as below?

This has come up in the past and my position has been that run-time PM
should enable regulators when turning on a module or device. One
question: what is the regulator consumer in your case? Is it the clock
consuming the regulator or is the device/module consuming the
regulator? Usually it is the device and not the actual clock that
needs the regulator to be enabled before it can be used and this is
best left up to runtime PM.

Regards,
Mike

>
> Thanks.
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 54a191c..2f64f1e 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -34,6 +34,9 @@ static HLIST_HEAD(clk_root_list);
>  static HLIST_HEAD(clk_orphan_list);
>  static LIST_HEAD(clk_notifier_list);
>
> +static int __clk_notify(struct clk *clk, unsigned long msg,
> + unsigned long old_rate, unsigned long new_rate);
> +
>  /***           locking             ***/
>  static void clk_prepare_lock(void)
>  {
> @@ -697,6 +700,9 @@ void __clk_unprepare(struct clk *clk)
>   if (clk->ops->unprepare)
>   clk->ops->unprepare(clk->hw);
>
> + /* send out notifier for dvfs */
> + __clk_notify(clk, POST_RATE_CHANGE, clk->rate, 0);
> +
>   __clk_unprepare(clk->parent);
>  }
>
> @@ -738,6 +744,9 @@ int __clk_prepare(struct clk *clk)
>   return ret;
>   }
>   }
> +
> + /* send out notifier for dvfs */
> + __clk_notify(clk, PRE_RATE_CHANGE, 0, clk->rate);
>   }
>
>   clk->prepare_count++;
>
>
> --
> Zhoujie Wu
