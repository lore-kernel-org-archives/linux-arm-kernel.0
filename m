From: mikedunn@newsguy.com (Mike Dunn)
Date: Sat, 05 Jan 2013 05:06:43 -0800
Subject: [PATCH v2] ARM: pxa27x: fix ac97 controller warm reset code
In-Reply-To: <87obh4it6n.fsf@free.fr>
References: <1357223976-9097-1-git-send-email-mikedunn@newsguy.com>
 <50E67BAD.7070702@compulab.co.il> <50E6AF88.8050800@compulab.co.il>
 <87obh4it6n.fsf@free.fr>
Message-ID: <50E82563.3070706@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2013 12:34 PM, Robert Jarzmik wrote:
> Igor Grinberg <grinberg@compulab.co.il> writes:
>>
>> See below...
>> The DRIVE_HIGH does not really configures the GPIO to output high, but
>> only sets the MFP_LPM_DRIVE_HIGH bit which in turn is only effective in
>> low power modes.
>> This means, that by doing the above, you just configure the MFP for GPIO output,
>> but do not assign it a value, so it gets driven with some undefined value.
>> This is not safe.
>>
>> Can you please, check if the attached patch below does the job?
> 
> This is not the original behaviour before commit
> fb1bf8cd13bfa7ed0364ab0d82f717fc020d35f6.
> 
> The original behaviour was :
>  - on = 1 => set GPIO as output GPIO, set to 1
>  - on = 0 => set GPIO to the alternate function ac97reset, driven by PXA2xx AC97
>  IP.
> 
> If you don't set the alternate function, the GCR register usage for reset is
> useless, isn't it ? So why do you set the GPIO as "input" with on == 0 ?
> 
> And a question for Mike : when you made your tests, was it you intended
> behaviour to never set ac97 alternate function and use direct output GPIO
> setting with gpio_set_value(, X) ? Or am I missing something here ?


The original behavior: at the start of warm reset, reconfigure the mfp from alt
fn AC97_RESET_n to generic gpio output, driven high.  Then, when warm reset
completes, change the pin back to the ac97 alt fn.  As Igor pointed out, my
patch just reconfigured the pin as an generic output gpio, but did not actually
drive it high.

The unfortunate name and prototype given to the function
pxa27x_assert_ac97reset() by the commit back in 2010 does not help clarify things.

Am *I* missing anything?  I'm still looking into this, but with Igor's suggested
patch, warm reset no longer fails.

Thanks,
Mike
