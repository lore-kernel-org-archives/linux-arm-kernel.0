From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 26 Oct 2016 15:00:20 +0530
Subject: [PATCH/RFT v2 07/17] ARM: davinci: da8xx: Enable the usb20 "per"
 clk on phy_clk_enable
In-Reply-To: <5abddbfe-0338-6406-9299-1d2d3fb957a3@lechnology.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-8-ahaslam@baylibre.com>
 <833b6b60-4504-dac7-ccbb-bc08c985ad01@ti.com>
 <5abddbfe-0338-6406-9299-1d2d3fb957a3@lechnology.com>
Message-ID: <4472acb6-803b-0c44-2556-8b9430321e97@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 October 2016 09:35 PM, David Lechner wrote:
> On 10/25/2016 05:12 AM, Sekhar Nori wrote:
>> On Monday 24 October 2016 10:16 PM, ahaslam at baylibre.com wrote:
>>> diff --git a/arch/arm/mach-davinci/usb-da8xx.c
>>> b/arch/arm/mach-davinci/usb-da8xx.c
>>> index 9e41a7f..982e105 100644
>>> --- a/arch/arm/mach-davinci/usb-da8xx.c
>>> +++ b/arch/arm/mach-davinci/usb-da8xx.c
>>> @@ -53,11 +53,19 @@ int __init da8xx_register_usb_refclkin(int rate)
>>>
>>>  static void usb20_phy_clk_enable(struct clk *clk)
>>>  {
>>> +    struct clk *usb20_clk;
>>>      u32 val;
>>>      u32 timeout = 500000; /* 500 msec */
>>>
>>>      val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
>>>
>>> +    usb20_clk = clk_get(NULL, "usb20");
>>
>> We should not be using a NULL device pointer here. Can you pass the musb
>> device pointer available in the same file? Also, da850_clks[] in da850.c
>> needs to be fixed to add the matching device name.
> 
> This clock can be used for usb 1.1 PHY even when musb is not being used,
> so I don't think we can depend on having a musb device here.

Replied to this against the same question in v6 patch series you posted.

> Also, in a previous review, it was decided that the usb clocks should
> *not* be added to da850_clks[] [1]. Instead, they are dynamically
> registered elsewhere.

Thats only the USB phy clocks since there is associated
enable()/disable()/set_parent() code which is better kept outside of
da850.c for readability. No other reason. Lookup for the USB 2.0 module
clock is already present in da850.c

Thanks,
Sekhar
