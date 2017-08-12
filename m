From: icenowy@aosc.io (icenowy at aosc.io)
Date: Sat, 12 Aug 2017 12:51:17 +0800
Subject: [PATCH v3 08/10] clk: sunxi-ng: support R40 SoC
In-Reply-To: <CAGb2v66_n-ZDRsCd+wcwUgvVbNw3OBk6JG9yqp8Mb6gXajHk3g@mail.gmail.com>
References: <20170527102308.1988-1-icenowy@aosc.io>
 <20170527102308.1988-9-icenowy@aosc.io>
 <20170529073428.f5os7g5e666v4xnp@wens.csie.org>
 <e09fedcfd790963729f785cd432206a6@aosc.io>
 <CAGb2v66_n-ZDRsCd+wcwUgvVbNw3OBk6JG9yqp8Mb6gXajHk3g@mail.gmail.com>
Message-ID: <36d3f8302887937ff18067fd6f6bc38d@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-08-12 12:04?Chen-Yu Tsai ???
> On Sat, Jul 22, 2017 at 11:00 AM,  <icenowy@aosc.io> wrote:
>> ? 2017-05-29 15:34?Chen-Yu Tsai ???
>>> 
>>> Hi,
>>> 
>>> On Sat, May 27, 2017 at 06:23:06PM +0800, Icenowy Zheng wrote:
> 
> [...]
> 
>>>> +
>>>> +/*
>>>> + * For the special bit in gate part, please see the BSP source code 
>>>> at
>>>> + *
>>>> https://github.com/BPI-SINOVOIP/BPI-M2U-bsp/blob/master/linux-sunxi/drivers/clk/sunxi/clk-sun8iw11.c#L665
>>>> + */
>>>> +static SUNXI_CCU_NKM_WITH_GATE_LOCK(pll_sata_clk, "pll-sata",
>>>> +                                   "osc24M", 0x034,
>>>> +                                   8, 5,       /* N */
>>>> +                                   4, 2,       /* K */
>>>> +                                   0, 2,       /* M */
>>>> +                                   BIT(31) | BIT(14),  /* gate */
>>>> +                                   BIT(28),    /* lock */
>>>> +                                   0);
>>> 
>>> 
>>> I think this is a somewhat simplified approach. From what I 
>>> understand
>>> of the user manual, the SATA clock path look like:
>>> 
>>> 
>>> [ PLL-PERIPH0-SATA ] -\
>>>                       mux @ 0x34 bit 30 --- gate @ 0x34 bit 14 --- 
>>> ...
>>> [ PLL-SATA ] ---------/
>>> 
>>> ... from above ... ------\
>>>                          mux @ 0xc8 bit 24 --- gate @ 0xc8 bit 31
>>> [ external oscillator ] -/
>>> 
>>> If you choose to simplify the implementation, please include a 
>>> detailed
>>> note as to why you chose to do so, and the validity of the 
>>> simplification.
>> 
>> 
>> I think it can be fully implemented...
>> 
>> But how should I call the internal clock controlled by the mux @ 0x34 
>> bit
>> 30?
> 
> sata-pll-mux?

I choose to call it pll-sata-out, as the mux @ 0x34 bit 30 is called
"PLL_OUTPUT_SEL".

> 
> ChenYu
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
