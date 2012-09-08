From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 08 Sep 2012 10:35:12 +0200
Subject: [PATCH 3/3] ARM: EXYNOS: pm_domain: Bind devices to power domains
 using DT
In-Reply-To: <CAJuYYwQjuYZHYFig56OQ_rniExywekyKrN=6rw6rmfviGqOCig@mail.gmail.com>
References: <1346924286-9584-1-git-send-email-t.figa@samsung.com>
 <1346924286-9584-4-git-send-email-t.figa@samsung.com>
 <CAJuYYwQjuYZHYFig56OQ_rniExywekyKrN=6rw6rmfviGqOCig@mail.gmail.com>
Message-ID: <1545685.WCV2WTTlLF@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Saturday 08 of September 2012 13:48:24 Thomas Abraham wrote:
> > +Example of the node using power domain:
> > +
> > +       node {
> > +               /* ... */
> > +               power-domain = <&lcd0>;
> > +               /* ... */
> > +       };
> 
> Since the value of power-domain property is mostly samsung specific,
> should this be "samsung,power-domain" ?

Is there a convention of naming that defines such scheme? I have seen 
platform-specific properties without a prefix indicating the platform.

> > +static void exynos_read_domain_from_dt(struct device *dev)
> > +{
> > +       struct platform_device *pd_pdev;
> > +       struct exynos_pm_domain *pd;
> > +       struct device_node *node;
> > +
> > +       node = of_parse_phandle(dev->of_node, "power-domain", 0);
> > +       if (!node)
> > +               return;
> > +       pd_pdev = of_find_device_by_node(node);
> > +       if (!pd_pdev)
> > +               return;
> > +       pd = platform_get_drvdata(pd_pdev);
> > +       exynos_add_device_to_domain(pd, dev);
> > +}
> 
> The function "exynos_read_domain_from_dt" does more than reading the
> domain from dt. It associates a device with a power domain. So should
> it be renamed accordingly?

Hmm, do you have an idea for a better name? I'm not good at inventing 
names.

> > +
> > +static int exynos_pm_notifier_call(struct notifier_block *nb,
> > +                                   unsigned long event, void *data)
> > +{
> > +       struct device *dev = data;
> > +
> > +       switch (event) {
> > +       case BUS_NOTIFY_BIND_DRIVER:
> > +               if (dev->of_node)
> > +                       exynos_read_domain_from_dt(dev);
> > +
> > +               break;
> > +
> > +       case BUS_NOTIFY_UNBOUND_DRIVER:
> > +               exynos_remove_device_from_domain(dev);
> > +
> > +               break;
> > +       }
> > +       return NOTIFY_DONE;
> > +}
> > +
> > +static struct notifier_block platform_nb = {
> > +       .notifier_call = exynos_pm_notifier_call,
> > +};
> 
> All the functions above are so generic (or can be made generic with
> minor modifications) that it can be placed outside of mach-exynos. Or
> better still, reusable for all platforms.

Right, I have considered this and even CC'ed Rafael with this patchset, but 
I forgot to mention about it in patch description.

Maybe I should send a separate RFC with a generic variant?

> > 
> > --
> > 1.7.12
> 
> This patch looks so nice. I learned a thing or two from this patch.
> Reviewed-by: Thomas Abraham <thomas.abraham@linaro.org>

Thanks ;)

--
Best regards,
Tomasz Figa
