From: kamezawa.hiroyu@jp.fujitsu.com (KAMEZAWA Hiroyuki)
Date: Thu, 26 Aug 2010 09:58:57 +0900
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <20100825155814.25c783c7.akpm@linux-foundation.org>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<1282310110.2605.976.camel@laptop>
	<20100825155814.25c783c7.akpm@linux-foundation.org>
Message-ID: <20100826095857.5b821d7f.kamezawa.hiroyu@jp.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Aug 2010 15:58:14 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 20 Aug 2010 15:15:10 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, 2010-08-20 at 11:50 +0200, Michal Nazarewicz wrote:
> > > Hello everyone,
> > > 
> > > The following patchset implements a Contiguous Memory Allocator.  For
> > > those who have not yet stumbled across CMA an excerpt from
> > > documentation:
> > > 
> > >    The Contiguous Memory Allocator (CMA) is a framework, which allows
> > >    setting up a machine-specific configuration for physically-contiguous
> > >    memory management. Memory for devices is then allocated according
> > >    to that configuration.
> > > 
> > >    The main role of the framework is not to allocate memory, but to
> > >    parse and manage memory configurations, as well as to act as an
> > >    in-between between device drivers and pluggable allocators. It is
> > >    thus not tied to any memory allocation method or strategy.
> > > 
> > > For more information please refer to the second patch from the
> > > patchset which contains the documentation.
> > 
> > So the idea is to grab a large chunk of memory at boot time and then
> > later allow some device to use it?
> > 
> > I'd much rather we'd improve the regular page allocator to be smarter
> > about this. We recently added a lot of smarts to it like memory
> > compaction, which allows large gobs of contiguous memory to be freed for
> > things like huge pages.
> > 
> > If you want guarantees you can free stuff, why not add constraints to
> > the page allocation type and only allow MIGRATE_MOVABLE pages inside a
> > certain region, those pages are easily freed/moved aside to satisfy
> > large contiguous allocations.
> 
> That would be good.  Although I expect that the allocation would need
> to be 100% rock-solid reliable, otherwise the end user has a
> non-functioning device.  Could generic core VM provide the required level
> of service?
> 
> Anyway, these patches are going to be hard to merge but not impossible.
> Keep going.  Part of the problem is cultural, really: the consumers of
> this interface are weird dinky little devices which the core MM guys
> tend not to work with a lot, and it adds code which they wouldn't use.
> 
> I agree that having two "contiguous memory allocators" floating about
> on the list is distressing.  Are we really all 100% diligently certain
> that there is no commonality here with Zach's work?
> 
> I agree that Peter's above suggestion would be the best thing to do. 
> Please let's take a look at that without getting into sunk cost
> fallacies with existing code!
> 
> It would help (a lot) if we could get more attention and buyin and
> fedback from the potential clients of this code.  rmk's feedback is
> valuable.  Have we heard from the linux-media people?  What other
> subsystems might use it?  ieee1394 perhaps?  Please help identify
> specific subsystems and I can perhaps help to wake people up.
> 
> And I agree that this code (or one of its alternatives!) would benefit
> from having a core MM person take a close interest.  Any volunteers?
> 
> Please cc me on future emails on this topic?
> 

Hmm, you may not like this..but how about following kind of interface ?

Now, memoyr hotplug supports following operation to free and _isolate_
memory region.
	# echo offline > /sys/devices/system/memory/memoryX/state

Then, a region of memory will be isolated. (This succeeds if there are free
memory.)

Add a new interface.

	% echo offline > /sys/devices/system/memory/memoryX/state
	# extract memory from System RAM and make them invisible from buddy allocator.

	% echo cma > /sys/devices/system/memory/memoryX/state
	# move invisible memory to cma.

Then, a chunk of memory will be moved into contiguous-memory-allocator.

To move "cma" region as usual region,
	# echo offline > /sys/devices/system/memory/memoryX/state
	# echo online > /sys/devices/system/memory/memoryX/state

Maybe "used-for-cma" memory are can be populated via /proc/iomem
As,
	100000000-63fffffff : System RAM
	640000000-800000000 : Contiguous RAM (Used for drivers)
(And you have to skip small memory holes by seeing this file)

Of course, cma guys can keep continue to use their own boot option.
With memory hotplug, kernelcore=xxxM interface can be used for creating
ZONE_MOVABLE. Some complicated work may be needed as

	# echo movable > /sys/devices/system/memory/memoryX/state
	(online pages and move them into ZONE_MOVABLE)

If anyone interested in, I may be able to offer some help.

Thanks,
-Kame
