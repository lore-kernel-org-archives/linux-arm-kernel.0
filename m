From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 8 Nov 2016 19:03:02 +0000
Subject: KASAN & the vmalloc area
Message-ID: <20161108190302.GH15297@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I see a while back [1] there was a discussion of what to do about KASAN
and vmapped stacks, but it doesn't look like that was solved, judging by
the vmapped stacks pull [2] for v4.9.

I wondered whether anyone had looked at that since?

I have an additional reason to want to dynamically allocate the vmalloc
area shadow: it turns out that KASAN currently interacts rather poorly
with the arm64 ptdump code.

When KASAN is selected, we allocate shadow for the whole vmalloc area,
using common zero pte, pmd, pud tables. Walking over these in the ptdump
code takes a *very* long time (I've seen up to 15 minutes with
KASAN_OUTLINE enabled). For DEBUG_WX [3], this means boot hangs for that
long, too.

If I don't allocate vmalloc shadow (and remove the apparently pointlesss
shadow of the shadow area), and only allocate shadow for the image,
fixmap, vmemmap and so on, that delay gets cut to a few seconds, which
is tolerable for a debug configuration...

... however, things blow up when the kernel touches vmalloc'd memory for
the first time, as we don't install shadow for that dynamically.

Thanks,
Mark.

[1] https://lkml.kernel.org/r/CALCETrWucrYp+yq8RHSDqf93xtg793duByirurzJbLRhrz=tcA at mail.gmail.com
[2] https://lkml.kernel.org/r/20161003092940.GA691 at gmail.com
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-October/464191.html
