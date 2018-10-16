From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 16 Oct 2018 16:42:41 +0300
Subject: [PATCH 2/3] driver core: add deferring probe reason to
 devices_deferred property
In-Reply-To: <20181016072244.1216-3-a.hajda@samsung.com>
References: <CGME20181016072249eucas1p28855602564eb74a771fe521712962680@eucas1p2.samsung.com>
 <20181016072244.1216-1-a.hajda@samsung.com>
 <20181016072244.1216-3-a.hajda@samsung.com>
Message-ID: <CAHp75VefP2qit3=s9E_uuOg4+J0Zk2OD-XjpVsWM7X3s2g-0wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 10:22 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> /sys/kernel/debug/devices_deferred property contains list of deferred devices.
> This list does not contain reason why the driver deferred probe, the patch
> improves it.
> The natural place to set the reason is probe_err function introduced recently,
> ie. if probe_err will be called with -EPROBE_DEFER instead of printk the message
> will be attached to deferred device and printed when user read devices_deferred
> property.


> -       if (err != -EPROBE_DEFER) {
> -               va_start(args, fmt);
> +       va_start(args, fmt);
>
> -               vaf.fmt = fmt;
> -               vaf.va = &args;
> +       vaf.fmt = fmt;
> +       vaf.va = &args;
>
> +       if (err != -EPROBE_DEFER)
>                 __dev_printk(KERN_ERR, dev, &vaf);
> -               va_end(args);
> -       }
> +       else
> +               __deferred_probe_set_msg(dev, fmt, args);
> +
> +       va_end(args);

Yeah, ping-pong style of programming (one patch "amends" something
which had been introduced by another).
That's why better to follow my comment for the patch 1.

> +/*
> + * __deferred_probe_set_msg() - Set defer probe reason message for device
> + */
> +void __deferred_probe_set_msg(const struct device *dev, const char *fmt,
> +                                    va_list args)
> +{
> +       const int size = 128;
> +       char **p;
> +       int n;
> +
> +       mutex_lock(&deferred_probe_mutex);
> +


> +       p = &dev->p->deferred_probe_msg;
> +       if (!*p) {
> +               *p = kmalloc(size, GFP_KERNEL);
> +               if (!*p)
> +                       goto end;
> +       }
> +       n = snprintf(*p, size, "%s %s: ", dev_driver_string(dev), dev_name(dev));
> +       if (n < size)
> +               vsnprintf(*p + n, size - n, fmt, args);

Perhaps kasprintf() instead of this huge plays around the size and allocation?

>         list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
> -               seq_printf(s, "%s\n", dev_name(curr->device));
> +               if (curr->device->p->deferred_probe_msg)
> +                       seq_puts(s, curr->device->p->deferred_probe_msg);
> +               else
> +                       seq_printf(s, "%s\n", dev_name(curr->device));

I wouldn't care (much) about debugfs, though better to keep some order
here, i.e. always print device name.

Something like

seq_printf(s, "%s\t%s\n", dev_name(), deferred_probe_msg ?: "");

and remove that part from above __deferred_probe_set_msg().

-- 
With Best Regards,
Andy Shevchenko
