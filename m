From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 5 Feb 2013 09:09:16 +0800
Subject: [PATCH v8 08/12] pinctrl: generic: dump pin configuration
In-Reply-To: <20130205005720.GD25185@atomide.com>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
 <1359825953-15663-9-git-send-email-haojian.zhuang@linaro.org>
 <20130205003535.GB25185@atomide.com>
 <20130205005720.GD25185@atomide.com>
Message-ID: <CAD6h2NQj3y_7MBSpRieSmPXztRb9uBsN8Law7S2DD+9xJShxxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 February 2013 08:57, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [130204 16:42]:
>> * Haojian Zhuang <haojian.zhuang@linaro.org> [130202 09:30]:
>> > @@ -114,4 +116,10 @@ static inline void pinconf_generic_dump_group(struct pinctrl_dev *pctldev,
>> >     return;
>> >  }
>> >
>> > +static void pinconf_generic_dump_config(struct pinctrl_dev *pctldev,
>> > +                                   struct seq_file *s,
>> > +                                   unsigned long config)
>> > +{
>> > +   return;
>> > +}
>> >  #endif
>>
>> This needs to be static inline void to avoid the following warning:
>>
>> drivers/pinctrl/pinconf.h:122: warning: ?pinconf_generic_dump_config? defined but not used
>
> Actually this patch needs few other changes to export it and compile,
> here's the version that worked for me with pinctlr-single as a module:
>

Thanks. I'll follow your changes.

Regards
Haojian

> --- a/drivers/pinctrl/pinconf-generic.c
> +++ b/drivers/pinctrl/pinconf-generic.c
> @@ -16,6 +16,7 @@
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/debugfs.h>
> +#include <linux/module.h>
>  #include <linux/seq_file.h>
>  #include <linux/pinctrl/pinctrl.h>
>  #include <linux/pinctrl/pinconf.h>
> @@ -120,4 +121,19 @@ void pinconf_generic_dump_group(struct pinctrl_dev *pctldev,
>         }
>  }
>
> +int pinconf_generic_dump_config(struct pinctrl_dev *pctldev,
> +                                struct seq_file *s, unsigned long config)
> +{
> +       int i;
> +
> +       for(i = 0; i < ARRAY_SIZE(conf_items); i++) {
> +               if (pinconf_to_config_param(config) != conf_items[i].param)
> +                       continue;
> +               seq_printf(s, "%s: 0x%x", conf_items[i].display,
> +                          pinconf_to_config_argument(config));
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(pinconf_generic_dump_config);
>  #endif
> diff --git a/drivers/pinctrl/pinconf.h b/drivers/pinctrl/pinconf.h
> index e3ed8cb..c91ea3e 100644
> --- a/drivers/pinctrl/pinconf.h
> +++ b/drivers/pinctrl/pinconf.h
> @@ -98,6 +98,8 @@ void pinconf_generic_dump_pin(struct pinctrl_dev *pctldev,
>  void pinconf_generic_dump_group(struct pinctrl_dev *pctldev,
>                               struct seq_file *s, const char *gname);
>
> +int pinconf_generic_dump_config(struct pinctrl_dev *pctldev,
> +                                struct seq_file *s, unsigned long config);
>  #else
>
>  static inline void pinconf_generic_dump_pin(struct pinctrl_dev *pctldev,
> @@ -114,4 +116,10 @@ static inline void pinconf_generic_dump_group(struct pinctrl_dev *pctldev,
>         return;
>  }
>
> +static inline int pinconf_generic_dump_config(struct pinctrl_dev *pctldev,
> +                                       struct seq_file *s,
> +                                       unsigned long config)
> +{
> +       return;
> +}
>  #endif
