From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Feb 2017 12:44:26 +0100
Subject: [PATCH v13 06/12] usb: xhci: use bus->sysdev for DMA configuration
In-Reply-To: <e532a212-cd15-ab42-6188-fc11a12633af@ti.com>
References: <1486776443-2280-1-git-send-email-peter.chen@nxp.com>
 <1486776443-2280-7-git-send-email-peter.chen@nxp.com>
 <e532a212-cd15-ab42-6188-fc11a12633af@ti.com>
Message-ID: <CAK8P3a1D1v=LXrW=-t-fRJjbo_C6OpSuoqiGuZPOaBzQYCT-kA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 11:36 AM, Roger Quadros <rogerq@ti.com> wrote:
> On 11/02/17 03:27, Peter Chen wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> For xhci-hcd platform device, all the DMA parameters are not
>> configured properly, notably dma ops for dwc3 devices. So, set
>> the dma for xhci from sysdev. sysdev is pointing to device that
>> is known to the system firmware or hardware.
>>
>> Cc: Baolin Wang <baolin.wang@linaro.org>
>> Cc: Vivek Gautam <vivek.gautam@codeaurora.org>
>> Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
>> Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
>> ---
>> Hi, Baolin, Vivek and Alexander,
>> I removed your tested-by tag due to add one change that adding sysdev
>> for shared hcd too, if your test shows this change works for you or
>> has no effect for you, please consider adding tested-by tag again,
>> thanks.

>> @@ -222,20 +241,20 @@ static int xhci_plat_probe(struct platform_device *pdev)
>>
>>       xhci->clk = clk;
>>       xhci->main_hcd = hcd;
>> -     xhci->shared_hcd = usb_create_shared_hcd(driver, &pdev->dev,
>> +     xhci->shared_hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
>>                       dev_name(&pdev->dev), hcd);
>>       if (!xhci->shared_hcd) {
>>               ret = -ENOMEM;
>>               goto disable_clk;
>>       }
>>
>> -     if (device_property_read_bool(&pdev->dev, "usb3-lpm-capable"))
>> +     if (device_property_read_bool(sysdev, "usb3-lpm-capable"))
>
> Why are we using sysdev to read DT property? We should be using the
> XHCI device (&pdev->dev) here, no?

If I remember correctly, this is one of the cases where pdev does not
have a device node attached to it because it was created by the driver
of the parent device on the fly in case of dwc3. When you have a pure xhci
device in DT, the two pointers are the same.

    Arnd
