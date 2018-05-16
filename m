From: bp@alien8.de (Borislav Petkov)
Date: Wed, 16 May 2018 13:05:43 +0200
Subject: [PATCH v3 07/12] ACPI / APEI: Make the nmi_fixmap_idx per-ghes
 to allow multiple in_nmi() users
In-Reply-To: <1511cfcc-dcd1-b3c5-01c7-6b6b8fb65b05@arm.com>
References: <20180427153510.5799-1-james.morse@arm.com>
 <20180427153510.5799-8-james.morse@arm.com>
 <20180505122719.GE3708@pd.tnic>
 <1511cfcc-dcd1-b3c5-01c7-6b6b8fb65b05@arm.com>
Message-ID: <20180516110348.GA17092@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2018 at 09:45:01AM +0100, James Morse wrote:
> NOTIFY_NMI is x86's NMI, arm doesn't have anything that behaves in the same way,
> so doesn't use it. The equivalent notifications with NMI-like behaviour are:
> * SEA (synchronous external abort)
> * SEI (SError Interrupt)
> * SDEI (software delegated exception interface)

Oh wow, three! :)

> Alternatively, I can put the fixmap-page and spinlock in some 'struct
> ghes_notification' that only the NMI-like struct-ghes need. This is just moving
> the indirection up a level, but it does pair the lock with the thing it locks,
> and gets rid of assigning spinlock pointers.

Keeping the lock and what it protects in one place certainly sounds
better. I guess you could so something like this:

struct ghes_fixmap {
 union {
  raw_spinlock_t nmi_lock;
   spinlock_t lock;
 };
 void __iomem *(map)(struct ghes_fixmap *);
};

and assign the proper ghes_ioremap function to ->map.

The spin_lock_irqsave() call in ghes_copy_tofrom_phys() is kinda
questionable. Because we should have disabled interrupts so that you can
do

spin_lock(map->lock);

Except that we do get called with IRQs on and looking at that call of
ghes_proc() at the end of ghes_probe(), that's a deadlock waiting to
happen.

And that comes from:

  77b246b32b2c ("acpi: apei: check for pending errors when probing GHES entries")

Tyler, this can't work in any context: imagine the GHES NMI or IRQ or
the timer fires while that ghes_proc() runs...

What's up?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
