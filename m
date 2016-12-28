From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 28 Dec 2016 12:17:23 -0800
Subject: [PATCH] arm64: errata: Check for --fix-cortex-a53-843419 and
 --fix-cortex-a53
In-Reply-To: <ae71bdc0-23c7-ce0d-7264-930ab7f405ec@gmail.com>
References: <20161031194414.61287-1-code@mmayer.net>
 <20161102210331.GJ22791@arm.com>
 <CAGt4E5tKHNQw=eLzFx-+g6yLwJ=xCTQEqNZHFZu6aOVpKm7X7w@mail.gmail.com>
 <20161102212747.GL22791@arm.com>
 <CAGt4E5sxMcyizwAjwEZd6zepOAyr05WCgtstoRDfNjkNQtnJCA@mail.gmail.com>
 <2d72cbbb-df03-267c-53b0-e3083a746175@gmail.com>
 <20161103141559.GQ22791@arm.com>
 <ae71bdc0-23c7-ce0d-7264-930ab7f405ec@gmail.com>
Message-ID: <c4f5b650-b210-8332-e6f2-4ad9634818b9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2016 10:20 AM, Florian Fainelli wrote:
> On 11/03/2016 07:16 AM, Will Deacon wrote:
>> On Wed, Nov 02, 2016 at 02:57:26PM -0700, Florian Fainelli wrote:
>>> On 11/02/2016 02:41 PM, Markus Mayer wrote:
>>>> On 2 November 2016 at 14:27, Will Deacon <will.deacon@arm.com> wrote:
>>>>> On Wed, Nov 02, 2016 at 02:07:17PM -0700, Markus Mayer wrote:
>>>>>> The question I am asking is: What do we have to lose by supporting both options?
>>>>>
>>>>> We end up passing "--fix-cortex-a53" to the linker, without knowing what it
>>>>> might do in the future.
>>>>
>>>> It seems highly unlikely that such a generic option would be added in
>>>> the future, both, because the precedent has been set for topic
>>>> specific options, and because they know it has been used in the past,
>>>> so they wouldn't add a previously used option to do something
>>>> completely different. (And if they really did, then that would be a
>>>> huge binutils bug.)
>>>>
>>>> So, we have a trade-off between a real world problem that does
>>>> currently exist and avoiding a theoretical issue that may never
>>>> materialize.
>>>
>>> Agreed, also the way Markus' patch is designed makes it such that we
>>> first try the full and current option name, and if not supported, try
>>> the second (and earlier, now obsolete) option name, so I really don't
>>> see a lot of room for things to go wrong here...
>>
>> It's not beyond the realms of possibility that ld will grow a
>> "fix-cortex-a53" option in the future, that enables all of the a53
>> workarounds. Since ld is the linker supported by the kernel and gold isn't,
>> I don't want to pass this option down.
> 
> No it's entirely reasonable to think this may happen, although:
> 
> - this has not happened yet, so once this happens, you will need to cook
> a patch for this anyway, and you will be able to gate this catch all
> linker option by an appropriate version check presumably
> 
> - you would supposedly want a fine grained set of linker options that
> are specific to workarounds you have to have enabled, instead of a catch
> all "enable all Cortex A53" workarounds
> 
>>
>> If you can't change toolchain and you want this worked around, why can't you
>> either build gold with it enabled by default, or pass the extra flag on the
>> command line to the kernel build system?
> 
> Because that creates a distribution problem and now we have to document
> this for people who want to build a kernel on their own, without
> necessarily understanding if this is something they might need, or why
> this is needed, and why the kernel is not taking care of that on its
> own? So yes, this comes down to who is responsible for what, in that
> case the kernel's Makefile is the best place where to put such knowledge
> as to which workaround needs to be enabled by the linker and it
> simplifies things a lot for people.

Was this convincing enough for Catalin to pick Markus' patch or does
that mean this patch needs to remain out of tree for us because of using
a slightly older toolchain?

Thanks
-- 
Florian
