From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 17 Nov 2017 10:31:47 +0100
Subject: [GIT PULL 2/3] ARM: SoC driver updates for 4.15
In-Reply-To: <CAK8P3a3uwqeeg7--UDTWJ33g7YejXp5rtV9OFt=jrt-AzQi13Q@mail.gmail.com>
References: <CAK8P3a2Wp6EANLq7JZr=uAReKOhBYrc3VKUA7FpDvq7n3Lc2aQ@mail.gmail.com>
 <CA+55aFyvWnmLzYs+Hb+d=ir9Ww8gLcNn9=Oc=zwKdK=L-nmXZA@mail.gmail.com>
 <CAK8P3a3uwqeeg7--UDTWJ33g7YejXp5rtV9OFt=jrt-AzQi13Q@mail.gmail.com>
Message-ID: <CAMuHMdWLOxke=gu4KsWxoUD_d+nwNJXyjvO_3ZShPO3M3iOiuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Linus,

On Fri, Nov 17, 2017 at 12:25 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Nov 16, 2017 at 11:29 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Thu, Nov 16, 2017 at 2:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>
>>> ARM: SoC driver updates for v4.15
>>
>> No. This is completely broken, and I can't imagine that it has ever
>> compiled for *anybody*.
>>
>>   drivers/soc/renesas/r8a77970-sysc.c:14:10: fatal error:
>> dt-bindings/power/r8a77970-sysc.h: No such file or directory
>>    #include <dt-bindings/power/r8a77970-sysc.h>
>>
>> and the compiler is completely right. This branch added that
>> r8a77970-sysc.c file, but never added the header file.
>>
>> And it's not some odd merge mistake of mine: I checked. That error is
>> there in the original branch too.
>>
>> Tssk.
>
> Right, I need to figure out how this could have slipped through. I did
> get several "BUILD SUCCESS" mails from the kbuild bot (see
> https://pastebin.com/JDw3EKDZ), which claims to have built it
> successfully in all configurations, including allmodconfig builds on
> arm/arm64 and x86-64. Fengguang, do you remember problems
> with false-negatives recently?
>
> I also did my own tests based on the "for-next" branch and looked
> at the kernelci results of that branch, but that didn't catch the
> mistake as the file in question was added in the third "dt" branch.
>
> The dt-bindings/ files have caused endless problems like this
> in the past, and I've been very careful about spotting missing
> changes when they happen in my next/dt branch and complained
> a lot whenever someone sent me crap that didn't compile because
> of that. Now I've fallen into the same trap in the opposite direction,
> when the patch was in next/dt but missing in next/drivers.

What happened is that Simon queued up the header file in his
dt-bindings branch, without noticing it was needed by his drivers branch.

The dt-bindings header files are sometimes needed by both the drivers
and dt branches, while policy requests they are in their own branch.
For the dt branch, the current trend is to break the dependency by hardcoding
the numbers in the DTS files initially, and replacing them by defines during
the next merge window.
For the drivers branch, it looks like dt-bindings/power/r8a779*-sysc.h header
files were just queued up in the drivers branch previously, together with the
drivers, avoiding the issue, but breaking the policy...

Sorry for the mess. We'll be more careful.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
