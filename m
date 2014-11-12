From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 12 Nov 2014 21:08:22 +0200
Subject: [PATCHv6 4/5] hwspinlock/core: add common OF helpers
In-Reply-To: <1410553499-55951-5-git-send-email-s-anna@ti.com>
References: <1410553499-55951-1-git-send-email-s-anna@ti.com>
 <1410553499-55951-5-git-send-email-s-anna@ti.com>
Message-ID: <CAK=WgbamdqAufjC4Xb5moERRBSB-cO6c1RPTE=f+dp75F+Eh7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On Fri, Sep 12, 2014 at 11:24 PM, Suman Anna <s-anna@ti.com> wrote:
> +int of_hwspin_lock_get_id(struct device_node *np, int index)
> +{
> +       struct hwspinlock_device *bank;
> +       struct of_phandle_args args;
> +       int id;
> +       int ret;
> +
> +       ret = of_parse_phandle_with_args(np, "hwlocks", "#hwlock-cells", index,
> +                                        &args);
> +       if (ret)
> +               return ret;
> +
> +       mutex_lock(&hwspinlock_tree_lock);
> +       list_for_each_entry(bank, &hwspinlock_devices, list)
> +               if (bank->dev->of_node == args.np)
> +                       break;
> +       mutex_unlock(&hwspinlock_tree_lock);
> +       if (&bank->list == &hwspinlock_devices) {
> +               ret = -EPROBE_DEFER;
> +               goto out;
> +       }

Is this the validation you mentioned which requires the existence of
"hwspinlock/core: maintain a list of registered hwspinlock banks" ?

I'm not convinced this is needed for several reasons:
- the user isn't using the lock yet at this point, and may only need
the id in order to communicate it to a remote processor
- if the user will try to use the lock prematurely,
hwspin_lock_request_specific should stop her
- moreover, hwspin_lock_request_specific must be the one who validates
the id, since in heterogeneous systems the user may get the id from a
remote processor and not via of_hwspin_lock_get_id

 "hwspinlock/core: maintain a list of registered hwspinlock banks"
adds complexity which must be very strongly justified.

If we're not sure there is a strong justification for it, we better
not merge it.

> +EXPORT_SYMBOL_GPL(of_hwspin_lock_get_base_id);
...
> +EXPORT_SYMBOL_GPL(of_hwspin_lock_get_num_locks);

Do we really must expose these two helpers globally?

Can we instead make these "static inline" methods and embed them in
hwspinlock_internal.h ?

Thanks,
Ohad.
