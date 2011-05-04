From: toddpoynor@google.com (Todd Poynor)
Date: Wed, 4 May 2011 15:11:38 -0700
Subject: [PATCH 6/8] OMAP2+: omap_device: implement the constraints
	management code
In-Reply-To: <1304516117-9334-7-git-send-email-j-pihet@ti.com>
References: <1304516117-9334-1-git-send-email-j-pihet@ti.com>
	<1304516117-9334-7-git-send-email-j-pihet@ti.com>
Message-ID: <BANLkTinVCLiXYoPcP905Fhv2ejUH1QfLBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 4, 2011 at 6:35 AM, <jean.pihet@newoldbits.com> wrote:

> ...
> diff --git a/arch/arm/plat-omap/omap_device.c
> b/arch/arm/plat-omap/omap_device.c
> index 9bbda9a..1d075cb 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -292,10 +292,196 @@ static void _add_optional_clock_clkdev(struct
> omap_device *od,
>        }
>  }
>
> +/* Spinlock that protects the constraints lists */
> +static spinlock_t _constraints_lock;
> +
> +/*
> + * _store_constraint: add/update/remove a constraint from a plist. There
> is
> + *  one plist per omap_device.
> + *
> + * @constraints_list: plist to use
> + * @req_dev: constraint requester, used to track the requests
> + * @dev: device constraint target, used to track the requests
> + * @value: constraint value. The plist is sorted by the value. -1 remove
> the
> + *  constraint from the list
> + * @ascending: return the lowest constraint value if set to 1, return the
> + *  highest value if not.
> + *
> + * Tracks the constraints by req_dev and dev.
> + * Returns the strongest constraint value for the given device, 0 in the
> + * case there is no constraint or a negative value in case of error.
> + *
> + * The caller must check the validity of the parameters.
> + */
> +static long _store_constraint(struct plist_head *constraints_list,
> +                             struct device *req_dev, struct device *dev,
> +                             long value, int ascending)
> +{
> +       struct omap_device_constraints_entry *user = NULL, *tmp_user;
> +       int ret = 0;
> +       unsigned long flags;
> +
> +       /* Check if there already is a constraint for dev and req_dev */
> +       spin_lock_irqsave(&_constraints_lock, flags);
> +       plist_for_each_entry(tmp_user, constraints_list, node) {
> +               if ((tmp_user->req_dev == req_dev) && (tmp_user->dev ==
> dev)) {
> +                       user = tmp_user;
> +                       break;
> +               }
> +       }
> +       spin_unlock_irqrestore(&_constraints_lock, flags);
> +
> +       if (value >= 0) {
> +               /* Nothing to update, job done */
> +               if (user && (user->node.prio == value))
> +                       goto exit_ok;
> +
> +               /* Add new entry to the list or update existing request */
> +               if (!user) {
> +                       user = kzalloc(
> +                               sizeof(struct
> omap_device_constraints_entry),
> +                               GFP_KERNEL);
> +                       if (!user) {
> +                               pr_err("%s: FATAL ERROR: kzalloc failed\n",
> +                                      __func__);
> +                               ret = -ENOMEM;
> +                               goto exit_error;
> +                       }
> +                       user->req_dev = req_dev;
> +                       user->dev = dev;
> +               } else {
> +                       spin_lock_irqsave(&_constraints_lock, flags);
> +                       plist_del(&user->node, constraints_list);
>

spinlock was dropped, no ref counting, not safe to assume user is still
valid.


> +                       spin_unlock_irqrestore(&_constraints_lock, flags);
> +               }
> +
> +               spin_lock_irqsave(&_constraints_lock, flags);
> +               plist_node_init(&user->node, value);
>

and user may be invalid here


> +               plist_add(&user->node, constraints_list);
> +               spin_unlock_irqrestore(&_constraints_lock, flags);
> +       } else {
> +               /* Remove the constraint from the list */
> +               if (!user) {
> +                       pr_err("%s: Error: no prior constraint to
> release\n",
> +                              __func__);
> +                       ret = -EINVAL;
> +                       goto exit_error;
> +               }
> +
> +               spin_lock_irqsave(&_constraints_lock, flags);
> +               plist_del(&user->node, constraints_list);
>

and here


> +               spin_unlock_irqrestore(&_constraints_lock, flags);
> +               kfree(user);
> +       }
> +
> +exit_ok:
> +       /* Find the strongest constraint for the given device */
> +       if (!plist_head_empty(constraints_list)) {
> +               spin_lock_irqsave(&_constraints_lock, flags);
>

Deref of plist_first/last() should happen after a plist_head_empty() check
with the spinlock held.


> +               if (ascending) {
> +                       /* Find the lowest (i.e. first) value */
> +                       ret = plist_first(constraints_list)->prio;
> +               } else {
> +                       /* Find the highest (i.e. last) value */
> +                       ret = plist_last(constraints_list)->prio;
> +               }
> +               spin_unlock_irqrestore(&_constraints_lock, flags);
> +       }
> +
> +exit_error:
> +       return ret;
> +}
> ...
>

Todd
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110504/49eafa40/attachment-0001.html>
