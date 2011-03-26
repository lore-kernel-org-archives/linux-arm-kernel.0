From: moore@free.fr (Chris Moore)
Date: Sat, 26 Mar 2011 07:20:52 +0100
Subject: [PATCH v2] ARM: perf: ensure overflows aren't missed due to IRQ
	latency
In-Reply-To: <1300986442-20461-1-git-send-email-will.deacon@arm.com>
References: <1300986442-20461-1-git-send-email-will.deacon@arm.com>
Message-ID: <4D8D85C4.1080501@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry, my first attempt was regarded as suspicious.
This time I shall try to avoid HTML.

A couple of nitpicks in the introduction.

Le 24/03/2011 18:07, Will Deacon a ?crit :
> If a counter overflows during a perf stat profiling run it may overtake
> the last known value of the counter:
>
>      0        prev     new                0xffffffff
>      |----------|-------|----------------------|
>
> In this case, the number of events that have occurred is
> (0xffffffff - prev) + new. Unfortunately, the event update code will
> not realise an overflow has occurred and will instead report the event
> delta as (new - prev) which may be considerably smaller than the real
> count.

a) "(0xffffffff - prev) + new"
Surely that should be "(0x100000000 - prev) + new"

b) "may be considerably smaller"
I suggest either:
"will be 0x100000000 smaller (per overflow)"
or at least:
"will be considerably smaller"

That said, something like 2^32 would be more easily readable than 0x100000000.

Cheers,
Chris
