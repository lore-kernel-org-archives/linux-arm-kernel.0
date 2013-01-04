From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 04 Jan 2013 21:34:08 +0100
Subject: [PATCH v2] ARM: pxa27x: fix ac97 controller warm reset code
In-Reply-To: <50E6AF88.8050800@compulab.co.il> (Igor Grinberg's message of
 "Fri, 04 Jan 2013 12:31:36 +0200")
References: <1357223976-9097-1-git-send-email-mikedunn@newsguy.com>
 <50E67BAD.7070702@compulab.co.il> <50E6AF88.8050800@compulab.co.il>
Message-ID: <87obh4it6n.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Igor Grinberg <grinberg@compulab.co.il> writes:

> On 01/04/13 08:50, Igor Grinberg wrote:
>> On 01/03/13 16:39, Mike Dunn wrote:
>>> fb1bf8cd13bfa7ed0364ab0d82f717fc020d35f6 
>>> ([ARM] pxa: introduce processor specific pxa27x_assert_ac97reset())
>>> which changed the mfp to a GPIO input instead of a high output.
>
> Looking at this one more time...
> fb1bf8cd13 ([ARM] pxa: introduce processor specific pxa27x_assert_ac97reset())
> also removed the call to pxa_gpio_mode() function which effectively set
> AF to GPIO and configured the GPIO to output high.
> (Later b1d9bf1d ([ARM] pxa: remove pxa_gpio_mode() and files) removed the
> pxa_gpio_mode() function)
>
> See below...
> The DRIVE_HIGH does not really configures the GPIO to output high, but
> only sets the MFP_LPM_DRIVE_HIGH bit which in turn is only effective in
> low power modes.
> This means, that by doing the above, you just configure the MFP for GPIO output,
> but do not assign it a value, so it gets driven with some undefined value.
> This is not safe.
>
> Can you please, check if the attached patch below does the job?

This is not the original behaviour before commit
fb1bf8cd13bfa7ed0364ab0d82f717fc020d35f6.

The original behaviour was :
 - on = 1 => set GPIO as output GPIO, set to 1
 - on = 0 => set GPIO to the alternate function ac97reset, driven by PXA2xx AC97
 IP.

If you don't set the alternate function, the GCR register usage for reset is
useless, isn't it ? So why do you set the GPIO as "input" with on == 0 ?

And a question for Mike : when you made your tests, was it you intended
behaviour to never set ac97 alternate function and use direct output GPIO
setting with gpio_set_value(, X) ? Or am I missing something here ?

Cheers.

--
Robert
