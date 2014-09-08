From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 8 Sep 2014 20:40:23 +0100
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <CAD=FV=VAqzvJQDQMjjeQ1p5okyDzE=ff_sguObZxh59qbzcaTQ@mail.gmail.com>
References: <20140905115704.GO13515@arm.com> <20140905122232.GP13515@arm.com>
 <CAD=FV=VfioJf9VYoSYL0QBk-bN93-Ecx3=0n9hb5Q4rcx43-_g@mail.gmail.com>
 <540C202E.2060009@collabora.co.uk> <540C7F5B.6070307@gmail.com>
 <540C83DE.10505@collabora.co.uk> <540C8577.2070907@gmail.com>
 <20140908112112.GK26030@arm.com>
 <CACxGe6v40wMSW8LJRtyZ3C6PinRMcQM-Zog+XpTJ-QG3HHJknw@mail.gmail.com>
 <CAD=FV=VAqzvJQDQMjjeQ1p5okyDzE=ff_sguObZxh59qbzcaTQ@mail.gmail.com>
Message-ID: <CACxGe6t_ex1bU=CvTpXR4VJgNf1hAq33hr6ykbHy_sMXEk4h-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 8, 2014 at 4:58 PM, Doug Anderson <dianders@chromium.org> wrote:
> Grant,
>
> On Mon, Sep 8, 2014 at 5:20 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Mon, Sep 8, 2014 at 12:21 PM, Will Deacon <will.deacon@arm.com> wrote:
>>> On Sun, Sep 07, 2014 at 05:19:03PM +0100, Tomasz Figa wrote:
>>>> At least for next 3.17-rc I'd suggest fixing this up in respective clock
>>>> driver and dropping the hack only after Exynos DRM patches are merged
>>>> and confirmed working.
>>>
>>> Whilst I'm sympathetic to people working to enable DRM, I think this is
>>> the right solution to the problem. The transition from simplefb to DRM
>>> shouldn't break display for a bunch of kernel revisions whilst the code is
>>> in flux.
>>
>> I would go further. The kernel behaviour has changed, and we have to
>> deal with platforms that assume the old behaviour. That means either
>> defaulting to leaving enabled regulators/clocks alone unless there is
>> a flag in the DT saying they can be power managed, or black listing
>> platforms that are known to depend on the regulator being on.
>>
>> Updating the device tree must not be required to get the kernel to
>> boot, but it is valid to require a DT upgrade to get better
>> performance (battery life) out of the platform.
>
> In this case people using SImple FB are not really using an officially
> sanctioned device tree.  The simple-fb fragment is created on the fly
> via a "DO NOT SUBMIT" patch sitting on a code review server.  It's not
> something that's shipped with real firmware nor is it something
> present in the kernel.  See
> <https://chromium-review.googlesource.com/#/c/49358/2/board/samsung/smdk5250/smdk5250.c>
> as I mentioned above.
>
> Is this really a device tree that we need to guarantee backward
> compatibility with?

Well, lets see... We've got a real user complaining about a platform
that used to work on mainline, and no longer does. The only loophole
for ignoring breakage is if there nobody cares that it is broken. That
currently isn't the case. So even though it's based on a patch that
has "DO NOT SUBMIT" in large friendly letters on the front cover, it
doesn't change the situation that mainline has a regression.

g.
