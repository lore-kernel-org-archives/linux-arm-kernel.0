From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 8 Sep 2014 15:28:31 +0100
Subject: [PATCH] efi/arm64: fix fdt-related memory reservation
In-Reply-To: <1410186065.27715.2.camel@deneb.redhat.com>
References: <1410183102-6969-1-git-send-email-msalter@redhat.com>
 <20140908140609.GI12081@leverpostej>
 <1410186065.27715.2.camel@deneb.redhat.com>
Message-ID: <20140908142831.GK12081@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 03:21:05PM +0100, Mark Salter wrote:
> On Mon, 2014-09-08 at 15:06 +0100, Mark Rutland wrote:
> > Hi Mark,
> > 
> > On Mon, Sep 08, 2014 at 02:31:42PM +0100, Mark Salter wrote:
> > > Commit 86c8b27a01cf:
> > >  "arm64: ignore DT memreserve entries when booting in UEFI mode
> > > 
> > > prevents early_init_fdt_scan_reserved_mem() from being called for
> > > arm64 kernels booting via UEFI. This was done because the kernel
> > > will use the UEFI memory map to determine reserved memory regions.
> > > That approach has problems in that early_init_fdt_scan_reserved_mem()
> > > also reserves the FDT itself and any node-specific reserved memory.
> > > By chance of some kernel configs, the FDT may be overwritten before
> > > it can be unflattened and the kernel will fail to boot. More subtle
> > > problems will result if the FDT has node specific reserved memory
> > > which is not really reserved.
> > 
> > That doesn't sound like fun; apologies for allowing such brokenness
> > through in the first place.
> 
> Heh. It was obvious that DT unflattening was broken, but bisecting
> didn't help much because I kept finding patches which when reverted
> made the problem go away even though they obviously weren't the
> cause.

Yeah, those types of bugs are never fun. I recall a similar situation
with the __INIT annotation in the versatile pen code. 

> > [...]
> > 
> > > +	/*
> > > +	 * Delete all memory reserve map entries. When booting via UEFI,
> > > +	 * kernel will use the UEFI memory map to find reserved regions.
> > > +	 */
> > > +	num_rsv = fdt_num_mem_rsv(fdt);
> > > +	for (i = 0; i < num_rsv; i++)
> > > +		fdt_del_mem_rsv(fdt, i);
> > 
> > I don't think that's right. Won't the memreserve entries shift down by
> > one each time we call fdt_del_mem_rsv?
> > 
> > Shouldn't this be something like:
> > 
> > while (fdt_num_mem_rsv(fdt))
> > 	fdt_del_mem_rsv(fdt, 0);
> > 
> > Or we could count downwards.
> > 
> 
> Sigh. Yes, you are right. I only tested with one reserved region.
> I think counting down would be the way to go. I'll send a fixed
> patch shortly.

Ok, that sounds fine by me; make sure you add my ack :)

Thanks,
Mark.
