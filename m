From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 Mar 2011 10:40:14 +0100
Subject: [PATCH v2] ARM: perf: ensure overflows aren't missed due to IRQ
	latency
In-Reply-To: <4D8D85C4.1080501@free.fr>
References: <1300986442-20461-1-git-send-email-will.deacon@arm.com>
	<4D8D85C4.1080501@free.fr>
Message-ID: <006f01cbedf5$4e9725d0$ebc57170$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi,

Hello Chris,

> Sorry, my first attempt was regarded as suspicious.
> This time I shall try to avoid HTML.

Good idea :)

> A couple of nitpicks in the introduction.
> 
> Le 24/03/2011 18:07, Will Deacon a ?crit :
> > If a counter overflows during a perf stat profiling run it may overtake
> > the last known value of the counter:
> >
> >      0        prev     new                0xffffffff
> >      |----------|-------|----------------------|
> >
> > In this case, the number of events that have occurred is
> > (0xffffffff - prev) + new. Unfortunately, the event update code will
> > not realise an overflow has occurred and will instead report the event
> > delta as (new - prev) which may be considerably smaller than the real
> > count.
> 
> a) "(0xffffffff - prev) + new"
> Surely that should be "(0x100000000 - prev) + new"

This has been merged now, so it's too late to change the commit log.
However, I think this is also a problem in the code in that we're not
counting the event through zero (Jamie - it means my original code *was*
subtly different to yours, but I can't pretend I saw this issue!).

So now we're off by 1 rather than some number bounded by maxuint. At least
we're converging on accuracy...

I'll post a fix.

Will
