From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 16 Oct 2018 14:01:16 +0300
Subject: [PATCH 1/3] driver core: add probe_err log helper
In-Reply-To: <20181016072244.1216-2-a.hajda@samsung.com>
References: <CGME20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e@eucas1p2.samsung.com>
 <20181016072244.1216-1-a.hajda@samsung.com>
 <20181016072244.1216-2-a.hajda@samsung.com>
Message-ID: <CAHp75VfVxEkTzc=1hBrvc4K7r=L28vXipb=j9jSRJbTJE4GtLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 10:22 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> During probe every time driver gets resource it should usually check for error
> printk some message if it is not -EPROBE_DEFER and return the error. This
> pattern is simple but requires adding few lines after any resource acquisition
> code, as a result it is often omited or implemented only partially.
> probe_err helps to replace such code seqences with simple call, so code:
>         if (err != -EPROBE_DEFER)
>                 dev_err(dev, ...);
>         return err;
> becomes:
>         return probe_err(dev, err, ...);
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/base/core.c    | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/device.h |  2 ++
>  2 files changed, 39 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 04bbcd779e11..23fabefb217a 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3067,6 +3067,43 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>
>  #endif
>
> +/**
> + * probe_err - probe error check and log helper
> + * @dev: the pointer to the struct device
> + * @err: error value to test
> + * @fmt: printf-style format string
> + * @...: arguments as specified in the format string
> + *
> + * This helper implements common pattern present in probe functions for error
> + * checking: print message if the error is not -EPROBE_DEFER and propagate it.
> + * It replaces code sequence:
> + *     if (err != -EPROBE_DEFER)
> + *             dev_err(dev, ...);
> + *     return err;
> + * with
> + *     return probe_err(dev, err, ...);
> + *
> + * Returns @err.
> + *
> + */
> +int probe_err(const struct device *dev, int err, const char *fmt, ...)
> +{
> +       struct va_format vaf;
> +       va_list args;
> +

> +       if (err != -EPROBE_DEFER) {

Why not

if (err == ...)
 return err;

...
return err;

?

Better to read, better to maintain. No?

> +               va_start(args, fmt);
> +
> +               vaf.fmt = fmt;
> +               vaf.va = &args;
> +

> +               __dev_printk(KERN_ERR, dev, &vaf);

It would be nice to print an error code as well, wouldn't it?

> +               va_end(args);
> +       }
> +
> +       return err;
> +}
> +
>  static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
>  {
>         return fwnode && !IS_ERR(fwnode->secondary);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 90224e75ade4..06c2c797d132 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1577,6 +1577,8 @@ do {                                                                      \
>         WARN_ONCE(condition, "%s %s: " format, \
>                         dev_driver_string(dev), dev_name(dev), ## arg)
>
> +int probe_err(const struct device *dev, int err, const char *fmt, ...);
> +
>  /* Create alias, so I can be autoloaded. */
>  #define MODULE_ALIAS_CHARDEV(major,minor) \
>         MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
> --
> 2.18.0
>


-- 
With Best Regards,
Andy Shevchenko
