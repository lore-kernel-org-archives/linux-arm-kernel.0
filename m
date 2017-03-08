From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 8 Mar 2017 11:03:43 -0800
Subject: Creating kernel mappings for memory initially marked with bootmem
 NOMAP?
Message-ID: <c17b0a16-fde5-9254-f84a-418972201eae@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On our platforms (brcmstb) we have an use case where we boot with some
(a lot actually) memory carved out and marked initially with bootmem
NOMAP in order for this memory not to be mapped in the kernel's linear
mapping.

Now, we have some peripherals that want large chunks of physically and
virtually contiguous memory that belong to these memblock NOMAP ranges.
I have no problems using mmap() against this memory, because the kernel
will do what is necessary for a process to map it for me. The struggle
is for a kernel driver which specifies a range of physical memory and
size, and expects a virtually contiguous mapping in return (not using
DMA-API, because reasons).

Essentially the problem is that there are no PTEs created for these
memory regions (and pfn_valid() returns 0, since this is NOMAP memory),
so I have been playing with __add_pages() from the memory hotplug code
in an attempt to get proper page references to this memory, but I am
clearly missing something.

Yes I know it's a terrible idea, but what if I wanted to get that working?

Thanks in advance!
-- 
Florian
