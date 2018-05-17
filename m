From: bp@alien8.de (Borislav Petkov)
Date: Thu, 17 May 2018 15:36:53 +0200
Subject: [PATCH v3 07/12] ACPI / APEI: Make the nmi_fixmap_idx per-ghes
 to allow multiple in_nmi() users
In-Reply-To: <7c871e15-689c-226d-760d-dd92614de2e9@arm.com>
References: <20180427153510.5799-1-james.morse@arm.com>
 <20180427153510.5799-8-james.morse@arm.com>
 <20180505122719.GE3708@pd.tnic>
 <1511cfcc-dcd1-b3c5-01c7-6b6b8fb65b05@arm.com>
 <20180516110348.GA17092@pd.tnic>
 <7c871e15-689c-226d-760d-dd92614de2e9@arm.com>
Message-ID: <20180517133653.GA27738@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 03:51:14PM +0100, James Morse wrote:
> The first two overload existing architectural behavior, the third improves all
> this with a third standard option. Its the standard story!

:-)

> I thought this was safe because its just ghes_copy_tofrom_phys()s access to the
> fixmap slots that needs mutual exclusion.
>
> Polled and all the IRQ flavours are kept apart by the spin_lock_irqsave(), and
> the NMIs have their own fixmap entry. (This is fine until there is more than
> once source of NMI)

For example:

ghes_probe()

	switch (generic->notify.type) {

	...

        case ACPI_HEST_NOTIFY_NMI:
		ghes_nmi_add(ghes);
	}

	...

	ghes_proc();
	  ghes_read_estatus();
		 spin_lock_irqsave(&ghes_ioremap_lock_irq, flags);

		 memcpy...

	-> NMI

		ghes_notify_nmi();
		 ghes_read_estatus();
		 ..
		   if (in_nmi) {
			   raw_spin_lock(&ghes_ioremap_lock_nmi);

		...
	<- NMI

ghes->estatus from above, before the NMI fired, has gotten some nice
scribbling over. AFAICT.

Now, I don't know whether this can happen with the ARM facilities but if
they're NMI-like, I don't see why not.

Which means, that this code is not really reentrant and if should be
fixed to be callable from different contexts, then it should use private
buffers and be careful about locking.

Oh, and that

	if (in_nmi)
		lock()
	else
		lock_irqsave()

pattern is really yucky. And it is an explosion waiting to happen.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
