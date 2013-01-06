From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 06 Jan 2013 09:11:01 +0200
Subject: [PATCH v2] ARM: pxa27x: fix ac97 controller warm reset code
In-Reply-To: <87obh4it6n.fsf@free.fr>
References: <1357223976-9097-1-git-send-email-mikedunn@newsguy.com>
 <50E67BAD.7070702@compulab.co.il> <50E6AF88.8050800@compulab.co.il>
 <87obh4it6n.fsf@free.fr>
Message-ID: <50E92385.5020107@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/13 22:34, Robert Jarzmik wrote:
> Igor Grinberg <grinberg@compulab.co.il> writes:
> 
>> On 01/04/13 08:50, Igor Grinberg wrote:
>>> On 01/03/13 16:39, Mike Dunn wrote:
>>>> fb1bf8cd13bfa7ed0364ab0d82f717fc020d35f6 
>>>> ([ARM] pxa: introduce processor specific pxa27x_assert_ac97reset())
>>>> which changed the mfp to a GPIO input instead of a high output.
>>
>> Looking at this one more time...
>> fb1bf8cd13 ([ARM] pxa: introduce processor specific pxa27x_assert_ac97reset())
>> also removed the call to pxa_gpio_mode() function which effectively set
>> AF to GPIO and configured the GPIO to output high.
>> (Later b1d9bf1d ([ARM] pxa: remove pxa_gpio_mode() and files) removed the
>> pxa_gpio_mode() function)
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

Well, I've made a quick patch for Mike to test if this works and
since it works I will submit a proper one.

To your question about setting the direction,
I'd like us to be on a safe side and not drive the pin if AF is not GPIO.
Although it should not meter and changing the AF to ac97reset should do the job,
but just to be on the safe side, as I think GPDR/GPCR/GPSR settings are preserved
even if you change the AF to something other than GPIO.


-- 
Regards,
Igor.
