From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Thu, 26 Aug 2010 06:01:56 +0200
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <20100826124434.6089630d.kamezawa.hiroyu@jp.fujitsu.com>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<1282310110.2605.976.camel@laptop>
	<20100825155814.25c783c7.akpm@linux-foundation.org>
	<20100826095857.5b821d7f.kamezawa.hiroyu@jp.fujitsu.com>
	<op.vh0wektv7p4s8u@localhost>
	<20100826115017.04f6f707.kamezawa.hiroyu@jp.fujitsu.com>
	<20100826124434.6089630d.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <op.vh01hi2m7p4s8u@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> 128MB...too big ? But it's depend on config.

On embedded systems it may be like half of the RAM.  Or a quarter.  So bigger
granularity could be desired on some platforms.

> IBM's ppc guys used 16MB section, and recently, a new interface to shrink
> the number of /sys files are added, maybe usable.
>
> Something good with this approach will be you can create "cma" memory
> before installing driver.

That's how CMA works at the moment.  But if I understand you correctly, what
you are proposing would allow to reserve memory *at* *runtime* long after system
has booted.  This would be a nice feature as well though.

> But yes, complicated and need some works.

> Ah, I need to clarify what I want to say.
>
> With compaction, it's helpful, but you can't get contiguous memory larger
> than MAX_ORDER, I think. To get memory larger than MAX_ORDER on demand,
> memory hot-plug code has almost all necessary things.

I'll try to look at it then.

> BTW, just curious...the memory for cma need not to be saved at
> hibernation ? Or drivers has to write its own hibernation ops by driver suspend
> udev or some ?

Hibernation was not considered as of yet but I think it's device driver's
responsibility more then CMA's especially since it may make little sense to save
some of the buffers -- ie. no need to keep a frame from camera since it'll be
overwritten just after system wakes up from hibernation.  It may also be better
to stop playback and resume it later on rather than trying to save decoder's
state.  Again though, I haven't thought about hibernation as of yet.

-- 
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=./ `o
| Computer Science,  Micha? "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
