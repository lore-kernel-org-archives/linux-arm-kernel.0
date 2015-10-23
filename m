From: stefan@agner.ch (Stefan Agner)
Date: Fri, 23 Oct 2015 16:53:55 -0700
Subject: [PATCH] clk: vf610: don't stop enabled clocks in suspend
In-Reply-To: <56248541.3050904@emcraft.com>
References: <1445007085-28250-1-git-send-email-sergeimir@emcraft.com>
 <95c4ad8c37f6f0a7429e8b1bdea17bb1@agner.ch> <56248541.3050904@emcraft.com>
Message-ID: <1293e7f724caefa7c184536096e82e04@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On 2015-10-18 22:53, Sergei Miroshnichenko wrote:
> Our goal is dynamic run-time configuration of wakeup sources in
> userspace using standard sysfs API:
> 
> echo enabled/disabled > /sys/class/<deviceX>/power/wakeup

Yes, that is exactly what I am talking about. In the tree I linked below
it is shown how I implemented this API for UART on Vybrid.

> 
> To implement wakeup support in drivers, the following template can be
> used in suspend()/resume() handlers:
> 
> if (device_may_wakeup(...)) {
> 	enable_irq_wake(...);/disable_irq_wake(...);
> } else {
> 	clk_disable_unprepare(...);/clk_prepare_enable(...);
> }
> 
> Next step will be declaring the rest of Vybrid clocks in
> drivers/clk/imx/clk-vf610.c (about 15 more). Those of them that aren't
> used by any driver, will be automatically turned off by kernel at
> startup (after all drivers are initialized) via clk_disable_unused().
> 
> With this approach, we utilize standard mechanism of waking up used all
> over the kernel, and make it configurable even from shell scripts. We've
> tested it with uart, gpio, rtc, spi, i2c, lan and mmc (SDIO): these
> changes are also planned to be sent upstream.

That is exactly the point: As long as we don't have the template above
for all drivers upstream, we should still let the hardware take care.

> 
> What do you think about this?

My suggestion is to use a "per clock" configuration in clk-vf610.c, as I
did it with UART with those two changes. This way we can make a slow
transition:
http://git.toradex.com/cgit/linux-toradex.git/commit/?h=toradex_vf_4.1-next&id=66e003c1ad2acdaa7d42e1113add7d44479392ab
http://git.toradex.com/cgit/linux-toradex.git/commit/?h=toradex_vf_4.1-next&id=fc60861b91c6585740e9a502fa4008b2f4694b22

Or we make sure all drivers really disable clocks correctly on suspend,
and then introduce your change...

--
Stefan

> 
> Best regards,
> Sergei
> 
> On 10/16/2015 10:46 PM, Stefan Agner wrote:
>> Hi Sergei,
>>
>> If all peripherals which do not act as wakeup source disable clocks
>> explicily, this would be the right approach. However, currently not all
>> of them do, hence this patch will raise the energy consumption during
>> sleep modes. The peripherals of course rely on the clock driver to
>> restore the state (gates) at wake-up time, but I think that is how it
>> works for most SoCs anyway.
>>
>> In the Toradex branch I came up with a solution which allows to
>> selectively define which clock should be disabled and which should be
>> left on by the hardware:
>> http://git.toradex.com/cgit/linux-toradex.git/commit/?h=toradex_vf_4.1-next&id=66e003c1ad2acdaa7d42e1113add7d44479392ab
>>
>> I then started to fix some peripherals so that they explicitly disable
>> clock if wakeup is not enabled. I changed those clocks so they do not
>> get automatically disabled:
>> http://git.toradex.com/cgit/linux-toradex.git/commit/?h=toradex_vf_4.1-next&id=fc60861b91c6585740e9a502fa4008b2f4694b22
>>
>> I plan to upstream those changes but did not came around to put
>> toghether a rebased and cleaned up patchset so far.
>>
>> --
>> Stefan
>>
>> On 2015-10-16 07:51, Sergei Miroshnichenko wrote:
>>> Currently Vybrid Clock Gating is configured to turn off all clocks in stop
>>> mode, while kernel assumes them enabled unless explicitly disabled. This
>>> behavior prevents waking up from wakeup sources.
>>>
>>> Fix this by replacing Clock Gating Register bitmask 3 (Clock is on during
>>> all modes, except stop mode) with bitmask 2 (Clock is on during all modes,
>>> even stop mode): refer to Vybrid Reference Manual Chapter 10 "Clock
>>> Controller Module (CCM)".
>>>
>>> Tested on a VF610-based board.
>>>
>>> Signed-off-by: Sergei Miroshnichenko <sergeimir@emcraft.com>
>>> ---
>>>  drivers/clk/imx/clk-gate2.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
>>> index 8935bff..ac35d75 100644
>>> --- a/drivers/clk/imx/clk-gate2.c
>>> +++ b/drivers/clk/imx/clk-gate2.c
>>> @@ -50,7 +50,8 @@ static int clk_gate2_enable(struct clk_hw *hw)
>>>  		goto out;
>>>
>>>  	reg = readl(gate->reg);
>>> -	reg |= 3 << gate->bit_idx;
>>> +	reg &= ~(3 << gate->bit_idx);
>>> +	reg |= 2 << gate->bit_idx;
>>>  	writel(reg, gate->reg);
>>>
>>>  out:
>>> @@ -86,7 +87,7 @@ static int clk_gate2_reg_is_enabled(void __iomem
>>> *reg, u8 bit_idx)
>>>  {
>>>  	u32 val = readl(reg);
>>>
>>> -	if (((val >> bit_idx) & 1) == 1)
>>> +	if (((val >> bit_idx) & 3) == 2)
>>>  		return 1;
>>>
>>>  	return 0;
>>
