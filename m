From: mpe@ellerman.id.au (Michael Ellerman)
Date: Sat, 10 Sep 2016 20:27:18 +1000
Subject: [PATCH 1/2] perf_event: remove unused DEBUG_PERF_USE_VMALLOC
In-Reply-To: <20160830140834.6d1edf7abd9d95c02dae7820@arm.com>
References: <20160830140834.6d1edf7abd9d95c02dae7820@arm.com>
Message-ID: <87lgz0nj7d.fsf@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kim Phillips <kim.phillips@arm.com> writes:

> This 'DEBUG'-prefixed version of PERF_USE_VMALLOC is not used anywhere.
> It appears to be leftovers from commit 906010b "perf_event: Provide
> vmalloc() based mmap() backing" that introduced it.
>
> Not sure what commit cb30711 "perf_event: Don't allow vmalloc() backed
> perf on powerpc" was trying to do with it either.

Preventing its use on powerpc, because it doesn't work, I thought the
change log was pretty clear:

    perf_event: Don't allow vmalloc() backed perf on powerpc
    
    On powerpc the perf event interrupt is not masked when interrupts are
    disabled, allowing it to function as an NMI.
    
    This causes problems if perf is using vmalloc. If we take a page fault
    on the vmalloc region the fault handler will fail the page fault because
    it detects we are coming in from an NMI (see do_hash_page()).
    
    We don't actually need or want vmalloc backed perf so just disable it on
    powerpc.


If there are ARM cpus that don't want it enabled then you should
probably do a similar patch for ARM.

cheers
