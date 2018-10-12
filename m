From: bp@alien8.de (Borislav Petkov)
Date: Fri, 12 Oct 2018 13:08:19 +0200
Subject: [PATCH v6 08/18] ACPI / APEI: Move locking to the notification
 helper
In-Reply-To: <20180921221705.6478-9-james.morse@arm.com>
References: <20180921221705.6478-1-james.morse@arm.com>
 <20180921221705.6478-9-james.morse@arm.com>
Message-ID: <20181012110819.GB580@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2018 at 11:16:55PM +0100, James Morse wrote:
> ghes_copy_tofrom_phys() takes different locks depending on in_nmi().
> This doesn't work when we have multiple NMI-like notifications, that
> can interrupt each other.
> 
> Now that NOTIFY_SEA is always called as an NMI, move the lock-taking
> to the notification helper. The helper will always know which lock
> to take. This avoids ghes_copy_tofrom_phys() taking a guess based
> on in_nmi().
> 
> This splits NOTIFY_NMI and NOTIFY_SEA to use different locks. All
> the other notifications use ghes_proc(), and are called in process
> or IRQ context. Move the spin_lock_irqsave() around their ghes_proc()
> calls.

Right, should ghes_proc() be renamed to ghes_proc_irq() now, to be
absolutely clear on the processing context it is operating in?

Other than that:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
