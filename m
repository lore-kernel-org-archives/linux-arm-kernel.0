From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Nov 2017 00:25:12 +0100
Subject: [GIT PULL 2/3] ARM: SoC driver updates for 4.15
In-Reply-To: <CA+55aFyvWnmLzYs+Hb+d=ir9Ww8gLcNn9=Oc=zwKdK=L-nmXZA@mail.gmail.com>
References: <CAK8P3a2Wp6EANLq7JZr=uAReKOhBYrc3VKUA7FpDvq7n3Lc2aQ@mail.gmail.com>
 <CA+55aFyvWnmLzYs+Hb+d=ir9Ww8gLcNn9=Oc=zwKdK=L-nmXZA@mail.gmail.com>
Message-ID: <CAK8P3a3uwqeeg7--UDTWJ33g7YejXp5rtV9OFt=jrt-AzQi13Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 11:29 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Nov 16, 2017 at 2:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> ARM: SoC driver updates for v4.15
>
> No. This is completely broken, and I can't imagine that it has ever
> compiled for *anybody*.
>
>   drivers/soc/renesas/r8a77970-sysc.c:14:10: fatal error:
> dt-bindings/power/r8a77970-sysc.h: No such file or directory
>    #include <dt-bindings/power/r8a77970-sysc.h>
>
> and the compiler is completely right. This branch added that
> r8a77970-sysc.c file, but never added the header file.
>
> And it's not some odd merge mistake of mine: I checked. That error is
> there in the original branch too.
>
> Tssk.

Right, I need to figure out how this could have slipped through. I did
get several "BUILD SUCCESS" mails from the kbuild bot (see
https://pastebin.com/JDw3EKDZ), which claims to have built it
successfully in all configurations, including allmodconfig builds on
arm/arm64 and x86-64. Fengguang, do you remember problems
with false-negatives recently?

I also did my own tests based on the "for-next" branch and looked
at the kernelci results of that branch, but that didn't catch the
mistake as the file in question was added in the third "dt" branch.

The dt-bindings/ files have caused endless problems like this
in the past, and I've been very careful about spotting missing
changes when they happen in my next/dt branch and complained
a lot whenever someone sent me crap that didn't compile because
of that. Now I've fallen into the same trap in the opposite direction,
when the patch was in next/dt but missing in next/drivers.

I have the third branch ready now, you should be able to
merge that right away without pulling this one first as there
are no dependencies.

Regarding this pull request 2/3, would you prefer

a) pulling it after 3/3, thereby getting a bisection problem
    but having contents that are otherwise tested in combination
b) me to do a 'git rebase -i -p' to remove the broken pull
    request from underneath all the others (unfortunately it
    was the second of 19 branches I merged), resulting in
    a tree that builds cleanly without bisection issues, but that
    has a recent rebuild
c) dropping the entire branch until the next merge window?

        Arnd
