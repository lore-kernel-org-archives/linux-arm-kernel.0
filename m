From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 30 Oct 2015 16:54:13 +0000
Subject: [PATCH 08/16] arm64/kexec: Add core kexec support
In-Reply-To: <56339ACD.7010506@arm.com>
References: <cover.1445297709.git.geoff@infradead.org>
 <a1c2a702f127d9dade1f9af8ab13decb2ef1c0da.1445297709.git.geoff@infradead.org>
 <56339ACD.7010506@arm.com>
Message-ID: <20151030165413.GH31073@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> If I've followed all this through properly:
> 
> With KVM - mmu+caches are configured, but then disabled by 'kvm: allows kvm
> cpu hotplug'. This 'arm64_relocate_new_kernel' function then runs at EL2
> with M=0, C=0, I=0.
> 
> Without KVM - when there is no user of EL2, the mmu+caches are left in
> whatever state the bootloader (or efi stub) left them in. From
> Documentation/arm64/booting.txt:
> > Instruction cache may be on or off.
> and
> > System caches which respect the architected cache maintenance by VA
> > operations must be configured and may be enabled.
> 
> So 'arm64_relocate_new_kernel' function could run at EL2 with M=0, C=?, I=?.
> 
> I think this means you can't guarantee anything you are copying below
> actually makes it through the caches - booting secondary processors may get
> stale values.
> 
> The EFI stub disables the M and C bits when booted at EL2 with uefi - but
> it leaves the instruction cache enabled. You only clean the
> reboot_code_buffer from the data cache, so there may be stale values in the
> instruction cache.
> 
> I think you need to disable the i-cache at EL1. If you jump to EL2, I think
> you need to disable the I/C bits there too - as you can't rely on the code
> in 'kvm: allows kvm cpu hotplug' to do this in a non-kvm case.

The SCTLR_ELx.I only affects the attributes that the I-cache uses to
fetch with, not whether it is enabled (it cannot be disabled
architecturally).

It's not necessary to clear the I bit so long as the appropriate
maintenance has occurred, though I believe that when the I bit is set
instruction fetches may allocte in unified levels of cache, so
additional consideration is required for that case.

> > +	/* Copy page. */
> > +1:	ldp	x22, x23, [x21]
> > +	ldp	x24, x25, [x21, #16]
> > +	ldp	x26, x27, [x21, #32]
> > +	ldp	x28, x29, [x21, #48]
> > +	add	x21, x21, #64
> > +	stnp	x22, x23, [x20]
> > +	stnp	x24, x25, [x20, #16]
> > +	stnp	x26, x27, [x20, #32]
> > +	stnp	x28, x29, [x20, #48]
> > +	add	x20, x20, #64
> > +	tst	x21, #(PAGE_SIZE - 1)
> > +	b.ne	1b
> > +
> > +	/* dest += PAGE_SIZE */
> > +	add	x14, x14, PAGE_SIZE
> > +	b	.Lnext
> > +
> > +.Ltest_indirection:
> > +	tbz	x18, IND_INDIRECTION_BIT, .Ltest_destination
> > +
> > +	/* ptr = addr */
> > +	mov	x15, x13
> > +	b	.Lnext
> > +
> > +.Ltest_destination:
> > +	tbz	x18, IND_DESTINATION_BIT, .Lnext
> > +
> > +	mov	x16, x13
> > +
> > +	/* dest = addr */
> > +	mov	x14, x13
> > +
> > +.Lnext:
> > +	/* entry = *ptr++ */
> > +	ldr	x18, [x15], #8
> > +
> > +	/* while (!(entry & DONE)) */
> > +	tbz	x18, IND_DONE_BIT, .Lloop
> > +
> > +.Ldone:
> > +	dsb	sy
> > +	isb
> > +	ic	ialluis
> > +	dsb	sy
> 
> Why the second dsb?
> 
> 
> > +	isb

The first DSB ensures that the copied data is observable by the
I-caches.

The first ISB is unnecessary.

The second DSB ensures that the I-cache maintenance is completed.

The second ISB ensures that the I-cache maintenance is complete w.r.t.
the current instruction stream. There could be instructions in the
pipline fetched from the I-cache prior to invalidation which need to be
cleared.

Thanks,
Mark.
