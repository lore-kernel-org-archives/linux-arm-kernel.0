From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 29 Aug 2012 10:30:49 -0700
Subject: [PATCH] usb: tegra: moving phy driver into drivers directory
In-Reply-To: <D958900912E20642BCBC71664EFECE3E6DDE14DD7C@BGMAIL02.nvidia.com>
References: <1346146338-4996-1-git-send-email-vbyravarasu@nvidia.com>
 <503CD0A0.7080300@wwwdotorg.org>
 <D958900912E20642BCBC71664EFECE3E6DDE14DD7C@BGMAIL02.nvidia.com>
Message-ID: <503E51C9.7000606@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/12 22:17, Venu Byravarasu wrote:
> Stephen Warren wrote at Tuesday, August 28, 2012 7:37 PM:
>> On 08/28/2012 02:32 AM, Venu Byravarasu wrote:
>>> In order to keep up with the USB driver files organization,
>>> moving USB phy driver from mach-tegra to drivers/USB directory.
>>>
>>> Signed-off-by: Venu Byravarasu <vbyravarasu@nvidia.com>
>>
>>> diff --git a/arch/arm/mach-tegra/devices.c b/arch/arm/mach-
>> tegra/devices.c
>>
>>> -struct tegra_ulpi_config tegra_ehci2_ulpi_phy_config = {
>>> -	.reset_gpio = -1,
>>> -	.clk = "cdev2",
>>> -};
>>> -
>>>   struct tegra_ehci_platform_data tegra_ehci1_pdata = {
>>>   	.operating_mode = TEGRA_USB_OTG,
>>>   	.power_down_on_bus_suspend = 1,
>>> @@ -450,7 +444,7 @@ struct tegra_ehci_platform_data tegra_ehci1_pdata
>> = {
>>>   };
>>>
>>>   struct tegra_ehci_platform_data tegra_ehci2_pdata = {
>>> -	.phy_config = &tegra_ehci2_ulpi_phy_config,
>>> +	.phy_config = NULL,
>>
>> The PHY driver checks that field isn't NULL, and fails if it is:
>>
>>> struct tegra_usb_phy *tegra_usb_phy_open(struct device *dev, int
>> instance,
>>>          void __iomem *regs, void *config, enum tegra_usb_phy_mode
>> phy_mode)
>>> {
>> ...
>>>          phy->config = config;
>>>          phy->mode = phy_mode;
>>>
>>>          if (!phy->config) {
>>>                  if (phy_is_ulpi(phy)) {
>>>                          pr_err("%s: ulpi phy configuration missing", __func__);
>>>                          err = -EINVAL;
>>>                          goto err0;
>>
>> So, this change will completely break ULPI support, which currently
>> works fine. So, NAK.
>
> My initial plan was to add support for phy interfaces one by one.
> As part of that thought of UTMI only support at first and then add
> ULPI and HSIC in next patches.
> However as you were mentioning that it is not correct way, will
> push ULPI & UTMI support at once in next patches.

But with the existing code, both ULPI and UTMI work. This patch breaks 
something that already works.

>> I also plan on deleting devices.[ch] in kernel 3.7, and moving the USB
>> platform data into board-dt-tegra20.c, since that's the only place it's
>> used right now. So, this patch would conflict with that rather badly. I
>> just posted the patches for that to the linux-tegra mailing list last
>> night. Do you have better proposals for that? Perhaps usb_phy.c should
>> set phy->config to &ulpi_default in a similar fashion to how it works
>> for UTMI; that would remove some of the coupling between the changes.
>>
>> BTW, in your response to Felipe, you said...
>>
>>> Thanks Felipe for your comments.
>>> Created a patch to separate out phy related stuff to phy.h with you as a
>> reviewer.
>>> Plz let me know your comments.
>>
>> ... where is that patch?
>
> Plz see https://lkml.org/lkml/2012/8/28/58

Doesn't that link point at the patch I replied to?
