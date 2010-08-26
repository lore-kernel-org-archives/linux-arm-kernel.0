From: kamezawa.hiroyu@jp.fujitsu.com (KAMEZAWA Hiroyuki)
Date: Thu, 26 Aug 2010 11:50:17 +0900
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <op.vh0wektv7p4s8u@localhost>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<1282310110.2605.976.camel@laptop>
	<20100825155814.25c783c7.akpm@linux-foundation.org>
	<20100826095857.5b821d7f.kamezawa.hiroyu@jp.fujitsu.com>
	<op.vh0wektv7p4s8u@localhost>
Message-ID: <20100826115017.04f6f707.kamezawa.hiroyu@jp.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Aug 2010 04:12:10 +0200
Micha? Nazarewicz <m.nazarewicz@samsung.com> wrote:

> On Thu, 26 Aug 2010 02:58:57 +0200, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> > Hmm, you may not like this..but how about following kind of interface ?
> >
> > Now, memoyr hotplug supports following operation to free and _isolate_
> > memory region.
> > 	# echo offline > /sys/devices/system/memory/memoryX/state
> >
> > Then, a region of memory will be isolated. (This succeeds if there are free
> > memory.)
> >
> > Add a new interface.
> >
> > 	% echo offline > /sys/devices/system/memory/memoryX/state
> > 	# extract memory from System RAM and make them invisible from buddy allocator.
> >
> > 	% echo cma > /sys/devices/system/memory/memoryX/state
> > 	# move invisible memory to cma.
> 
> At this point I need to say that I have no experience with hotplug memory but
> I think that for this to make sense the regions of memory would have to be
> smaller.  Unless I'm misunderstanding something, the above would convert
> a region of sizes in order of GiBs to use for CMA.
> 

Now, x86's section size is 
==
#ifdef CONFIG_X86_32
# ifdef CONFIG_X86_PAE
#  define SECTION_SIZE_BITS     29
#  define MAX_PHYSADDR_BITS     36
#  define MAX_PHYSMEM_BITS      36
# else
#  define SECTION_SIZE_BITS     26
#  define MAX_PHYSADDR_BITS     32
#  define MAX_PHYSMEM_BITS      32
# endif
#else /* CONFIG_X86_32 */
# define SECTION_SIZE_BITS      27 /* matt - 128 is convenient right now */
# define MAX_PHYSADDR_BITS      44
# define MAX_PHYSMEM_BITS       46
#endif
==

128MB...too big ? But it's depend on config.

IBM's ppc guys used 16MB section, and recently, a new interface to shrink
the number of /sys files are added, maybe usable.

Something good with this approach will be you can create "cma" memory
before installing driver.

But yes, complicated and need some works.

Bye,
-Kame
