From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 17 Jan 2011 17:38:11 +0530
Subject: [PATCH] ARM: smp: Fix Unknown IPI message 0x1
In-Reply-To: <20110117120104.GB20615@n2100.arm.linux.org.uk>
References: <1295265395-28485-1-git-send-email-santosh.shilimkar@ti.com>
	<20110117120104.GB20615@n2100.arm.linux.org.uk>
Message-ID: <72ca984700f139fea98558783dde38f3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Monday, January 17, 2011 5:31 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] ARM: smp: Fix Unknown IPI message 0x1
>
> On Mon, Jan 17, 2011 at 05:26:35PM +0530, Santosh Shilimkar wrote:
> > Commit 'ad3b6993' converted ARM smp_cross_call() to take IPI
> number
> > as a parameter to handle more event than SGI and do_IPI was
> suppose
> > to recover SGI number. But the do_IPI doesn't consider it and it's
> > getting detected as 'Unknown IPI message 0x1' with ipi numbers are
> > moved to starts from 'IPI_TIMER=2"
> >
> > There can be 16 different SGI but only SGI1 is used as IPI so
> > only that one is handled in do_IPI as IPI_CPU_START.
> >
> > Added IPI_CPU_START because it wasn't used and thought it's
> > appropriate. Not sure whether its the right one.
>
> Background:
> - we start at 2 because we don't know whether platforms have hard-
> wired
>   SGI1 for startup.
> - we don't trap SGI1 at all because we don't use it.
> - there's nothing stopping platforms using another SGI to wakeup -
> we
>   don't want to be adding more of this code.
>
OK.

> I'd much rather see platforms deciding whether they need to use SGI1
> or whether they can switch to SGI0 instead - and we make SGI0 be the
> "ignored wakeup" SGI.  If everyone can do that, we get rid of the
> silly offset entirely.

This should be ok. May be Catalin can comment on choice of SGI1 in
generic smp_cross_call().

I found below messge in boot which made me to make this patch.
'CPU1: Unknown IPI message 0x1'

Regards,
Santosh
