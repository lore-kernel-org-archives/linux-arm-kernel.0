From: xiechao.linux@gmail.com (chao xie)
Date: Fri, 25 Jan 2013 10:16:35 +0800
Subject: [V5 PATCH 25/26] usb: otg: mv_otg: add device tree support
In-Reply-To: <20130124110237.GL32237@e106331-lin.cambridge.arm.com>
References: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
 <1359009530-28182-26-git-send-email-chao.xie@marvell.com>
 <20130124110237.GL32237@e106331-lin.cambridge.arm.com>
Message-ID: <CAK9wHMQ70ixGW7dq_=kXJacF6Ht7a66JnP-LgsC978fNvnCbgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/1/24 Mark Rutland <mark.rutland@arm.com>:
> On Thu, Jan 24, 2013 at 06:38:49AM +0000, Chao Xie wrote:
>> All blocks are removed. Add the device tree support for otg.
>
> As with mv_udc, this binding should be documented. Please Cc
> devicetree-discuss when you have one.
>
>>
>> Signed-off-by: Chao Xie <chao.xie@marvell.com>
>> ---
>>  drivers/usb/otg/mv_otg.c |  128 +++++++++++++++++++++++++++++++++++++--------
>>  drivers/usb/otg/mv_otg.h |    6 +-
>>  2 files changed, 108 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/usb/otg/mv_otg.c b/drivers/usb/otg/mv_otg.c
>> index 379df92..3aa7fdc 100644
>> --- a/drivers/usb/otg/mv_otg.c
>> +++ b/drivers/usb/otg/mv_otg.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/device.h>
>>  #include <linux/proc_fs.h>
>>  #include <linux/clk.h>
>> +#include <linux/of.h>
>>  #include <linux/workqueue.h>
>>  #include <linux/platform_device.h>
>>
>> @@ -333,7 +334,7 @@ static void mv_otg_update_inputs(struct mv_otg *mvotg)
>>       else
>>               otg_ctrl->id = !!(otgsc & OTGSC_STS_USB_ID);
>>
>> -     if (mvotg->pdata->otg_force_a_bus_req && !otg_ctrl->id)
>> +     if (mvotg->otg_force_a_bus_req && !otg_ctrl->id)
>>               otg_ctrl->a_bus_req = 1;
>>
>>       otg_ctrl->a_sess_vld = !!(otgsc & OTGSC_STS_A_SESSION_VALID);
>> @@ -690,21 +691,69 @@ int mv_otg_remove(struct platform_device *pdev)
>>       return 0;
>>  }
>>
>> +static int mv_otg_parse_dt(struct platform_device *pdev,
>> +                             struct mv_otg *mvotg)
>> +{
>> +     struct device_node *np = pdev->dev.of_node;
>> +     unsigned int clks_num;
>> +     unsigned int val;
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
>> +     mvotg->clk = devm_kzalloc(&pdev->dev,
>> +             sizeof(struct clk *) * clks_num, GFP_KERNEL);
>> +     if (mvotg->clk == NULL)
>> +             return -ENOMEM;
>> +
>> +     for (i = 0; i < clks_num; i++) {
>> +             ret = of_property_read_string_index(np, "clocks", i,
>> +                     &clk_name);
>> +             if (ret)
>> +                     return ret;
>> +             mvotg->clk[i] = devm_clk_get(&pdev->dev, clk_name);
>> +             if (IS_ERR(mvotg->clk[i]))
>> +                     return PTR_ERR(mvotg->clk[i]);
>> +     }
>
> Again, it seems a shame there's no devm_of_clk_get.
>
>> +
>> +     mvotg->clknum = clks_num;
>> +
>> +     ret = of_property_read_u32(np, "extern_attr", &mvotg->extern_attr);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = of_property_read_u32(np, "mode", &mvotg->mode);
>> +     if (ret)
>> +             return ret;
>
> I *really* don't like this, for the same reasons I stated in reply to the
> mv_udc patch.
>
i see. I will change it.

>> +
>> +     ret = of_property_read_u32(np, "force_a_bus_req", &val);
>> +     if (ret)
>> +             return ret;
>> +     mvotg->otg_force_a_bus_req = !!val;
>
> In devicetree, the typical way to handle a boolean case like this would be to
> have a valueless property. If present, the property is true, if not present
> it's considered to default to false:
>
> device at 4000 {
>         compatible = "manufacturer,some-device";
>         reg = <0x4000, 0x1000>;
>         manufacturer,boolean-property; /* no value, true if present */
> };
>
> Properties which may only have a meaning on one manufacturer's devices are also
> typically prefixed with the manufacturer similarly to compatible strings, e.g.
> "mrvl,force-a-bus-req".
>
> There may also be a better name for this property.
>
>> +
>> +     ret = of_property_read_u32(np, "disable_clock_gating", &val);
>> +     if (ret)
>> +             return ret;
>> +     mvotg->clock_gating = !val;
>
> You can do the same here, but with the logic inverted.
>

I will change it. Thanks.

>> +
>> +     return 0;
>> +}
>> +
>>  static int mv_otg_probe(struct platform_device *pdev)
>>  {
>> -     struct mv_usb_platform_data *pdata = pdev->dev.platform_data;
>>       struct mv_otg *mvotg;
>>       struct usb_otg *otg;
>>       struct resource *r;
>> -     int retval = 0, clk_i, i;
>> +     int retval = 0, i;
>>       size_t size;
>>
>> -     if (pdata == NULL) {
>> -             dev_err(&pdev->dev, "failed to get platform data\n");
>> -             return -ENODEV;
>> -     }
>> -
>> -     size = sizeof(*mvotg) + sizeof(struct clk *) * pdata->clknum;
>> +     size = sizeof(*mvotg);
>>       mvotg = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
>>       if (!mvotg) {
>>               dev_err(&pdev->dev, "failed to allocate memory!\n");
>> @@ -718,17 +767,45 @@ static int mv_otg_probe(struct platform_device *pdev)
>>       platform_set_drvdata(pdev, mvotg);
>>
>>       mvotg->pdev = pdev;
>> -     mvotg->extern_attr = pdata->extern_attr;
>> -     mvotg->pdata = pdata;
>>
>> -     mvotg->clknum = pdata->clknum;
>> -     for (clk_i = 0; clk_i < mvotg->clknum; clk_i++) {
>> -             mvotg->clk[clk_i] = devm_clk_get(&pdev->dev,
>> +     retval = mv_otg_parse_dt(pdev, mvotg);
>> +     if (retval > 0) {
>> +             struct mv_usb_platform_data *pdata = pdev->dev.platform_data;
>> +             /* no CONFIG_OF */
>> +             int clk_i = 0;
>> +
>> +             if (pdata == NULL) {
>> +                     dev_err(&pdev->dev, "missing platform_data\n");
>> +                     return -ENODEV;
>> +             }
>> +             mvotg->extern_attr = pdata->extern_attr;
>> +             mvotg->mode = pdata->mode;
>> +             mvotg->clknum = pdata->clknum;
>> +             mvotg->otg_force_a_bus_req = pdata->otg_force_a_bus_req;
>> +             if (pdata->disable_otg_clock_gating)
>> +                     mvotg->clock_gating = 0;
>> +
>> +             size = sizeof(struct clk *) * mvotg->clknum;
>> +             mvotg->clk = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
>> +             if (mvotg->clk == NULL) {
>> +                     dev_err(&pdev->dev,
>> +                             "failed to allocate memory for clk\n");
>> +                     return -ENOMEM;
>> +             }
>> +
>> +             for (clk_i = 0; clk_i < mvotg->clknum; clk_i++) {
>> +                     mvotg->clk[clk_i] = devm_clk_get(&pdev->dev,
>>                                               pdata->clkname[clk_i]);
>> -             if (IS_ERR(mvotg->clk[clk_i])) {
>> -                     retval = PTR_ERR(mvotg->clk[clk_i]);
>> -                     return retval;
>> +                     if (IS_ERR(mvotg->clk[clk_i])) {
>> +                             dev_err(&pdev->dev, "failed to get clk %s\n",
>> +                                     pdata->clkname[clk_i]);
>> +                             retval = PTR_ERR(mvotg->clk[clk_i]);
>> +                             return retval;
>
> You don't need to go via retval here.
>
I will change it. Thanks.
> [...]
>
> Thanks,
> Mark.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
