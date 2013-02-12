From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 12 Feb 2013 10:39:49 +0000
Subject: [PATCH v2 10/13] mailbox: create dbx500 mailbox driver
In-Reply-To: <1360645032-9668-11-git-send-email-s-anna@ti.com>
References: <1360645032-9668-1-git-send-email-s-anna@ti.com>
 <1360645032-9668-11-git-send-email-s-anna@ti.com>
Message-ID: <20130212103949.GA826@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have a few comments on the devicetree binding and the way it's parsed.

> +static const struct of_device_id dbx500_mailbox_match[] = {
> +       { .compatible = "stericsson,db8500-mailbox",
> +               .data = (void *)db8500_mboxes,
> +       },
> +       { .compatible = "stericsson,db9540-mailbox",
> +               .data = (void *)dbx540_mboxes,
> +       },
> +       { /* sentinel */}
> +};
> +

The binding for the compatible strings above and property parsing below should
be documented.

> +static int dbx500_mbox_probe(struct platform_device *pdev)
> +{
> +       const struct platform_device_id *platid = platform_get_device_id(pdev);
> +       struct resource *mem;
> +       int ret, i, legacy_offset = 0, upap_offset;
> +       struct mailbox **list;
> +       int irq;
> +       struct dbx500_plat_data *pdata = dev_get_platdata(&pdev->dev);
> +       struct device_node *np = pdev->dev.of_node;
> +
> +       if (!pdata) {
> +               if (np) {
> +                       of_property_read_u32(np, "legacy-offset",
> +                                                       &legacy_offset);

I see that legacy_offset is initialised to 0, and there's no check on the
return value of of_property_read_u32. Does that mean this is an optional
property? This needs to be documented.

> +                       of_property_read_u32(np, "upap-offset", &upap_offset);

However, upap_offset isn't initialised, but there's no check on the return
value. If "upap-offset" isn't defined in the dt, upap_offset won't have been
initialised. 

Is there no basic sanity checking that could be done here? I assume there's a
maximum offset we expect that's less than 4GB?

Additionally, of_property_read_u32 takes a *u32, not *int. It would be nice to
be consistent with the interface.

I'm not familiar with the hardware. What's the difference between the legacy
and upap cases?

> +                       list = (struct mailbox **)of_match_device(
> +                                       dbx500_mailbox_match, &pdev->dev)->data;
> +                       if (!list) {
> +                               /* No mailbox configuration */
> +                               dev_err(&pdev->dev, "No configuration found\n");
> +                               return -ENODEV;
> +                       }
> +               } else {
> +                       /* No mailbox configuration */
> +                       dev_err(&pdev->dev, "No configuration found\n");
> +                       return -ENODEV;
> +               }
> +       } else {
> +               list = (struct mailbox **)platid->driver_data;
> +               legacy_offset = pdata->legacy_offset;
> +               upap_offset = pdata->upap_offset;
> +       }
> +
> +       mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "prcm_reg");

Does this work for dt? I wasn't aware we got anything more than anonymous
memory and interrupts.

> +       mbox_base = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
> +       if (!mbox_base) {
> +               ret = -ENOMEM;
> +               goto out;
> +       }
> +
> +       mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "prcmu_tcdm");

Same here.

Thanks,
Mark.
