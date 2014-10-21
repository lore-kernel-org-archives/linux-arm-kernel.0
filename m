From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 21 Oct 2014 14:29:25 +0200
Subject: [PATCH v2 1/4] regulator: max77686: Replace hard-coded opmode
 values with defines
In-Reply-To: <1413894170.31665.9.camel@AMDC1943>
References: <1413890597-31037-1-git-send-email-k.kozlowski@samsung.com>
 <1413890597-31037-2-git-send-email-k.kozlowski@samsung.com>
 <54464A37.6060701@collabora.co.uk> <1413894170.31665.9.camel@AMDC1943>
Message-ID: <544651A5.8080601@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 10/21/2014 02:22 PM, Krzysztof Kozlowski wrote:
> On wto, 2014-10-21 at 13:57 +0200, Javier Martinez Canillas wrote:
>> >  
>> > +/* On/off controlled by PWRREQ */
>> > +#define MAX77686_OPMODE_OFF_PWRREQ	0x1
>> 
>> Minor nit: maybe this should be called MAX77802_OFF_PWRREQ (without the OPMODE)?
>> Since afaiu from a conceptual pov the regulators only supports two modes: normal
>> and low power mode.
>> 
>> If a regulator is disabled or put in low power mode by PWRREQ on suspend, then
>> is not really an operating mode (the regulator output will still be normal until
>> suspend) but an enable pin to switch a regulator mode automatically by the SoC.
> 
> No problem. This is just a define for value used in register. However
> OPMODE is used in other places in that driver:
> #define MAX77686_OPMODE_SHIFT   6
> #define MAX77686_OPMODE_BUCK234_SHIFT   4
> #define MAX77686_OPMODE_MASK    0x3
>
> So this would be a little inconsistent...

Indeed, although I think there is a difference between talking about the OPMODE
field of the regulators control register (which the shift and mask refer to)
and the semantics of the value that is written (whether is an mode or an enable
pin).

But yeah, I agree the Maxim documentation is confusing and confused me too
before Mark explained to me that only two operating modes exist for this device.

> 
>> 
>> > +/*
>> > + * For some regulators this means:
>> > + *  - forcing low power mode.
>> > + *  - low power mode controlled by PWRREQ.
>> > + */
>> > +#define MAX77686_OPMODE_LOWPOWER	0x2
>> 
>> Can you also add a #define MAX77686_LP_PWRREQ 0x2 and use each one when
>> appropriate? That will better document when 0x2 means low power by PWRREQ
>> and when it means change regulator mode to low power.
> 
> Actually I made mistake in that comment. The 0x2 means force low power
> mode only for buck1-4... but there is no set_suspend_mode for these
> bucks. So this #define has only one semantic value.
> 
>> Also, are you sure that forcing low power mode is 0x2 and not 0x1?
> 
> You're right, for other LDOs, low power mode may be forced with 0x1. For
> such regulators the max77686_set_suspend_mode() is used which does not
> set value 0x1. This means that each define has only one semantic
> meaning.
> 
> I'll re-spin and fix the documentation to reflect both device
> capabilities and how the driver currently works.
> 
> Thanks for pointing this.
> 

You are welcome.

Best regards,
Javier 
