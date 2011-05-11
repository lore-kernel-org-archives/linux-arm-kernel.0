From: toddpoynor@google.com (Todd Poynor)
Date: Wed, 11 May 2011 11:27:42 -0700
Subject: [PATCH V3] OMAP3+: SR Layer Cleanup
In-Reply-To: <BANLkTin07ZkWwhMtqUEMhLtwugKNmhku9g@mail.gmail.com>
References: <1305105166-26109-1-git-send-email-shweta.gulati@ti.com>
	<BANLkTin07ZkWwhMtqUEMhLtwugKNmhku9g@mail.gmail.com>
Message-ID: <20110511182742.GA9409@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Another try with a different email client, sorry for any dups.]
...

> diff --git a/arch/arm/mach-omap2/sr_device.c
> b/arch/arm/mach-omap2/sr_device.c
> index 2782d3f..65b2aae 100644
> --- a/arch/arm/mach-omap2/sr_device.c
> +++ b/arch/arm/mach-omap2/sr_device.c
> @@ -82,6 +82,7 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
>        struct omap_sr_data *sr_data;
>        struct omap_device *od;
>        struct omap_volt_data *volt_data;
> +       struct omap_sr_dev_attr *sr_dev_attr;
>        char *name = "smartreflex";
>        static int i;
>
> @@ -92,9 +93,11 @@ static int sr_dev_init(struct omap_hwmod *oh, void
> *user)
>                return -ENOMEM;
>        }
>
> -       if (!oh->vdd_name) {
> +       sr_dev_attr = (struct omap_sr_dev_attr *)oh->dev_attr;
> +       if (!sr_dev_attr->voltdm_name) {
>                pr_err("%s: No voltage domain specified for %s."
>

Suggest if (!sr_dev_attr || !sr_dev_attr->voltdm_name) to catch this error.

> -                       "Cannot initialize\n", __func__, oh->name);
> +                               "Cannot initialize\n", __func__,
> +                                       sr_dev_attr->voltdm_name);
>

Should leave the hwmod's oh->name as the pr_err param, sr_dev_attr->voltdm_name
has just been verified bogus.


Todd
