From: lbassel@quicinc.com (Larry Bassel)
Date: Fri, 9 Oct 2009 16:02:36 -0700
Subject: memory hotplug and hotremove on ARM
Message-ID: <20091009230236.GS10587@labbmf-linux.quicinc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have been working on porting memory hotplug and memory hotremove
(which as far as I can tell has not yet been ported to ARM)
to our ARM-based hardware.

I have enabled all of the appropriate configuration
options and written an ARM version of arch_add_memory.

Our hardware contains specific memory that we can power on and off
which is the memory that we want to hotplug and hotremove.
We want to start with all of the memory on and eventually hotremove
it (and later hotplug it back in, etc.). In order to hotremove
this memory section any used pages in it must be migrated out 
of it using page migration. If page migration fails, we will not
be able to turn off the memory.

Thus we need a way of distinguishing this memory at boot time
from the memory that we will not hotplug/hotremove so that
it can be marked as "movable" (so that later migration from it
will succeed). This requires it to be initially added to
ZONE_MOVABLE, not ZONE_NORMAL.

In order to do this, I've had to change a few things:
1. Add a new tag type to represent movable memory (and the associated
command line equivalent).
2. Pass this through to where the zone data structures are built
(arm_add_memory has a new parameter representing the zone the 
memory should be added to and struct membank has a corresponding new
member).
3. Remove the compile time check in arch/arm/include/asm/memory.h for
CONFIG_ZONE_DMA existing -- we have a second zone here but it isn't DMA
-- so that I can adjust the zones using the memory bank list inside
of a platform specific version of arch_adjust_zones.

Alternatively I could rewrite the bootmem related code in arch/arm/mm/init.c
to take zones into account as the membanks in each node are processed, but this
seems like a larger and riskier change that might break other ARM platforms.

I'd like any feedback people have on how I'm approaching this and
if there are any alternate approaches I should consider.

Thanks.

Larry Bassel
