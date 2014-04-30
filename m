From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed, 30 Apr 2014 09:44:18 +0530
Subject: [PATCH v3 3/4] usb: ohci-exynos: Add facility to use phy provided
 by the generic phy framework
In-Reply-To: <Pine.LNX.4.44L0.1404281136440.1270-100000@iolanthe.rowland.org>
References: <1398677132-30600-4-git-send-email-gautam.vivek@samsung.com>
 <Pine.LNX.4.44L0.1404281136440.1270-100000@iolanthe.rowland.org>
Message-ID: <CAFp+6iFQh-CCj2p-H2ktT5Cm9635A15vtb6P07fi-PAWokJv9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Mon, Apr 28, 2014 at 9:11 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 28 Apr 2014, Vivek Gautam wrote:
>
>> Add support to consume phy provided by Generic phy framework.
>> Keeping the support for older usb-phy intact right now, in order
>> to prevent any functionality break in absence of relevant
>> device tree side change for ohci-exynos.
>> Once we move to new phy in the device nodes for ohci, we can
>> remove the support for older phys.
>>
>> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
>> Cc: Jingoo Han <jg1.han@samsung.com>
>> Cc: Alan Stern <stern@rowland.harvard.edu>
>> ---
>
>> +static int exynos_ohci_phy_enable(struct device *dev)
>>  {
>>       struct usb_hcd *hcd = dev_get_drvdata(dev);
>>       struct exynos_ohci_hcd *exynos_ohci = to_exynos_ohci(hcd);
>> +     int i;
>> +     int ret = 0;
>>
>> -     if (exynos_ohci->phy)
>> -             usb_phy_init(exynos_ohci->phy);
>> +     if (exynos_ohci->phy) {
>> +             ret = usb_phy_init(exynos_ohci->phy);
>> +             if (ret)
>> +                     return ret;
>> +     }
>> +
>> +     for (i = 0; ret == 0 && i < PHY_NUMBER; i++)
>> +             if (exynos_ohci->phy_g[i])
>> +                     ret = phy_power_on(exynos_ohci->phy_g[i]);
>> +     if (ret)
>> +             for (i--; i >= 0; i--)
>> +                     if (exynos_ohci->phy_g[i])
>> +                             phy_power_off(exynos_ohci->phy_g[i]);
>
> Do you want to call usb_phy_shutdown() at this point?

Yes, you are right. We should be calling usb_phy_shutdown() here. But
the two phy-provider
drivers should never work together, so one of the above PHYs will not exist.
Anyways, for code correctness too, we should be doing as you suggested.
I will change this.

>
>> +
>> +     return ret;
>>  }
>>
>> -static void exynos_ohci_phy_disable(struct device *dev)
>> +static int exynos_ohci_phy_disable(struct device *dev)
>>  {
>>       struct usb_hcd *hcd = dev_get_drvdata(dev);
>>       struct exynos_ohci_hcd *exynos_ohci = to_exynos_ohci(hcd);
>> +     int i;
>> +     int ret = 0;
>>
>>       if (exynos_ohci->phy)
>>               usb_phy_shutdown(exynos_ohci->phy);
>> +
>> +     for (i = 0; i < PHY_NUMBER; i++)
>> +             if (exynos_ohci->phy_g[i])
>> +                     ret = phy_power_off(exynos_ohci->phy_g[i]);
>> +
>> +     return ret;
>>  }
>
> This return value is practically meaningless.  It is the status from
> the last PHY only; any errors involving the other PHYs have been lost.
>
> You may as well make this function return void.

Right, i will make this function return void and remove 'ret' from it.

>
>> @@ -210,13 +302,18 @@ static int exynos_ohci_resume(struct device *dev)
>>  {
>>       struct usb_hcd *hcd                     = dev_get_drvdata(dev);
>>       struct exynos_ohci_hcd *exynos_ohci     = to_exynos_ohci(hcd);
>> +     int ret;
>>
>>       clk_prepare_enable(exynos_ohci->clk);
>>
>>       if (exynos_ohci->otg)
>>               exynos_ohci->otg->set_host(exynos_ohci->otg, &hcd->self);
>>
>> -     exynos_ohci_phy_enable(dev);
>> +     ret = exynos_ohci_phy_enable(dev);
>> +     if (ret) {
>> +             dev_err(dev, "Failed to enable USB phy\n");
>
> Do you want to call clk_disable_unprepare() here?

Yes, we should be calling clk_disable_unprepate() here to avoid the
warning in the next suspend cycle.



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
