From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 21 Aug 2013 16:51:18 -0700
Subject: build warnings: multi_v7_defconfig + LPAE,
 printk with variable types
In-Reply-To: <CAOMZO5C44GRnTs+Oq9tCJ-mtH-9kyjMqEQWRDVadDfgOOSwaLA@mail.gmail.com>
 (Fabio Estevam's message of "Wed, 21 Aug 2013 12:50:16 -0300")
References: <87k3jfqdmp.fsf@linaro.org>
 <CAOMZO5C44GRnTs+Oq9tCJ-mtH-9kyjMqEQWRDVadDfgOOSwaLA@mail.gmail.com>
Message-ID: <87a9kaob61.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio Estevam <festevam@gmail.com> writes:

> On Wed, Aug 21, 2013 at 12:15 PM, Kevin Hilman <khilman@linaro.org> wrote:
>> [1]
>> Warnings:
>>         arch/arm/mach-omap2/gpmc.c:1495:4: warning: format '%x'
>> expects argument of type 'unsigned int', but argument 4 has type
>> resource_size_t' [-Wformat]
>
> For this warning, what about this?
>
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1491,8 +1491,8 @@ static int gpmc_probe_generic_child(struct
> platform_device *pdev,
>          */
>         ret = gpmc_cs_remap(cs, res.start);
>         if (ret < 0) {
> -               dev_err(&pdev->dev, "cannot remap GPMC CS %d to 0x%x\n",
> -                       cs, res.start);
> +               dev_err(&pdev->dev, "cannot remap GPMC CS %d to 0x%pa\n",
> +                       cs, &res.start);

hmm, why did you add the '&' ?  That changes the behavior, not just the
format.

Kevin
