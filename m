From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 14 May 2014 18:04:56 +0100
Subject: [RFC PATCHv1 0/7] ARM core support for hardware I/O coherency in
 non-SMP platforms
In-Reply-To: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140514170456.GC15946@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 04:50:34PM +0100, Thomas Petazzoni wrote:
> This hardware I/O coherency mechanism needs a set of ARM core
> requirements to operate properly:
> 
>  * On Armada 370 (a single core processor)
> 
>    - The cache policy of pages must be set to "write allocate".

Arguably, I would make this the default for ARMv6+ CPUs even if UP. It's
a hint that the CPU may or may not ignore but it shouldn't break
anything (well, maybe some artificial benchmarks designed to show
that write-allocate caches are bad).

[...]

>  * On Armada 375/38x (which have single core and dual core variants)
> 
>    - The cache policy of pages must be set to "write allocate".
>    - The SMP and TLB broadcast bits must be set in the Auxiliary
>      Control Register (the core is a Cortex-A9)

What about setting this bit in the firmware/bootloader? It's a sane
initialisation firmware should do.

>    - The pages must be set as shareable.

Here you may have some conflict between the initial page tables set in
__create_page_tables as non-shareable (that's unless MPIDR shows it as
SMP but I guess not since smp-on-up kicks in). I have to think a bit
more about the implications (the ARM ARM has a chapter on mismatched
memory attributes and I think it talks about shareable vs
non-shareable).

>    - The SCU must be enabled

Again, could the firmware do this?

-- 
Catalin
