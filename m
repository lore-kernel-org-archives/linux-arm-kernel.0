From: robh+dt@kernel.org (Rob Herring)
Date: Sat, 20 Aug 2016 15:18:45 -0500
Subject: [PATCH RFC] Revert "of/irq: Mark initialised interrupt
 controllers as populated"
In-Reply-To: <CABxcv=n9o7sU0zB3WZ2Sp8Aqd+fnv1KLp8UcAx2YSrKBVW+rhg@mail.gmail.com>
References: <E1bYVVh-0001eq-BI@rmk-PC.armlinux.org.uk>
 <CAL_JsqJNE7rGaL54HfmGEkaScZ7krf_iM55UrKw6mwWdLHv6Ow@mail.gmail.com>
 <CABxcv=n9o7sU0zB3WZ2Sp8Aqd+fnv1KLp8UcAx2YSrKBVW+rhg@mail.gmail.com>
Message-ID: <CAL_JsqKpLGscFaCT4x3NtQCOBgLK+-MQa_XDmpmkqyepdJVT4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 20, 2016 at 10:18 AM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> Hello Rob,
>
> On Sun, Aug 14, 2016 at 1:32 PM, Rob Herring <robh+dt@kernel.org> wrote:
>> On Sat, Aug 13, 2016 at 4:45 AM, Russell King
>> <rmk+kernel@armlinux.org.uk> wrote:
>>> This reverts commit 15cc2ed6dcf91a8658e084be4e140147161819d7, which
>>> causes a regression with iMX6 power domains.  iMX6 GPC contains both an
>>> interrupt controller and power domains.  The iMX6 GPC code is setup to
>>> register an interrupt controller using IRQCHIP_DECLARE(), but then to
>>> register the power domains using the platform device.
>>>
>>> This commit prevents the platform device being created, thereby breaking
>>> iMX6 power domain support.
>>>
>
> That commit also broke Exynos platforms since several devices are not
> created (GIC, Exynos combiner and PMU system controller for
> Exynos5420/5422/5800).
>
>>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>>> ---
>>> Please argue amongst yourselves about how to fix this regression caused
>>> by this commit...
>>
>> There's already a fix for this in my tree and -next. I will be sending
>> to Linus soon.
>>
>
> I guess you mean patch "[1/2] of/irq: Mark interrupt controllers as
> populated before initialisation" [0] ?
>
> Even with that patch on top of v4.8-rc2, things don't work for me. I
> needed to revert setting the OF_POPULATED flag in of_irq_init for
> things to work:
>
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index a2e68f740eda..5f9adc6c06e7 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -544,7 +544,7 @@ void __init of_irq_init(const struct of_device_id *matches)
>
>                         list_del(&desc->list);
>
> -                       of_node_set_flag(desc->dev, OF_POPULATED);
> +                       //of_node_set_flag(desc->dev, OF_POPULATED);
>
>                         pr_debug("of_irq_init: init %s (%p), parent %p\n",
>                                  desc->dev->full_name,
>
> I noticed that Philipp also sent a patch to clear that flag in
> arch/arm/mach-imx/gpc.c [1]. I guess the same is needed in the drivers
> for the devices that are not created for Exynos?

Yes, you need the same.

> If that's the case, then I think that's more safe to revert Jon's
> commit for now since is too risky for the -rc cycle and more platforms
> may be affected.

I prefer not to and find the affected platforms. I've now grepped the
tree to get all the IRQCHIP_DECLARE compatible strings and then
grepped for other occurrences and didn't find any more. In theory, we
could have matching happening with 2 different strings, but I'd guess
that is unlikely.

Rob
