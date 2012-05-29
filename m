From: khilman@ti.com (Kevin Hilman)
Date: Tue, 29 May 2012 13:17:09 -0700
Subject: [PATCHv2 17/19] ARM: OMAP4: put cpu1 back to sleep if no wake
 request
In-Reply-To: <CAMQu2gy0Lwga0gDhT7+iOFM6ZLPnW4Q0qo_r4=cW6L4s5fbLZw@mail.gmail.com>
 (Santosh Shilimkar's message of "Mon, 21 May 2012 16:10:10 +0530")
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-18-git-send-email-t-kristo@ti.com>
 <87396z3axv.fsf@ti.com> <1337595695.28274.32.camel@sokoban>
 <CAMQu2gy0Lwga0gDhT7+iOFM6ZLPnW4Q0qo_r4=cW6L4s5fbLZw@mail.gmail.com>
Message-ID: <87likag2t6.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

> Tero,
>
> On Mon, May 21, 2012 at 3:51 PM, Tero Kristo <t-kristo@ti.com> wrote:
>> On Wed, 2012-05-16 at 17:31 -0700, Kevin Hilman wrote:
>>> Tero Kristo <t-kristo@ti.com> writes:
>>>
>>> > If AUX_CORE_BOOT0 does not indicate wakeup request for cpu1, put it back
>>> > to off.
>>>
>>> Why is it waking up then? ?(I know the answer, but will forget. ?The
>>> changelog serves as my long-term memory.)
>>
>> Will add comment. (Both cpus will wake-up after device-off reset.)
>>
>>>
>>> > This is needed during wakeup from device off to prevent cpu1
>>> > from being stuck indefinitely in the wakeup loop
>>>
>>> Why does it get stuck?
>>
>> Related to the above, if the AUX_CORE_BOOT0 is not set, the code will
>> wait for it indefinitely in busy loop.
>>
>>>
>>> > and also to prevent wakeup problem on GP chips with device off mode.
>>>
>>> What wakeup problem?
>>
>> This is apparently related to the GIC restore issue addressed with patch
>> 3/8 of the core-ret set (workaround for the ROM bug because of CA9 r2pX
>> gic register change), the interrupts get disabled. Maybe Santosh has
>> some comments on this one.
>>>
> Not sure what you mean wakeup issue on GP device.
>
> IIUC, the issue is:
> Wakeup from device OFF, hardware releases the reset for both CPUs,
> This is special case and applicable only for device OFF. The reason
> CPU1 needs to be hold back, because the security SW is affined with
> CPU0 which needs to be up and running for any of the ROM code APIs
> to work. Like setting up SMP bit, AUX control etc. Without CPU0 booted,
> CPU1 won't be able to execute those ROM functions and hence won't be
> able to boot properly.

That's a nice description of the problem.  Please incorporate a summary
like this into the changlog to describe the problem, then describe the
solution.

Thanks,

Kevin


> I think the limitation is applicable to all OMAP4 devices as well as OMAP5
> devices.
