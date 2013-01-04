From: mikedunn@newsguy.com (Mike Dunn)
Date: Fri, 04 Jan 2013 12:29:46 -0800
Subject: [PATCH v2] ARM: pxa27x: fix ac97 controller warm reset code
In-Reply-To: <50E6AF88.8050800@compulab.co.il>
References: <1357223976-9097-1-git-send-email-mikedunn@newsguy.com>
 <50E67BAD.7070702@compulab.co.il> <50E6AF88.8050800@compulab.co.il>
Message-ID: <50E73BBA.1050106@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2013 02:31 AM, Igor Grinberg wrote:

[..]


> Looking at this one more time...
> fb1bf8cd13 ([ARM] pxa: introduce processor specific pxa27x_assert_ac97reset())
> also removed the call to pxa_gpio_mode() function which effectively set
> AF to GPIO and configured the GPIO to output high.
> (Later b1d9bf1d ([ARM] pxa: remove pxa_gpio_mode() and files) removed the
> pxa_gpio_mode() function)
> 
> See below...

>
>>>
>>>  extern int keypad_set_wake(unsigned int on);
>>>  #endif /* __ASM_ARCH_MFP_PXA27X_H */
>>> diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
>>> index 8047ee0..616cb87 100644
>>> --- a/arch/arm/mach-pxa/pxa27x.c
>>> +++ b/arch/arm/mach-pxa/pxa27x.c
>>> @@ -47,9 +47,9 @@ void pxa27x_clear_otgph(void)
>>>  EXPORT_SYMBOL(pxa27x_clear_otgph);
>>>
>>>  static unsigned long ac97_reset_config[] = {
>>> -	GPIO113_GPIO,
>>> +	GPIO113_AC97_nRESET_GPIO_HIGH,
>>>  	GPIO113_AC97_nRESET,
>>> -	GPIO95_GPIO,
>>> +	GPIO95_AC97_nRESET_GPIO_HIGH,
>>>  	GPIO95_AC97_nRESET,
>>>  };
>>>
>>
>


>
>>>
>>>  extern int keypad_set_wake(unsigned int on);
>>>  #endif /* __ASM_ARCH_MFP_PXA27X_H */
>>> diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
>>> index 8047ee0..616cb87 100644
>>> --- a/arch/arm/mach-pxa/pxa27x.c
>>> +++ b/arch/arm/mach-pxa/pxa27x.c
>>> @@ -47,9 +47,9 @@ void pxa27x_clear_otgph(void)
>>>  EXPORT_SYMBOL(pxa27x_clear_otgph);
>>>
>>>  static unsigned long ac97_reset_config[] = {
>>> -	GPIO113_GPIO,
>>> +	GPIO113_AC97_nRESET_GPIO_HIGH,
>>>  	GPIO113_AC97_nRESET,
>>> -	GPIO95_GPIO,
>>> +	GPIO95_AC97_nRESET_GPIO_HIGH,
>>>  	GPIO95_AC97_nRESET,
>>>  };
>>>
>>
>



[..]


> The DRIVE_HIGH does not really configures the GPIO to output high, but
> only sets the MFP_LPM_DRIVE_HIGH bit which in turn is only effective in
> low power modes.
> This means, that by doing the above, you just configure the MFP for GPIO output,
> but do not assign it a value, so it gets driven with some undefined value.
> This is not safe.
> 
> Can you please, check if the attached patch below does the job?	


Yes, it does! (With a warning from gpiolib becaus gpio_request() was not called).

In a different patch, I skip the ac97 warm reset if the link is up (which it
always is when called), so honestly, I didn't functionally test my patch.
Normally I wouldn't submit a patch without testing, but clearly the code was
already broken anyway, and the change looked straightforward (danger!).

With your patch and my other patch removed, the warm reset does not fail, as before.

I am in your debt!  I will submit a new version of this patch soon.

Thanks again,
Mike
