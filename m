From: david@lechnology.com (David Lechner)
Date: Mon, 22 Jan 2018 11:06:18 -0600
Subject: [PATCH] pinctrl: pinctrl-single: Fix pcs_request_gpio() when
 bits_per_mux != 0
In-Reply-To: <CAHp75VdkShHhxL+3PyaPEC2Dyr8aWoEH8CQk+bEJ2WD4i6ojHg@mail.gmail.com>
References: <1516575793-30526-1-git-send-email-david@lechnology.com>
 <CAHp75VdkShHhxL+3PyaPEC2Dyr8aWoEH8CQk+bEJ2WD4i6ojHg@mail.gmail.com>
Message-ID: <d1426fbc-bc82-89cd-d08d-242b16d2c99d@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2018 08:49 AM, Andy Shevchenko wrote:
> On Mon, Jan 22, 2018 at 1:03 AM, David Lechner <david@lechnology.com> wrote:
>> This fixes pcs_request_gpio() in the pinctrl-single driver when
>> bits_per_mux != 0. It appears this was overlooked when the multiple
>> pins per register feature was added.
>>
>> Fixes: 4e7e8017a80e ("pinctrl: pinctrl-single: enhance to configure
>> multiple pins of different modules")
> 
> One line?

One line is more important that wrapping to 75 chars?

> 
>> +                       byte_num = (pcs->bits_per_pin * pin) / BITS_PER_BYTE;
>> +                       offset = (byte_num / mux_bytes) * mux_bytes;
>> +                       pin_shift = pin % (pcs->width / pcs->bits_per_pin) *
>> +                                   pcs->bits_per_pin;
> 
> Sounds like playing around pretty well defined macro and functions,
> e.g. DIV_ROUND_UP(), round_up().
> 

I admit, I just copied existing code (which may be a reason to leave this the
way it is). But, I only see once place to do this:

	offset = round_down(byte_num, mux_bytes);

Did I miss another?
