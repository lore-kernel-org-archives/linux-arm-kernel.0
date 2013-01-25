From: xiechao.linux@gmail.com (chao xie)
Date: Fri, 25 Jan 2013 10:27:15 +0800
Subject: [V5 PATCH 26/26] usb: ehci: ehci-mv: add device tree support
In-Reply-To: <20130124111603.GM32237@e106331-lin.cambridge.arm.com>
References: <1359009530-28182-1-git-send-email-chao.xie@marvell.com>
 <1359009530-28182-27-git-send-email-chao.xie@marvell.com>
 <20130124111603.GM32237@e106331-lin.cambridge.arm.com>
Message-ID: <CAK9wHMQF6UYpc-TVxh1ot9hgmErFfvhFGuPLNQn1CfaMcsnD-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/1/24 Mark Rutland <mark.rutland@arm.com>:
> On Thu, Jan 24, 2013 at 06:38:50AM +0000, Chao Xie wrote:
>> All blocks are removed. Add the device tree support for ehci.
>
> Similarly to the last two patches, could you please add a binding document?
>
>> Signed-off-by: Chao Xie <chao.xie@marvell.com>
>> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>> ---
>>  drivers/usb/host/ehci-mv.c |  105 +++++++++++++++++++++++++++++++++----------
>>  1 files changed, 80 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
>> index 171e145..79eca0c 100644
>> --- a/drivers/usb/host/ehci-mv.c
>> +++ b/drivers/usb/host/ehci-mv.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/module.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/clk.h>
>> +#include <linux/of.h>
>>  #include <linux/err.h>
>>  #include <linux/usb/otg.h>
>>  #include <linux/usb/mv_usb2.h>
>> @@ -32,11 +33,9 @@ struct ehci_hcd_mv {
>>
>>       struct usb_phy *otg;
>>
>> -     struct mv_usb_platform_data *pdata;
>> -
>>       /* clock source and total clock number */
>>       unsigned int clknum;
>> -     struct clk *clk[0];
>> +     struct clk **clk;
>>  };
>>
>>  static void ehci_clock_enable(struct ehci_hcd_mv *ehci_mv)
>> @@ -138,22 +137,55 @@ static const struct hc_driver mv_ehci_hc_driver = {
>>       .bus_resume = ehci_bus_resume,
>>  };
>>
>> +static int mv_ehci_parse_dt(struct platform_device *pdev,
>> +                             struct ehci_hcd_mv *ehci_mv)
>> +{
>> +     struct device_node *np = pdev->dev.of_node;
>> +     unsigned int clks_num;
>> +     int i, ret;
>> +     const char *clk_name;
>> +
>> +     if (!np)
>> +             return 1;
>
> Perhaps -ENODEV?
>
>> +
>> +     clks_num = of_property_count_strings(np, "clocks");
>> +     if (clks_num < 0)
>> +             return clks_num;
>> +
>> +     ehci_mv->clk = devm_kzalloc(&pdev->dev,
>> +             sizeof(struct clk *) * clks_num, GFP_KERNEL);
>> +     if (ehci_mv->clk == NULL)
>> +             return -ENOMEM;
>> +
>> +     for (i = 0; i < clks_num; i++) {
>> +             ret = of_property_read_string_index(np, "clocks", i,
>> +                     &clk_name);
>> +             if (ret)
>> +                     return ret;
>> +             ehci_mv->clk[i] = clk_get(NULL, clk_name);
>> +             if (IS_ERR(ehci_mv->clk[i]))
>> +                     return PTR_ERR(ehci_mv->clk[i]);
>> +     }
>> +
>> +     ehci_mv->clknum = clks_num;
>> +
>> +     ret = of_property_read_u32(np, "mode", &ehci_mv->mode);
>> +     if (ret)
>> +             return ret;
>
> Again, this is a bad idea.
>
>> +
>> +     return 0;
>> +}
>> +
>>  static int mv_ehci_probe(struct platform_device *pdev)
>>  {
>> -     struct mv_usb_platform_data *pdata = pdev->dev.platform_data;
>>       struct usb_hcd *hcd;
>>       struct ehci_hcd *ehci;
>>       struct ehci_hcd_mv *ehci_mv;
>>       struct resource *r;
>> -     int clk_i, retval = -ENODEV;
>> +     int retval = -ENODEV;
>>       u32 offset;
>>       size_t size;
>>
>> -     if (!pdata) {
>> -             dev_err(&pdev->dev, "missing platform_data\n");
>> -             return -ENODEV;
>> -     }
>> -
>>       if (usb_disabled())
>>               return -ENODEV;
>>
>> @@ -161,7 +193,7 @@ static int mv_ehci_probe(struct platform_device *pdev)
>>       if (!hcd)
>>               return -ENOMEM;
>>
>> -     size = sizeof(*ehci_mv) + sizeof(struct clk *) * pdata->clknum;
>> +     size = sizeof(*ehci_mv);
>>       ehci_mv = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
>>       if (ehci_mv == NULL) {
>>               dev_err(&pdev->dev, "cannot allocate ehci_hcd_mv\n");
>> @@ -170,19 +202,36 @@ static int mv_ehci_probe(struct platform_device *pdev)
>>       }
>>
>>       platform_set_drvdata(pdev, ehci_mv);
>> -     ehci_mv->pdata = pdata;
>>       ehci_mv->hcd = hcd;
>>
>> -     ehci_mv->clknum = pdata->clknum;
>> -     for (clk_i = 0; clk_i < ehci_mv->clknum; clk_i++) {
>> -             ehci_mv->clk[clk_i] =
>> -                 devm_clk_get(&pdev->dev, pdata->clkname[clk_i]);
>> -             if (IS_ERR(ehci_mv->clk[clk_i])) {
>> -                     dev_err(&pdev->dev, "error get clck \"%s\"\n",
>> -                             pdata->clkname[clk_i]);
>> -                     retval = PTR_ERR(ehci_mv->clk[clk_i]);
>> -                     goto err_clear_drvdata;
>> +     retval = mv_ehci_parse_dt(pdev, ehci_mv);
>> +     if (retval > 0) {
>
> Is this why you returned 1 from mv_ehci_parse_dt? So you only do this if you
> don't have a dt node?
>
> If so, why not rip the check (and positive error code) out of mv_ehci_parse_dt,
> and then here:
>
> if (pdev->dev.of_node) {
>         retval = mv_ehci_parse_dt(pdev, ehci_mv);
> } else
>         fall back to mv_usb_platform_data ...
> }
>
> That makes it obvious that one side depends on dt and the other's a fallback,
> and doesn't rely on nonstandard return code behaviour.
>

I will change it.

> Also, why not return immediately if mv_ehci_parse_dt fails?
>
I do not understand. if mv_ehci_parse_dt returns negative value, the
probe will be finished immediately.

> [...]
>
> Thanks,
> Mark.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
