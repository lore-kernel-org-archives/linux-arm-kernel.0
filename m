From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 5 Jun 2013 12:03:43 +0100
Subject: [RFC PATCH 2/2] ARM: kernel: implement stack pointer save array
 through MPIDR hashing
In-Reply-To: <20130605103820.GC2492@localhost.localdomain>
References: <1370338453-8749-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1370338453-8749-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20130605103820.GC2492@localhost.localdomain>
Message-ID: <20130605110343.GB32505@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 11:38:20AM +0100, Dave Martin wrote:
> On Tue, Jun 04, 2013 at 10:34:13AM +0100, Lorenzo Pieralisi wrote:
> > Current implementation of cpu_{suspend}/cpu_{resume} relies on the MPIDR
> > to index the array of pointers where the context is saved and restored.
> > The current approach works as long as the MPIDR can be considered a
> > linear index, so that the pointers array can simply be dereferenced by
> > using the MPIDR[7:0] value.
> > On ARM multi-cluster systems, where the MPIDR may not be a linear index,
> > to properly dereference the stack pointer array, a mapping function should
> > be applied to it so that it can be used for arrays look-ups.
> > 
> > This patch adds code in the cpu_{suspend}/cpu_{resume} implementation
> > that relies on shifting and ORing hashing method to map a MPIDR value to a
> > set of buckets precomputed at boot to have a collision free mapping from
> > MPIDR to context pointers.
> > 
> > The hashing algorithm must be simple, fast, and implementable with few
> > instructions since in the cpu_resume path the mapping is carried out with
> > the MMU off and the I-cache off, hence code and data are fetched from DRAM
> > with no-caching available. Simplicity is counterbalanced with a little
> > increase of memory (allocated dynamically) for stack pointers buckets, that
> > should be anyway fairly limited on most systems.
> > 
> > Memory for context pointers is allocated in a early_initcall with
> > size precomputed and stashed previously in kernel data structures.
> > Memory for context pointers is allocated through kmalloc; this
> > guarantees contiguous physical addresses for the allocated memory which
> > is fundamental to the correct functioning of the resume mechanism that
> > relies on the context pointer array to be a chunk of contiguous physical
> > memory. Virtual to physical address conversion for the context pointer
> > array base is carried out at boot to avoid fiddling with virt_to_phys
> > conversions in the cpu_resume path which is quite fragile and should be
> > optimized to execute as few instructions as possible.
> > Virtual and physical context pointer base array addresses are stashed in a
> > struct that is accessible from assembly using values generated through the
> > asm-offsets.c mechanism.
> > 
> > Cc: Dave Martin <dave.martin@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Cc: Colin Cross <ccross@android.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Amit Kucheria <amit.kucheria@linaro.org>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Thank you very much Dave,
Lorenzo
