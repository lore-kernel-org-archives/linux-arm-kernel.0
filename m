From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 3 Mar 2016 15:34:49 -0700
Subject: [PATCH 2/5] ARM: bcm2835: Replace alt0/i2s_alt[02] with standard
 groups.
In-Reply-To: <87bn6v6vrp.fsf@eliezer.anholt.net>
References: <1456510756-15337-1-git-send-email-eric@anholt.net>
 <1456510756-15337-3-git-send-email-eric@anholt.net>
 <56D8ABF4.6060801@wwwdotorg.org> <87bn6v6vrp.fsf@eliezer.anholt.net>
Message-ID: <56D8BC09.20600@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2016 03:28 PM, Eric Anholt wrote:
> Stephen Warren <swarren@wwwdotorg.org> writes:
>
>> On 02/26/2016 11:19 AM, Eric Anholt wrote:
>>> Since all of these pins were documented, we can use their names to
>>> explain what's going on.
>>
>>> diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
>>
>>>    &gpio {
>>> +	pinctrl-0 = <&i2c0_gpio0
>>> +		     &i2c1_gpio2
>>> +		     &gpclk0_gpio4
>>> +		     &gpclk1_gpio5
>>> +		     &spi0_gpio7
>>> +		     &pcm_gpio18
>>> +		     &pwm0_gpio40
>>> +		     &pwm1_gpio45
>>> +		     &gpioout
>>> +		     &alt3>;
>>>    };
>>
>> Why not convert alt3 to the new scheme too?
>
> (covered in the next patch)
>
>> I think this configures too many pins, which in turn makes assumptions
>> about what those pins are used for that may not be valid.
>>
>> Recent RPi firmware configures almost all expansion connector GPIOs as
>> GPIO-in. This ensures that no matter what is connected to the expansion
>> connector, there can be no signal conflicts due to both the bcm283x and
>> some external device both attempting to drive the same pin. I believe
>> the default Linux pinmux should adopt the same approach, by simply not
>> configuring any expansion connector pins except those known to have a
>> 100% hard-coded usage. For example, the HAT I2C pins must only be used
>> for that purpose on the RPi, so even if the HW supported using them as
>> arbitrary GPIO or PWM or ..., we know they're actually I2C.
>>
>> So, I think this list should only include configuration for pins
>> connected to on-board devices, or expansion pins that have a 100% known
>> purpose.
>>
>> (I can't quite remember how many pins are being configured in the
>> upstream kernel's DT files at present; it's possible the complying with
>> this rule may involve removing some pinctrl settings that are currently
>> present to avoid conflicts. User-specific additions should come from DT
>> overlays or manual DT edits.)
>
> If we want to improve on our default pin configurations, I'm into that,
> but I think the first step is to get groups split up so it's clear what
> we're doing with pins in the first place.  This patch is just a no-op
> change to get the board files to use smaller groups for
> enabling/disabling, and we should stack functional changes after that.

I don't think it's worth making patches that change things around when 
they're immediately going to be thrown away. It is needless churn. If 
you take the approach of removing settings that shouldn't be applied, 
you'll vastly reduce (and possibly even completely eliminate) the work 
to more optimally represent what's left.
