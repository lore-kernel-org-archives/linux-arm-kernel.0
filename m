From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 03 Apr 2012 11:48:32 +0300
Subject: [PATCH] ARM: pxa: mfp: Force gpio direction for
 MFP_LPM_KEEP_OUTPUT
In-Reply-To: <1333380867.84262.YahooMailClassic@web29015.mail.ird.yahoo.com>
References: <1333380867.84262.YahooMailClassic@web29015.mail.ird.yahoo.com>
Message-ID: <4F7AB960.1040502@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/12 18:34, Paul Parsons wrote:
> Hello Haojian,
> 
> --- On Mon, 2/4/12, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
>>>>> But since DRIVE_HIGH or
>> DRIVE_LOW currently don't
>>>> prevent that,
>>>>
>>>> Don't prevent what?
>>>
>>> Don't prevent a GPIO input being changed to an output
>> when entering
>>> suspend().
>>>
>> PGSRx register allow for selecting the output state (the
>> driven value)
>> of each GPIO pin when the processor enters and while it is
>> in sleep
>> mode.
>>
>> Each bit of PGSRx register is named as SS (Sleep State of
>> GPIO<n>).
>>
>> SS '0' -- If GPIO is programmed as an output, the pin is
>> driven and held
>> low during the transition to and while in sleep mode.
>>
>> SS '1' -- If GPIO is programmed as an output, the pin is
>> driven and held
>> high during the transition to and while in sleep mode.
>>
>> So pin must be configured to GPIO output first before
>> entering sleep mode.
>>
>> Now the issue comes. If you use the pin as input, why do you
>> need to change
>> it into output mode in run time?
> 
> I cannot think of a reason why you would change an input to an output.

One reason, I can think of is bidirectional pins:
the direction can change several times during runtime, but
peripheral may require the pin to be in some defined state in suspend.

> 
> But the possibility that the direction could be changed from input
> to output has been cited as a reason why KEEP_OUTPUT cannot force
> the gpio direction to output.

Indeed, and that's why your patch is wrong - it does exactly that,
it enables the possibility to change the input to output and drive an
undefined level.

> 
> It is relatively easy to verify that KEEP_OUTPUT does not change the
> direction from input to output, because currently only 2 platforms
> use KEEP_OUTPUT, namely corgi and hx4700.

Again, with your patch it will make the change possible.

> 
> It is less easy to verify that DRIVE_HIGH and DRIVE_LOW do not change
> the direction from input to output, because many more platforms use
> them; a cursory check suggests that up to 16 platforms use them.

DRIVE_HIGH and DRIVE_LOW are used across several _different_ SoCs
and care must be taken while changing something related to them.

The DRIVE_HIGH and DRIVE_LOW in current implementation _can_ change
the inputs to outputs, but IMO it is the board support code
responsibility to verify that the right thing is done.

> 
>>
>>> By the way, there is still the issue of DRIVE_HIGH and
>> DRIVE_LOW
>>> forcing the GPIO direction to output in
>> pxa2xx_mfp_suspend()
>>> *before* the PGSR values take effect. Surely a bug?
>>>
>> It's evil to change pin from input mode to output mode if
>> it's in active mode.

Unless, it is peripheral requirement.

> 
> Agreed.
> 
> So pxa2xx_mfp_suspend() contains a potential bug, unless someone can
> verify that DRIVE_HIGH and DRIVE_LOW never change the direction from
> input to output.

They do, but I don't consider it a bug, but a flexibility.
When you specify DRIVE_HIGH or DRIVE_LOW in the board pin config,
you must know what you are doing and be responsible.


-- 
Regards,
Igor.
