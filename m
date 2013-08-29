From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 29 Aug 2013 08:17:57 -0700
Subject: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
In-Reply-To: <CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
 (Russ Dill's message of "Tue, 27 Aug 2013 18:05:34 -0700")
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
 <1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
 <CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
 <87txiasqhk.fsf@linaro.org>
 <CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
Message-ID: <87ppsw7cgq.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russ Dill <Russ.Dill@ti.com> writes:

> On Tue, Aug 27, 2013 at 3:44 PM, Kevin Hilman <khilman@linaro.org> wrote:
>> [+Mark Brown for regulator suspend sequence ideas]
>>
>> Russ Dill <Russ.Dill@ti.com> writes:
>>
>>> On Wed, Aug 14, 2013 at 6:38 AM, Jan L?bbe <jlu@pengutronix.de> wrote:
>>>> On Tue, 2013-08-13 at 15:20 -0700, Russ Dill wrote:
> [snip]
>>>> Shouldn't the TPS driver know how to generate this sequence? It seems
>>>> fragile to do voltage adjustments behind the back of the regulator
>>>> framework and the TPS driver. The wake-sequence values should match the
>>>> (in-memory) regulator configuration on resume (which may have been
>>>> changed by DVFS).
>>>
>>> The sequence is both PMIC specific and board specific. Additionally,
>>> the PMICs used aren't am335x specific. It would be nice to have the
>>> regulator framework and the driver write all this out, but the
>>> sequence is written out by the Cortex-M3 processor running some PM
>>> firmware. Even if the code was changed to run on the A8, it'd have to
>>> run from a small piece of SRAM.
>>
>> So, why/how was the decision made to use the M3 instead of the MPU
>> running from SRAM?
>>
>> As a firmware minimalist, I obviously prefer to do this from the MPU
>> side.  But also, because the M3 is reset every suspend sequence, this
>> becomes rather heavy to do from the M3.
>
> After the feedback Vaibhav Bedia received on v2 of his suspend/resume
> patchset for am335x, he decided to move many of the operations from
> sleep33xx.S into the M3 firmware.
>
> See the commit message here:
> http://arago-project.org/git/projects/?p=am33x-cm3.git;a=commit;h=a972ce2f6

Was this feedback on the public lists?  That patch has never been posted
to linux-omap AFAICT.

> I need to wait until after the PLLs are put into bypass, which is now
> done in the M3 firmware. It also ends up being a lot easier to write
> the I2C writer code there in C rather than in assembly in sleep33xx.S.

hmm, (carefully) written functions in C can still be copied to SRAM.  I
dont' see that as an obstacle.

>> Currently voltage scaling is only being proposed for suspend in this
>> series, but in theory it's possible from idle as well.  Doing this from
>> the MPU/SRAM seems much better suited for idle.
>
> The M3 firmware will also handle any cpuidle modes deeper than just
> putting SDRAM into self refresh. This is actually the only way of
> doing things like turning the MPU domain off on am335x.

Yes, it will have to handle the MPU/interconnect off parts but other
than that, that's the only thing it *has* to do (well, and handle wakeup
from the deep state.)  The rest of the stuff being piled into the M3 is
a result of software/firmware design decisions AFAICT.  As I predicted
when I first saw this SoC design, the firmware is getting bigger and
bigger.  Initially it was argued that it would be tiny, and only handle
the things it had to do.  Now it's growing due to "convenience".  IMO,
this is a bad trend, and one that will make this code more and more
difficult to maintain upstream (assuming that's a goal.)

Kevin
