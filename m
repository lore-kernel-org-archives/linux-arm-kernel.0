From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Fri, 29 Oct 2010 16:58:31 +0200
Subject: [RFC][PATCH 0/3] big chunk memory allocator v2
In-Reply-To: <20101029142741.GB19823@gargoyle.fritz.box>
References: <20101026190042.57f30338.kamezawa.hiroyu@jp.fujitsu.com>
	<AANLkTim4fFXQKqmFCeR8pvi0SZPXpjDqyOkbV6PYJYkR@mail.gmail.com>
	<op.vlbywq137p4s8u@pikus> <20101029103154.GA10823@gargoyle.fritz.box>
	<20101029195900.88559162.kamezawa.hiroyu@jp.fujitsu.com>
	<20101029122928.GA17792@gargoyle.fritz.box> <op.vlb8bda87p4s8u@pikus>
	<20101029142741.GB19823@gargoyle.fritz.box>
Message-ID: <op.vlcejtth7p4s8u@pikus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Oct 2010 16:27:41 +0200, Andi Kleen <andi.kleen@intel.com> wrote:

> On Fri, Oct 29, 2010 at 01:43:51PM +0100, Micha? Nazarewicz wrote:
>> Hmm... true.  Still the point remains that only movable and reclaimable pages are
>> allowed in the marked regions.  This in effect means that from unmovable pages
>> point of view, the area is unusable but I havn't thought of any other way to
>> guarantee that because of fragmentation, long sequence of free/movable/reclaimable
>> pages is available.

> Essentially a movable zone as defined today.

Ah, right, I somehow was under the impresion that movable zone can be used as a fallback
zone.  When I'm finished with my current approach I'll look more closely into it.

> That gets you near all the problems of highmem (except for the mapping
> problem and you're a bit more flexible in the splits):
>
> Someone has to decide at boot how much should be movable
> and what not, some workloads will run out of space, some may
> deadlock when it runs out of management objects, etc.etc.
> Classic highmem had a long string of issues with all of this.

Here's where the rest of CMA comes.  The solution may be not perfect but it's
probably better then nothing.  The idea is to define regions for each device
(with possibility for a single region to be shared) which, hopefuly, can help
with fragmentation.

In the current form, CMA is designed mostly for embeded systems where one can
define what kind of devices will be used, but in general this could be used
for other systems as well.

-- 
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=./ `o
| Computer Science,  Micha? "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
