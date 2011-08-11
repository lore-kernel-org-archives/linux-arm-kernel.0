From: emeric.vigier@stericsson.com (Emeric Vigier)
Date: Thu, 11 Aug 2011 15:08:27 +0000 (UTC)
Subject: Memory hotplug on ARM linux
References: <BANLkTinf5t9zb=6Ha4emMmJZuLeT0t9Acg@mail.gmail.com>
Message-ID: <loom.20110811T165903-324@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dc4 meego <dc4meego <at> gmail.com> writes:

> 
> I'm trying to get memory hotplug working on ARM linux.
> 
> I've enabled the options (ARCH_ENABLE_MEMORY_HOTPLUG,
> ARCH_ENABLE_MEMORY_HOTREMOVE, ARCH_MEMORY_PROBE) and can see the
> memory through the sysfs interface.
> However adding memory results in a "Unable to handle kernel paging
> request", and no memory is removable (e.g. "memory offlining 2000 to
> 2400 failed")

I did the same as you did. I also activated SPARSEMEM and defined
MAX_PHYSMEM_BITS and SECTION_SIZE_BITS in mach/memory.h. I saw two memories but
none were removable. Because I had some hard-defined "pmem=" in the command
line, spread among the two memories. I wanted to activate NUMA over it, but
doing so on ARM is not trivial. I got myself into needing to define a sched
domain for NODES (SD_NODE_INIT) in asm/topology.h... Got stuck and I am
currently investigating Ankita Garg's memory regions implementation on 2.6.35
(backported from 2.6.39). I am not done yet.

> 
> I'm guessing I need either start with all memory present, but some
> initialised as ZONE_MOVABLE, so I can later offline it.
> Or start with some memory missing, but add something to the
> arch_add_memory to make the memory available after onlining.
> 
> (the reason for doing this is to share SDRAM between the ARM and a
> DSP, and to change the allocation whilst running)
> 
> Anyone had this working on an ARM?
> 

I made t
