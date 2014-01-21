From: olof@lixom.net (Olof Johansson)
Date: Tue, 21 Jan 2014 10:14:49 -0800
Subject: [PATCH 1/3] mmc: add support for power-on sequencing through DT
In-Reply-To: <CAPDyKFpfrs=e3bDvdFRpnD3RkmD8ZvAJgFi6XvCRAOocqAKkKw@mail.gmail.com>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <1390190215-22700-2-git-send-email-olof@lixom.net>
 <CAPDyKFoywt_LcWXdWJCWMU8-GT2vLW27eiuF0WEyjHJV+96HpA@mail.gmail.com>
 <20140120191302.GA32178@quad.lixom.net>
 <CAPDyKFpfrs=e3bDvdFRpnD3RkmD8ZvAJgFi6XvCRAOocqAKkKw@mail.gmail.com>
Message-ID: <CAOesGMi9puZSzdDJ-sur5ks7VcDH+XV_MbuA0xeidLgp=uJacg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 12:55 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
[pruning quotes a bit]
>>> Is the above regulator related to host->ocr_avail mask? Could the
>>> above regulator be replaced by vmmc?
>>
>> I have to admit that I don't know MMC as well as I could, but OCR seems to be
>> something that's between the driver/controller/device, not related to external
>> power control in this case?
>
> This is related to the power of the card, typically external
> regulators controlled by the host driver.
>
> Both the card and the host supports a voltage range. This range is
> exactly what the OCR mask describes. At initialization of the card,
> the host ocr is validated against the card ocr.

Ok, so they specify the voltage needed, but there's no way to
determine what regulator is wired up to control. So that information
is still needed (possibly through vmmc though).


>>> At the moment host drivers uses mmc_regulator_get_supply(), which
>>> fetches regulators called "vmmc" and "vqmmc". It is also common to
>>> have these defined in DT like "vmmc-supply". This has not been
>>> properly documented for most host cases, and we should fix that. I
>>> also think it would make sense to include these in the documentation
>>> for the common mmc bindings, instead of host specific bindings.
>>
>> Hm, I had been of the impression that the vmmc stuff is to control
>> power/voltage on the signal lines, not for external card power. Still, even in
>> that case there's need for the reset line handling and clock control.
>
> vmmc: the power to the card.
> vqmmc: the I/O voltage levels (for the signal lines).

Ah, ok. So vmmc seems like it's the same then. I'll try to get some
cycles to look at it today.


> Regarding reset, I agree, those seems to be needed.
>
> Regarding clock control. I suppose you are referring to separate
> external clocks, not affecting the SDIO/SD/MMC interface speed!?
>
> That could make sense, but still I wonder how those shall be handled
> in a fine grained power management setup. In other words, when shall
> those be gated/ungated? Is the mmc core able to take the correct
> decision about these?

The reference clock is in most cases I've seen 32kHz, and not
something that's under fine-grained power management. So it's not used
to regulate interface speed, etc.


-Olof
