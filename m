From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 05 Nov 2014 21:32:37 +0100
Subject: [PATCH 01/15] mfd: add new driver for Sharp LoCoMo
In-Reply-To: <CALT56yM8B3ffYb0=EZVbRRGDZSxMci2sRp9XVtjQuLa5abN+cg@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>	<1414454528-24240-2-git-send-email-dbaryshkov@gmail.com>	<CACRpkdbW3NA00zMZr216ZeZpgVkXwKUo30biTVd5kcHKGGtkHg@mail.gmail.com>	<CALT56yNX8v4mZn=o1ZoVLHPmg6wq0dgFNowpqNuFtU=eCc+d8w@mail.gmail.com>	<CACRpkdaKUZjbSEH75M9xudTF9HefwOCVEe5otv9-9f2UG8=hVg@mail.gmail.com>
 <CALT56yM8B3ffYb0=EZVbRRGDZSxMci2sRp9XVtjQuLa5abN+cg@mail.gmail.com>
Message-ID: <545A8965.2010406@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2014 09:02 PM, Dmitry Eremin-Solenikov wrote:
> 2014-11-03 16:41 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
>> On Fri, Oct 31, 2014 at 10:54 AM, Dmitry Eremin-Solenikov
>> <dbaryshkov@gmail.com> wrote:
>>> 2014-10-31 10:42 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
>>
>>>> It seems some DAC handling is part of the MFD driver, and we recently
>>>> discussed that MFD should not be doing misc stuff but mainly act as
>>>> arbiter and switching station.
>>>>
>>>> Can you please move the DAC parts of the driver to
>>>> drivers/iio/dac?
>>>>
>>>> The IIO DAC subsystem will likely add other goodies to
>>>> the driver for free and give a nice API to consumers.
>>>
>>> I wanted this part to be as simple as possible. I will look into IIO
>>> DAC subsystem.
>>> The DAC is as simple 2 channel 8-bit i2c device connected to a separate i2c bus
>>> controlled through a register in LoCoMo device. One channel is used
>>> for backlight,
>>> other will be used for volume control. So (in theory) I can add the
>>> following device
>>> chain:  locomo -> i2c-locomo -> m62332 -> IIO DAC client.  However isn't that
>>> quite an overkill for just backlight & volume control? Please advice me on this.
>>
>> The point is still the same: no unrelated code in drivers/mfd,
>> then either use IIO DAC as a middle layer or sink the DAC handling
>> into respective subdriver, i.e. push it into the backlight or
>> volume directly then.
>
> The problem is that the DAC is equally used by backlight and by sound
> device (WIP).

That shouldn't be a problem. The IIO API allows different consumers to 
request different channels of a converter. You can write a generic IIO based 
backlight driver and a generic IIO based volume control driver. This makes 
it possible to re-use them in other circuits with other DACs but the same 
application.

> What about true i2c device driver sitting in drivers/misc and exporting a regmap
> of 2 8-bit registers?

If it is a generic DAC it should go into drivers/iio/, this will allow code 
sharing and code re-usability. Given the simplicity of the DAC there might 
even be other existing drivers that can be used to control it.

- Lars
