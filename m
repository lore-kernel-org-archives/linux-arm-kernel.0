From: robherring2@gmail.com (Rob Herring)
Date: Sat, 14 Jan 2012 09:06:08 -0600
Subject: [PATCH v2 10/15] ARM: highbank: convert to
 twd_local_timer_register() interface
In-Reply-To: <20120114024126.GE1810@S2101-09.ap.freescale.net>
References: <1326479322-6033-1-git-send-email-marc.zyngier@arm.com>
 <1326479322-6033-11-git-send-email-marc.zyngier@arm.com>
 <4F1080EB.1010909@gmail.com>
 <20120114024126.GE1810@S2101-09.ap.freescale.net>
Message-ID: <4F1199E0.5000003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2012 08:41 PM, Shawn Guo wrote:
> On Fri, Jan 13, 2012 at 01:07:23PM -0600, Rob Herring wrote:
>> On 01/13/2012 12:28 PM, Marc Zyngier wrote:
>>> Add support for the new smp_twd runtime registration interface
>>> to the highbank platforms, and remove the old compile-time support.
>>>
>>> The highbank DTS file is updated to match the TWD DT documentation.
>>>
>>> Cc: Rob Herring <rob.herring@calxeda.com>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>
>> A couple of minor things below. Otherwise,
>>
>> Acked-by: Rob Herring <rob.herring@calxeda.com>
>>
>>> ---
>>>  arch/arm/boot/dts/highbank.dts      |    4 +-
>>>  arch/arm/mach-highbank/Makefile     |    1 -
>>>  arch/arm/mach-highbank/highbank.c   |    5 ++++
>>>  arch/arm/mach-highbank/localtimer.c |   40 -----------------------------------
>>>  4 files changed, 7 insertions(+), 43 deletions(-)
>>>  delete mode 100644 arch/arm/mach-highbank/localtimer.c
>>>
>>> diff --git a/arch/arm/boot/dts/highbank.dts b/arch/arm/boot/dts/highbank.dts
>>> index 305635b..661373a 100644
>>> --- a/arch/arm/boot/dts/highbank.dts
>>> +++ b/arch/arm/boot/dts/highbank.dts
>>> @@ -72,13 +72,13 @@
>>>  		ranges;
>>>  
>>>  		timer at fff10600 {
>>> -			compatible = "arm,smp-twd";
>>> +			compatible = "arm,cortex-a9-twd-timer";
>>>  			reg = <0xfff10600 0x20>;
>>>  			interrupts = <1 13 0xf04>;
>>
>> Would you mind fixing these to be edge triggered.
>>
> This would just be an indication, since not only SGI but also PPI has
> a read-only Interrupt Configuration Register.  So does the patch below
> make sense?

That is implementation dependent for PPIs IIRC. Whether it's
programmable or not, you still need to know the type of interrupt
(although it doesn't seem to matter here).

Rob

> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index b2dc2dd..23a075f 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -186,8 +186,8 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
>         bool enabled = false;
>         u32 val;
> 
> -       /* Interrupt configuration for SGIs can't be changed */
> -       if (gicirq < 16)
> +       /* Interrupt configuration for SGIs and PPIs can't be changed */
> +       if (gicirq < 32)
>                 return -EINVAL;
> 
>         if (type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
> 
