From: xiechao.linux@gmail.com (chao xie)
Date: Fri, 25 Jan 2013 10:13:54 +0800
Subject: [V5 PATCH 24/26] usb: gadget: mv_udc: add device tree support
In-Reply-To: <20130124104904.GK32237@e106331-lin.cambridge.arm.com>
References: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
 <1359009530-28182-25-git-send-email-chao.xie@marvell.com>
 <20130124104904.GK32237@e106331-lin.cambridge.arm.com>
Message-ID: <CAK9wHMTVBRGf-mhnmzSKKGyuHKeXU7N8k2vTh9omkD4A0yhPsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/1/24 Mark Rutland <mark.rutland@arm.com>:
> Hello,
>
> On Thu, Jan 24, 2013 at 06:38:48AM +0000, Chao Xie wrote:
>> In original driver, we have callbacks in platform data, and some
>> dynamically allocations variables in platform data.
>> Now, these blocks are removed, the device tree support is easier
>> now.
>
> Please could you also add a binding document? See
> Documentation/devicetree/bindings/usb for examples of existing bindings.
>
> Also, please Cc devicetree-discuss when introducing a new binding as you are
> doing here.
>
>>
>> Signed-off-by: Chao Xie <chao.xie@marvell.com>
>> ---
>>  drivers/usb/gadget/mv_udc.h      |    5 +-
>>  drivers/usb/gadget/mv_udc_core.c |  106 ++++++++++++++++++++++++++++++--------
>>  2 files changed, 86 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/mv_udc.h b/drivers/usb/gadget/mv_udc.h
>> index 50ae7c7..de84722 100644
>> --- a/drivers/usb/gadget/mv_udc.h
>> +++ b/drivers/usb/gadget/mv_udc.h
>> @@ -179,6 +179,7 @@ struct mv_udc {
>>       int                             irq;
>>
>>       unsigned int                    extern_attr;
>> +     unsigned int                    mode;
>>       struct notifier_block           notifier;
>>
>>       struct mv_cap_regs __iomem      *cap_regs;
>> @@ -222,11 +223,9 @@ struct mv_udc {
>>       struct mv_usb2_phy      *phy;
>>       struct usb_phy          *transceiver;
>>
>> -     struct mv_usb_platform_data     *pdata;
>> -
>>       /* some SOC has mutiple clock sources for USB*/
>>       unsigned int    clknum;
>> -     struct clk      *clk[0];
>> +     struct clk      **clk;
>>  };
>>
>>  /* endpoint data structure */
>> diff --git a/drivers/usb/gadget/mv_udc_core.c b/drivers/usb/gadget/mv_udc_core.c
>> index 2e5907f..a4ee9a1 100644
>> --- a/drivers/usb/gadget/mv_udc_core.c
>> +++ b/drivers/usb/gadget/mv_udc_core.c
>> @@ -34,6 +34,7 @@
>>  #include <linux/irq.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/clk.h>
>> +#include <linux/of.h>
>>  #include <linux/platform_data/mv_usb.h>
>>  #include <linux/usb/mv_usb2.h>
>>  #include <asm/unaligned.h>
>> @@ -2153,21 +2154,57 @@ static int mv_udc_remove(struct platform_device *pdev)
>>       return 0;
>>  }
>>
>> +static int mv_udc_parse_dt(struct platform_device *pdev,
>> +                             struct mv_udc *udc)
>> +{
>> +     struct device_node *np = pdev->dev.of_node;
>> +     unsigned int clks_num;
>> +     int i, ret;
>> +     const char *clk_name;
>> +
>> +     if (!np)
>> +             return 1;
>> +
>> +     clks_num = of_property_count_strings(np, "clocks");
>> +     if (clks_num < 0)
>> +             return clks_num;
>> +
>> +     udc->clk = devm_kzalloc(&pdev->dev,
>> +             sizeof(struct clk *) * clks_num, GFP_KERNEL);
>> +     if (udc->clk == NULL)
>> +             return -ENOMEM;
>> +
>> +     for (i = 0; i < clks_num; i++) {
>> +             ret = of_property_read_string_index(np, "clocks", i,
>> +                     &clk_name);
>> +             if (ret)
>> +                     return ret;
>> +             udc->clk[i] = devm_clk_get(&pdev->dev, clk_name);
>> +             if (IS_ERR(udc->clk[i]))
>> +                     return PTR_ERR(udc->clk[i]);
>
> I was going to ask if you couldn't use of_clk_get, but I see you want to use
> the devm_* functions to handle cleanup. It seems a shame there's not a standard
> devm_of_clk_get.
>
It is nice to have someone to review the device tree part patches.
In fact main target of the modification is to remove the
pointers/callbacks in the platform_data, so
i can easly to add device tree support.

of_clk_get is is based on CONFIG_COMMON_CLK. of_clk_get is not simple.
The orginal way we use to
get a clock used two arguments: dev_id and con_id. The dev_id is the
name of the device.
of_clk_get need clock framework changes. It means that clock driver
need add device tree support. Now
we are doing the clock tree support for Marvell MMP SOCes, but it will
not be done in a short time.
As i think, of_clk_get still have some problems. It parses the
property's name as "clocks", but it does not support
mutipile clocks. If the device driver original has two clocks, the old
way can do it as
clk_get(dev, "clock 1");
clk_get(dev, "clock 2");
of_clk_get can not do it. I have not asked this question in the
mailist, and i will do it soon.

>> +     }
>> +
>> +     udc->clknum = clks_num;
>> +
>> +     ret = of_property_read_u32(np, "extern_attr", &udc->extern_attr);
>> +     if (ret)
>> +             return ret;
>
> This looks like a *very* bad idea. The udc::extern_attr field seems to be a set
> of flags, which this could reads in directly (without any sanity checking),
> effectively making it an undocumented ABI. This might be better as a set of
> valueless properties.
>
> Will unsigned int be the same as u32 on all platforms this could be used on?
> If not, you're passing the wrong type into of_property_read_u32.
>
> Additionally, in devicetree, '-' is used in preference of '_' in compatible
> and property names.
>
I see. So what you mean is if the extern_attr has two flags, FLAG_A and FLAG_B,
i need add two boolean properties Property_FLAG_A and Property_FLAG_B?

>> +
>> +     ret = of_property_read_u32(np, "mode", &udc->mode);
>> +     if (ret)
>> +             return ret;
>
> If I've understood correctly, this property will either be MV_USB_MODE_OTG (0)
> or MV_USB_MODE_OTG (1). Again, I don't think this is good to be exported as an
> ABI, especially as nothing in the enum definition points out that this affects
> anything outside the kernel.
>
> If this isn't something that wants to be changed at runtime, this should
> probably be a string property, with "host" and "otg" as valid values. Looking
> in Documentation/devicetree, the nvidia,tegra20-ehci binding uses similar
> strings in its dr_mode property. There may be other (undocumented) precedents.
>
Thanks. I will check the examples, and change it.

>> +
>> +     return 0;
>> +}
>> +
>>  static int mv_udc_probe(struct platform_device *pdev)
>>  {
>> -     struct mv_usb_platform_data *pdata = pdev->dev.platform_data;
>>       struct mv_udc *udc;
>>       int retval = 0;
>> -     int clk_i = 0;
>>       struct resource *r;
>>       size_t size;
>>
>> -     if (pdata == NULL) {
>> -             dev_err(&pdev->dev, "missing platform_data\n");
>> -             return -ENODEV;
>> -     }
>> -
>> -     size = sizeof(*udc) + sizeof(struct clk *) * pdata->clknum;
>> +     size = sizeof(*udc);
>>       udc = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
>>       if (udc == NULL) {
>>               dev_err(&pdev->dev, "failed to allocate memory for udc\n");
>> @@ -2175,14 +2212,43 @@ static int mv_udc_probe(struct platform_device *pdev)
>>       }
>>
>>       udc->done = &release_done;
>> -     udc->extern_attr = pdata->extern_attr;
>> -     udc->pdata = pdev->dev.platform_data;
>>       spin_lock_init(&udc->lock);
>>
>>       udc->dev = pdev;
>>
>> +     retval = mv_udc_parse_dt(pdev, udc);
>> +     if (retval > 0) {
>> +             /* no CONFIG_OF */
>> +             struct mv_usb_platform_data *pdata = pdev->dev.platform_data;
>> +             int clk_i = 0;
>> +
>> +             if (pdata == NULL) {
>> +                     dev_err(&pdev->dev, "missing platform_data\n");
>> +                     return -ENODEV;
>> +             }
>> +             udc->extern_attr = pdata->extern_attr;
>> +             udc->mode = pdata->mode;
>> +             udc->clknum = pdata->clknum;
>> +
>> +             size = sizeof(struct clk *) * udc->clknum;
>> +             udc->clk = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
>> +             if (udc->clk == NULL)
>> +                     return -ENOMEM;
>> +             for (clk_i = 0; clk_i < udc->clknum; clk_i++) {
>> +                     udc->clk[clk_i] = devm_clk_get(&pdev->dev,
>> +                                             pdata->clkname[clk_i]);
>> +                     if (IS_ERR(udc->clk[clk_i])) {
>> +                             retval = PTR_ERR(udc->clk[clk_i]);
>> +                             return retval;
>
> Why not just return PTR_ERR(udc->clk[clk_i]); ?
>
sure. i will change it.

>> +                     }
>> +             }
>> +     } else if (retval < 0) {
>> +             dev_err(&pdev->dev, "error parse dt\n");
>> +             return retval;
>> +     }
>> +
>>  #ifdef CONFIG_USB_OTG_UTILS
>> -     if (pdata->mode == MV_USB_MODE_OTG) {
>> +     if (udc->mode == MV_USB_MODE_OTG) {
>>               udc->transceiver = devm_usb_get_phy(&pdev->dev,
>>                                       USB_PHY_TYPE_USB2);
>>               if (IS_ERR_OR_NULL(udc->transceiver)) {
>> @@ -2191,17 +2257,6 @@ static int mv_udc_probe(struct platform_device *pdev)
>>               }
>>       }
>>  #endif
>> -
>> -     udc->clknum = pdata->clknum;
>> -     for (clk_i = 0; clk_i < udc->clknum; clk_i++) {
>> -             udc->clk[clk_i] = devm_clk_get(&pdev->dev,
>> -                                     pdata->clkname[clk_i]);
>> -             if (IS_ERR(udc->clk[clk_i])) {
>> -                     retval = PTR_ERR(udc->clk[clk_i]);
>> -                     return retval;
>> -             }
>> -     }
>> -
>>       r = platform_get_resource(udc->dev, IORESOURCE_MEM, 0);
>>       if (r == NULL) {
>>               dev_err(&pdev->dev, "no I/O memory resource defined\n");
>> @@ -2466,6 +2521,12 @@ static void mv_udc_shutdown(struct platform_device *pdev)
>>       mv_udc_disable(udc);
>>  }
>>
>> +static struct of_device_id mv_udc_dt_ids[] = {
>> +     { .compatible = "mrvl,mv-udc" },
>
> This compatible string should be listed in the binding document you generate to
> accompany this.
>
I see. i will add the documents at the device tree directory.
I will seperate the device tree part patches from the other patches. Thanks.

>> +     { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, mv_udc_dt_ids);
>> +
>>  static struct platform_driver udc_driver = {
>>       .probe          = mv_udc_probe,
>>       .remove         = mv_udc_remove,
>> @@ -2476,6 +2537,7 @@ static struct platform_driver udc_driver = {
>>  #ifdef CONFIG_PM
>>               .pm     = &mv_udc_pm_ops,
>>  #endif
>> +             .of_match_table = mv_udc_dt_ids,
>>       },
>>  };
>>
>> --
>> 1.7.4.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
> Thanks,
> Mark.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
