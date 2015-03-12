From: robherring2@gmail.com (Rob Herring)
Date: Thu, 12 Mar 2015 16:35:11 -0500
Subject: [PATCH 1/2] of: base: add function to get highest id of an alias
 stem
In-Reply-To: <1426177093-26820-2-git-send-email-wsa@the-dreams.de>
References: <1426177093-26820-1-git-send-email-wsa@the-dreams.de>
 <1426177093-26820-2-git-send-email-wsa@the-dreams.de>
Message-ID: <CAL_JsqKcOy_vR-NOsGwDHQfzAXrNPZ1Kqq99c8=SF_c136LwKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 11:17 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> I2C supports adding adapters using either a dynamic or fixed id. The
> latter is provided by aliases in the DT case. To prevent id collisions
> of those two types, install this function which gives us the highest
> fixed id, so we can then let the dynamically created ones come after
> this highest number.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>
> Because this function is so similar to of_alias_get_id(), I thought of merging
> them into __of_alias_get_id(np, stem, bool get_highest) and have two call
> wrappers but then decided the decreased readability is not worth the hazzle.
>
>  drivers/of/base.c  | 26 ++++++++++++++++++++++++++
>  include/linux/of.h |  6 ++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 0a8aeb8523fe7d..63cba04aacf686 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1958,6 +1958,32 @@ int of_alias_get_id(struct device_node *np, const char *stem)
>  }
>  EXPORT_SYMBOL_GPL(of_alias_get_id);
>
> +/**
> + * of_alias_get_highest_id - Get highest alias id for the given stem
> + * @stem:      Alias stem to be examined
> + *
> + * The function travels the lookup table to get the highest alias id for the
> + * given alias stem.  It returns the alias id if found.
> + */
> +int of_alias_get_highest_id(const char *stem)
> +{
> +       struct alias_prop *app;
> +       int id = -ENODEV;
> +
> +       mutex_lock(&of_mutex);
> +       list_for_each_entry(app, &aliases_lookup, link) {
> +               if (strcmp(app->stem, stem) != 0)
> +                       continue;
> +
> +               if (app->id > id)
> +                       id = app->id;
> +       }
> +       mutex_unlock(&of_mutex);
> +
> +       return id;
> +}
> +EXPORT_SYMBOL_GPL(of_alias_get_highest_id);
> +
>  const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
>                                u32 *pu)
>  {
> diff --git a/include/linux/of.h b/include/linux/of.h
> index dfde07e77a632b..9bfcc18ceab3bf 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -332,6 +332,7 @@ extern int of_count_phandle_with_args(const struct device_node *np,
>
>  extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
>  extern int of_alias_get_id(struct device_node *np, const char *stem);
> +extern int of_alias_get_highest_id(const char *stem);
>
>  extern int of_machine_is_compatible(const char *compat);
>
> @@ -594,6 +595,11 @@ static inline int of_alias_get_id(struct device_node *np, const char *stem)
>         return -ENOSYS;
>  }
>
> +static inline int of_alias_get_highest_id(const char *stem)
> +{
> +       return -ENOSYS;
> +}
> +
>  static inline int of_machine_is_compatible(const char *compat)
>  {
>         return 0;
> --
> 2.1.4
>
