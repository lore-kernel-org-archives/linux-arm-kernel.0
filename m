From: olof@lixom.net (Olof Johansson)
Date: Wed, 27 Aug 2014 19:58:53 -0700
Subject: [PATCH] clocksource: arch_timer: Fix code to use physical timers
 when requested
In-Reply-To: <53FE7E3B.1010500@codeaurora.org>
References: <1409173419-13076-1-git-send-email-sonnyrao@chromium.org>
 <CAOesGMjK65Rc-K0fyFUUJLw6huLT82E-nqJwZO4PqhgopF96Ow@mail.gmail.com>
 <CAPz6YkWAPtuy4sAuAK9GtpDgfGsccxeS+pqqe_t_R818Jt01qA@mail.gmail.com>
 <53FE5B09.2020403@codeaurora.org>
 <CAOesGMhTivDzJFuxONggcJ6N5UvZopKa=+tv9PoPX593cpnm0A@mail.gmail.com>
 <53FE7E3B.1010500@codeaurora.org>
Message-ID: <CAOesGMgXnsqttHwAxEW4a7-Rx-nmSwpJd_Dt1iCcFOvzDwbzdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 5:56 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 08/27/14 15:33, Olof Johansson wrote:
>> On Wed, Aug 27, 2014 at 3:26 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>>
>>> Is there any reason why the virtual counter can't be read? Maybe we're
>>> the hyp and we need to make sure we don't use the virtual timer so that
>>> the guest can use it, but that doesn't have any effect on the usage of
>>> the virtual counter for the clocksource.
>> There are several cases where virtual is unusable -- in particular it
>> might not have been configured properly (i.e. the phys/virt offset is
>> at a bad value).
>>
>
> Any specifics? It would be nice to say so in the commit text so that
> others using such devices know they need this patch. I'm guessing the
> firmware can't be fixed?

Yeah, there are a few. The big.LITTLE on the Chromebook 2 models have
this issue, due to the A7 cluster having an incorrect offset
programmed. However, arch timers aren't supported on that SoC in the
first place, so it's not a problem in reality.

The other known platform is rk3288. It has products out in the wild
where firmware updates are unlikely.

Essentially, I expect many vendors who use BSP kernels by default to
have firmware that forgets to setup the offset, since hardware doesn't
come up with a default one, and their older BSP kernels doesn't access
the virtual one.

> In this particular case is there actually a virtual interrupt but we've
> explicitly removed it from the DT so that the driver can be forced into
> using the physical counter? Or are we getting saved by the hyp check?

The SoC has the virtual timer, and if it has firmware that supports it
there's a good reason to still have it there. After all, DT describes
hardware.

I have a patch I should post that adds a property to make the driver
pick the physical timer instead, since right now it'll always use
virtual if it's available. I'll try to get that posted later tonight.


-Olof
