From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Fri, 5 Sep 2014 12:58:28 +0000
Subject: [PATCH V2 3/3] ARM: imx: source gpt per clk from OSC for system
 timer
In-Reply-To: <CAOMZO5CJLSXy3p-eAe9xOJw8p4gxoRuT91bXV8gswy5oMuU6XQ@mail.gmail.com>
References: <1409887606-22388-1-git-send-email-b20788@freescale.com>
 <1409887606-22388-4-git-send-email-b20788@freescale.com>,
 <CAOMZO5CJLSXy3p-eAe9xOJw8p4gxoRuT91bXV8gswy5oMuU6XQ@mail.gmail.com>
Message-ID: <5E619FDB-56BB-486E-B627-9D2A9D4F9F54@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Sent from my iPad

? 2014-9-5?20:09?"Fabio Estevam" <festevam@gmail.com> ???

> On Fri, Sep 5, 2014 at 12:26 AM, Anson Huang <b20788@freescale.com> wrote:
>> On i.MX6Q TO > 1.0, i.MX6DL and i.MX6SX, gpt per clock
>> can be from OSC instead of ipg_per, as ipg_per's rate
>> may be scaled when system enter low bus mode, to keep
>> system timer NOT drift, better to make gpt per clock
>> at fixed rate, here add support for gpt per clock to
>> be from OSC which is at fixed rate always.
>> 
>> There are some difference on this implementation of
>> gpt per clock source, see below for details:
>> 
>> i.MX6Q TO > 1.0: GPT_CR_CLKSRC, 3b'101 selects fix clock
>>    of OSC / 8 for gpt per clk;
> 
> You mean "5b'101 selects fix clock..."
> 
>> i.MX6DL and i.MX6SX: GPT_CR_CLKSRC, 3b'101 selects OSC
> 
> Same here: "5b'101"

[Anson] I thought 3b'101 means 3 bits, value 101... Maybe my understanding is incorrect, will correct it n v3.
> 
>> @@ -293,7 +299,7 @@ static int __init mxc_clockevent_init(struct clk *timer_clk)
>> static void __init _mxc_timer_init(int irq,
>>                                   struct clk *clk_per, struct clk *clk_ipg)
>> {
>> -       uint32_t tctl_val;
>> +       uint32_t tctl_val, tprer_val;
>> 
>>        if (IS_ERR(clk_per)) {
>>                pr_err("i.MX timer: unable to get clk\n");
>> @@ -312,10 +318,26 @@ static void __init _mxc_timer_init(int irq,
>>        __raw_writel(0, timer_base + MXC_TCTL);
>>        __raw_writel(0, timer_base + MXC_TPRER); /* see datasheet note */
>> 
>> -       if (timer_is_v2())
>> -               tctl_val = V2_TCTL_CLK_PER | V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
>> -       else
>> +       if (timer_is_v2()) {
>> +               if (((cpu_is_imx6q() && imx_get_soc_revision() >
>> +                       IMX_CHIP_REVISION_1_0) || cpu_is_imx6dl() ||
>> +                       cpu_is_imx6sx()) && (clk_get_rate(clk_per) ==
>> +                       V2_TIMER_RATE_OSC_DIV8)) {
>> +                       tctl_val = V2_TCTL_CLK_OSC_DIV8 | V2_TCTL_FRR |
>> +                               V2_TCTL_WAITEN | MXC_TCTL_TEN;
>> +                       if (cpu_is_imx6dl() || cpu_is_imx6sx()) {
>> +                               /* 24 / 8 = 3 MHz */
>> +                               tprer_val = 7 << V2_TPRER_PRE24M;
>> +                               __raw_writel(tprer_val, timer_base + MXC_TPRER);
>> +                               tctl_val |= V2_TCTL_24MEN;
>> +                       }
>> +               } else {
>> +                       tctl_val = V2_TCTL_CLK_PER | V2_TCTL_FRR |
>> +                               V2_TCTL_WAITEN | MXC_TCTL_TEN;
>> +               }
>> +       } else {
>>                tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
>> +       }
> 
> Can this block be rearranged a bit so that it becomes easier to read?

I have to consider v1, v2, and on v2, MX6Q's implementation is different from MX6DL and MX6SX, MX6SL has its special implementation, and MX6Q has difference between TO1.0 and other TOs, also, we have to consider the old dtb case. So, there are more than 6 different cases we need to consider, I thought it was the best way I can figure out, could you advice if you have better idea?
