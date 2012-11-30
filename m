From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 30 Nov 2012 14:46:36 +0000
Subject: [PATCH v4 14/14] KVM: ARM: Handle I/O aborts
In-Reply-To: <20121119150924.GF3205@mudshark.cambridge.arm.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154348.2836.45008.stgit@chazy-air>
 <20121119150924.GF3205@mudshark.cambridge.arm.com>
Message-ID: <20121130144636.GB1960@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 03:09:24PM +0000, Will Deacon wrote:
> On Sat, Nov 10, 2012 at 03:43:49PM +0000, Christoffer Dall wrote:
> > When the guest accesses I/O memory this will create data abort
> > exceptions and they are handled by decoding the HSR information
> > (physical address, read/write, length, register) and forwarding reads
> > and writes to QEMU which performs the device emulation.
> > 
> > Certain classes of load/store operations do not support the syndrome
> > information provided in the HSR and we therefore must be able to fetch
> > the offending instruction from guest memory and decode it manually.
> > 
> > We only support instruction decoding for valid reasonable MMIO operations
> > where trapping them do not provide sufficient information in the HSR (no
> > 16-bit Thumb instructions provide register writeback that we care about).
> > 
> > The following instruction types are NOT supported for MMIO operations
> > despite the HSR not containing decode info:
> >  - any Load/Store multiple
> >  - any load/store exclusive
> >  - any load/store dual
> >  - anything with the PC as the dest register
> > 
> > This requires changing the general flow somewhat since new calls to run
> > the VCPU must check if there's a pending MMIO load and perform the write
> > after userspace has made the data available.
> > 
> > Rusty Russell fixed a horrible race pointed out by Ben Herrenschmidt:
> > (1) Guest complicated mmio instruction traps.
> > (2) The hardware doesn't tell us enough, so we need to read the actual
> >     instruction which was being exectuted.
> > (3) KVM maps the instruction virtual address to a physical address.
> > (4) The guest (SMP) swaps out that page, and fills it with something else.
> > (5) We read the physical address, but now that's the wrong thing.
> > 
> > Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
> > Signed-off-by: Rusty Russell <rusty.russell@linaro.org>
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> 
> This is looking like the right sort of thing now, but I would like to
> see an Acked-by from Dave [CC'd] for this patch.

Apologies for not looking at this until now -- it looks like my mutt
filter was buggy, causing me to miss a few mails.


I haven't reviewed the code in depth, but it looks like a reasonable
and fairly clean subsystem-specific decoder implementation.

This still is not generic, and looks a bit too specialised to lead
directly to a generic implementation which could be reused by other
subsystems.  But I think it is a step in the right direction in terms of
the general way the code works.  If a future generic decode
implementation does not reuse this code, it should still be able to
reuse ideas from it.

The amount of decode here is not that huge, so if KVM needs it, I'm not
sure if it is worth blocking this patch just because it's not generic.

I still feel we are going to want to consolidate this decode stuff at
some point, though.

Cheers
---Dave
