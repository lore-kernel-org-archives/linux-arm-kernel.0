From: olof@lixom.net (Olof Johansson)
Date: Wed, 10 Sep 2014 06:06:46 -0700
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <CACxGe6t_ex1bU=CvTpXR4VJgNf1hAq33hr6ykbHy_sMXEk4h-g@mail.gmail.com>
References: <20140905115704.GO13515@arm.com> <20140905122232.GP13515@arm.com>
 <CAD=FV=VfioJf9VYoSYL0QBk-bN93-Ecx3=0n9hb5Q4rcx43-_g@mail.gmail.com>
 <540C202E.2060009@collabora.co.uk> <540C7F5B.6070307@gmail.com>
 <540C83DE.10505@collabora.co.uk> <540C8577.2070907@gmail.com>
 <20140908112112.GK26030@arm.com>
 <CACxGe6v40wMSW8LJRtyZ3C6PinRMcQM-Zog+XpTJ-QG3HHJknw@mail.gmail.com>
 <CAD=FV=VAqzvJQDQMjjeQ1p5okyDzE=ff_sguObZxh59qbzcaTQ@mail.gmail.com>
 <CACxGe6t_ex1bU=CvTpXR4VJgNf1hAq33hr6ykbHy_sMXEk4h-g@mail.gmail.com>
Message-ID: <CAOesGMipX3MV6sMWLuY=D+bQ6qe8P17YFbTFwZOHPeSc3Pw9Cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Been travelling I'm buried in email, so a bit slow at responding.

On Mon, Sep 8, 2014 at 12:40 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Mon, Sep 8, 2014 at 4:58 PM, Doug Anderson <dianders@chromium.org> wrote:
>> Grant,
>>
>> On Mon, Sep 8, 2014 at 5:20 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>>> On Mon, Sep 8, 2014 at 12:21 PM, Will Deacon <will.deacon@arm.com> wrote:
>>>> On Sun, Sep 07, 2014 at 05:19:03PM +0100, Tomasz Figa wrote:
>>>>> At least for next 3.17-rc I'd suggest fixing this up in respective clock
>>>>> driver and dropping the hack only after Exynos DRM patches are merged
>>>>> and confirmed working.
>>>>
>>>> Whilst I'm sympathetic to people working to enable DRM, I think this is
>>>> the right solution to the problem. The transition from simplefb to DRM
>>>> shouldn't break display for a bunch of kernel revisions whilst the code is
>>>> in flux.
>>>
>>> I would go further. The kernel behaviour has changed, and we have to
>>> deal with platforms that assume the old behaviour. That means either
>>> defaulting to leaving enabled regulators/clocks alone unless there is
>>> a flag in the DT saying they can be power managed, or black listing
>>> platforms that are known to depend on the regulator being on.
>>>
>>> Updating the device tree must not be required to get the kernel to
>>> boot, but it is valid to require a DT upgrade to get better
>>> performance (battery life) out of the platform.
>>
>> In this case people using SImple FB are not really using an officially
>> sanctioned device tree.  The simple-fb fragment is created on the fly
>> via a "DO NOT SUBMIT" patch sitting on a code review server.  It's not
>> something that's shipped with real firmware nor is it something
>> present in the kernel.  See
>> <https://chromium-review.googlesource.com/#/c/49358/2/board/samsung/smdk5250/smdk5250.c>
>> as I mentioned above.
>>
>> Is this really a device tree that we need to guarantee backward
>> compatibility with?
>
> Well, lets see... We've got a real user complaining about a platform
> that used to work on mainline, and no longer does. The only loophole
> for ignoring breakage is if there nobody cares that it is broken. That
> currently isn't the case. So even though it's based on a patch that
> has "DO NOT SUBMIT" in large friendly letters on the front cover, it
> doesn't change the situation that mainline has a regression.

Yeah, I'm with you on this Grant, it doesn't matter what the patch is
labelled as.

For extra added complication, the firmware that is referenced above
isn't what most people use, they use another binary that someone that
I don't even know who it is has built, that boots the kernel in HYP
mode. I expect the ARM guys to be using that version since they make
use of KVM, etc.

One way to deal with this could be to add a quirk at boot time --
looking for the simplefb and if found, modifies the regulators to keep
them on. That'd go in the kernel, not in firmware.

Much better would have been if the DRM changes worked when they
landed, so that the migration form simplefb to drm was invisible to
the user. Or at least, to get them working ASAP since they're still
broken. :(


-Olof
