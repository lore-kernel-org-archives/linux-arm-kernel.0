From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 20 Aug 2010 15:15:10 +0200
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <cover.1282286941.git.m.nazarewicz@samsung.com>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
Message-ID: <1282310110.2605.976.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-08-20 at 11:50 +0200, Michal Nazarewicz wrote:
> Hello everyone,
> 
> The following patchset implements a Contiguous Memory Allocator.  For
> those who have not yet stumbled across CMA an excerpt from
> documentation:
> 
>    The Contiguous Memory Allocator (CMA) is a framework, which allows
>    setting up a machine-specific configuration for physically-contiguous
>    memory management. Memory for devices is then allocated according
>    to that configuration.
> 
>    The main role of the framework is not to allocate memory, but to
>    parse and manage memory configurations, as well as to act as an
>    in-between between device drivers and pluggable allocators. It is
>    thus not tied to any memory allocation method or strategy.
> 
> For more information please refer to the second patch from the
> patchset which contains the documentation.

So the idea is to grab a large chunk of memory at boot time and then
later allow some device to use it?

I'd much rather we'd improve the regular page allocator to be smarter
about this. We recently added a lot of smarts to it like memory
compaction, which allows large gobs of contiguous memory to be freed for
things like huge pages.

If you want guarantees you can free stuff, why not add constraints to
the page allocation type and only allow MIGRATE_MOVABLE pages inside a
certain region, those pages are easily freed/moved aside to satisfy
large contiguous allocations.

Also, please remove --chain-reply-to from your git config. You're using
1.7 which should do the right thing (--no-chain-reply-to) by default.
