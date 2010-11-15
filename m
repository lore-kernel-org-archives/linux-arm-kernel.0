From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Nov 2010 10:44:36 +0100
Subject: [PATCH 2.6.36 1/1 RESEND] kernel SPIN_LOCK_UNLOCKED changed to
	__SPIN_LOCK_UNLOCKED()
In-Reply-To: <20101115092404.GA24194@n2100.arm.linux.org.uk>
References: <4CDED96A.9080404@gmail.com>
	<20101115092404.GA24194@n2100.arm.linux.org.uk>
Message-ID: <201011151044.36213.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 November 2010 10:24:04 Russell King - ARM Linux wrote:
> > diff -uprN a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> > --- a/arch/arm/kernel/smp.c   2010-10-21 02:00:22.000000000 +0530
> > +++ b/arch/arm/kernel/smp.c   2010-11-07 00:47:32.000000000 +0530
> > @@ -56,7 +56,7 @@ struct ipi_data {
> >  };
> > 
> >  static DEFINE_PER_CPU(struct ipi_data, ipi_data) = {
> > -     .lock   = SPIN_LOCK_UNLOCKED,
> > +     .lock   = __SPIN_LOCK_UNLOCKED(ipi_data.lock),
> >  };
> 
> This lock is in the percpu data area.  This means that when other CPUs
> are brought online, and therefore other percpu areas are instantiated,
> this lock will be mis-initialized (the pointers et.al. will be pointing
> at the original percpu instance.)
> 
> So NAK, this will break.

I believe right now we only use the argument of __SPIN_LOCK_UNLOCKED
as an identifier string for lockdep, but not for any pointers, so the
patch would actually do what was intended, but break if we ever start
relying on the pointer.

Maybe we can mangle the argument in some way to make sure it will break
at build time when that happens, e.g.

     .lock   = __SPIN_LOCK_UNLOCKED(ipi_data.__lock)

This would at least let us remove SPIN_LOCK_UNLOCKED.

	Arnd
