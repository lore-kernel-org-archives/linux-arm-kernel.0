From: mpeg.blue@free.fr (Mason)
Date: Wed, 03 Dec 2014 15:20:01 +0100
Subject: Creating 16 MB super-sections for MMIO
In-Reply-To: <20141203103211.GB7373@e104818-lin.cambridge.arm.com>
References: <547D97A5.4090302@free.fr> <547EDD61.5080907@free.fr>
 <20141203103211.GB7373@e104818-lin.cambridge.arm.com>
Message-ID: <547F1C11.5090408@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Catalin,

On 03/12/2014 11:32, Catalin Marinas wrote:

> The reasons behind this proposal aren't clear. Are you trying
> to optimise mmio register accesses by avoiding TLB misses?

I am trying to minimize TLB "pollution" by using a "huge" page.

The ARM manual states: "Support for Supersections, Sections and
Large pages enables a large region of memory to be mapped using
only a single entry in the TLB."

Is it correct that, if I create a virtual-to-physical mapping of
an 8 MB memory region, then, in the best-case scenario, the kernel
will create 8 Sections? Thus my mapping would use up to 8 entries
in the TLB at any given time.

Instead, if I create a V2P mapping of a 16 MB region, and if the
kernel supports so-called Super-sections, then the mapping would
use only a single entry in the TLB. Right?

Thus creating a Super-section leaves more TLB entries available
for user-space processes and kernel threads, which can only
improve system performance, AFAIU.

On my SoC, physical addresses 0 to 2^24 are reserved for device
memory-mapped registers. There are holes in the region (meaning
addresses that don't map to any register) but the bus is defined
in such a way that
- writing to a hole is a NOP,
-reading from a hole returns 0.

So I'd like to map
physical addresses 0-2^24
to
virtual addresses 0xf000_0000 - 0xf100_0000
using a Super-section.

And I was hoping that calling iotable_init with a struct map_desc
entry where length = SZ_16M would create such a super-section.

Did that make sense?

As far as I could tell, Linux does not create a super-section in the
case outlined above. Perhaps I misread the source code?

Regards.
