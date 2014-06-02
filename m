From: jays.lee@samsung.com (Jungseok Lee)
Date: Mon, 02 Jun 2014 17:11:39 +0900
Subject: [PATCH v6 6/7] arm64: KVM: Set physical address size related
 factors in runtime
In-Reply-To: <20140527140241.GA13967@lvm>
References: <000501cf6dc6$44fac0f0$cef042d0$@samsung.com>
 <20140527135349.GJ31431@lvm> <20140527140241.GA13967@lvm>
Message-ID: <07fe01cf7e3a$47d4e010$d77ea030$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 27, 2014 11:03 PM, Christoffer Dall wrote:
> On Tue, May 27, 2014 at 03:53:49PM +0200, Christoffer Dall wrote:
> > On Mon, May 12, 2014 at 06:40:54PM +0900, Jungseok Lee wrote:
> > > This patch sets TCR_EL2.PS, VTCR_EL2.T0SZ and vttbr_baddr_mask in runtime,
> > > not compile time.
> > >
> > > In ARMv8, EL2 physical address size (TCR_EL2.PS) and stage2 input address
> > > size (VTCR_EL2.T0SZE) cannot be determined in compile time since they
> > > depends on hardware capability.
> >
> > s/depends/depend/
> >
> > >
> > > According to Table D4-23 and Table D4-25 in ARM DDI 0487A.b document,
> > > vttbr_x is calculated using different hard-coded values with consideration
> >
> > super nit: I guess this is fixed values, and not hard-coded values
> >
> > > of T0SZ, granule size and the level of translation tables. Therefore,
> > > vttbr_baddr_mask should be determined dynamically.
> >
> > so I think there's a deeper issue here, which is that we're not
> > currently considering that for a given supported physical address size
> > (run-time) and given page granularity (compile-time), we may have some
> > flexibility in choosing the VTCR_EL2.SL0 field, and thereby the size of
> > the initial stage2 pgd, by concatinating the initial level page tables.
> >
> > Additionally, the combinations of the givens may also force us to choose
> > a specific SL0 value.
> >
> > Policy-wise, I would say we should concatenate as many initial level page
> > tables as possible when using 4K pages, iow. always set VTCR_EL2.SL0 to
> > the lowest possible value given the PARange and page size config we have
> > at hand.  That should always provide increased performance for VMs at
> > the cost of maximum 16 concatenated tables, which is a 64K contiguous
> > allocation and alignment, for 4K pages.
> >
> > For 64K pages, it becomes a 256K alignment and contiguous allocation
> > requirement.  One could argue that if this is not possible on your
> > system, then you have no business runninng VMs on there, but I want to
> > leave this open for comments...
> >
> Just had a brief chat with Marc, and he made me think of the fact that
> we cannot decide this freely, because the code in kvm_mmu.c assumes that
> the stage-2 page tables have the same number of levels etc. as the host
> kernel (we re-use functions like pud_offset, pud_addr_end, etc. etc.).
> 
> I'm not sure this can always be aligned, so we may have to write our own
> kvm_... versions of these to accomodate the best policy for KVM.

I agree with your opinion in performance and long-term perspective. We
should consider all combinations and re-write code if needed.

However, I'm not sure that this work should be included in this patch series.

If this functionality is needed, it would be good to prepare the work as
a separate patchset and drop off the last 2 KVM patches. Instead, 4 level
features should be marked as EXPERIMENTAL.

- Jungseok Lee
