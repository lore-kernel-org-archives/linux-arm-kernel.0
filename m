From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Nov 2012 15:09:24 +0000
Subject: [PATCH v4 14/14] KVM: ARM: Handle I/O aborts
In-Reply-To: <20121110154348.2836.45008.stgit@chazy-air>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154348.2836.45008.stgit@chazy-air>
Message-ID: <20121119150924.GF3205@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2012 at 03:43:49PM +0000, Christoffer Dall wrote:
> When the guest accesses I/O memory this will create data abort
> exceptions and they are handled by decoding the HSR information
> (physical address, read/write, length, register) and forwarding reads
> and writes to QEMU which performs the device emulation.
> 
> Certain classes of load/store operations do not support the syndrome
> information provided in the HSR and we therefore must be able to fetch
> the offending instruction from guest memory and decode it manually.
> 
> We only support instruction decoding for valid reasonable MMIO operations
> where trapping them do not provide sufficient information in the HSR (no
> 16-bit Thumb instructions provide register writeback that we care about).
> 
> The following instruction types are NOT supported for MMIO operations
> despite the HSR not containing decode info:
>  - any Load/Store multiple
>  - any load/store exclusive
>  - any load/store dual
>  - anything with the PC as the dest register
> 
> This requires changing the general flow somewhat since new calls to run
> the VCPU must check if there's a pending MMIO load and perform the write
> after userspace has made the data available.
> 
> Rusty Russell fixed a horrible race pointed out by Ben Herrenschmidt:
> (1) Guest complicated mmio instruction traps.
> (2) The hardware doesn't tell us enough, so we need to read the actual
>     instruction which was being exectuted.
> (3) KVM maps the instruction virtual address to a physical address.
> (4) The guest (SMP) swaps out that page, and fills it with something else.
> (5) We read the physical address, but now that's the wrong thing.
> 
> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
> Signed-off-by: Rusty Russell <rusty.russell@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>

This is looking like the right sort of thing now, but I would like to
see an Acked-by from Dave [CC'd] for this patch.

I'll try and hit the vGIC code this week...

Thanks,

Will
