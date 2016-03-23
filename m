From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 23 Mar 2016 23:24:31 +0530
Subject: [PATCH v2 04/11] ARM: davinci: da8xx: add usb phy clocks
In-Reply-To: <56F2D61F.80000@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-5-git-send-email-david@lechnology.com>
 <56F2CAB8.3090705@ti.com> <56F2D61F.80000@lechnology.com>
Message-ID: <56F2D857.3040807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 March 2016 11:15 PM, David Lechner wrote:
> On 03/23/2016 11:56 AM, Sekhar Nori wrote:
>>>
>>> +static struct clk usb_ref_clk = {
>>> +    .name        = "usb_ref_clk",
>>> +    .rate        = 48000000,
>>> +    .set_rate    = davinci_simple_set_rate,
>>> +};
>>
>> can we call this usb_refclkin so it matches the TRM name? Also, should
>> this node be not be coming through individual board files as the rate
>> depends on what is connected to the usb_refclkin pin? Or is the
>> expectation that boards will call clk_set_rate() on this clock to the
>> correct value? If yes, I think it is misleading to populate the .rate
>> here.
> 
> You are right. When I did this, I was looking at USB 1.1 only, which
> MUST be 48MHz. However, this can be used for USB 2.0 which can accept a
> number of rates.
> 
> However, even the main reference oscillator in da850.c has the rate hard
> coded in da850.c (DA850_REF_FREQ).

:)

> 
> The clock initialization will fail if a clock does not have a parent or
> a rate, so we have to give it a default rate since it is an external
> clock and has no parent. So, I think 48MHz makes sense for a default
> value. Most boards will probably not be using this clock anyway, but
> rather the PLL in the USB 2.0 PHY.

Alright, I guess the only change is to call it usb_refclkin

> 
> 
>>> +
>>> +    pr_info("Waiting for USB 2.0 PHY clock good...\n");
>>> +    while (!(readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG))
>>> +                        & CFGCHIP2_PHYCLKGD))
>>> +        cpu_relax();
>>
>> I guess this is copying some earlier code, but still, it will be nice to
>> see a timeout mechanism here, rather than loop endlessly.
> 
> Do you have a suggestion on how to do this?

Simplest would be to use a udelay(1) inside the loop and count a
specific number of times (sufficiently large to not cause false
negatives and sufficiently small so as to not appear that board is
frozen forever).

Thanks,
Sekhar
