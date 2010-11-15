From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Nov 2010 10:06:06 +0000
Subject: [PATCH 2.6.36 1/1 RESEND] kernel SPIN_LOCK_UNLOCKED changed to
	__SPIN_LOCK_UNLOCKED()
In-Reply-To: <201011151044.36213.arnd@arndb.de>
References: <4CDED96A.9080404@gmail.com>
	<20101115092404.GA24194@n2100.arm.linux.org.uk>
	<201011151044.36213.arnd@arndb.de>
Message-ID: <20101115100606.GC24194@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 15, 2010 at 10:44:36AM +0100, Arnd Bergmann wrote:
> On Monday 15 November 2010 10:24:04 Russell King - ARM Linux wrote:
> > This lock is in the percpu data area.  This means that when other CPUs
> > are brought online, and therefore other percpu areas are instantiated,
> > this lock will be mis-initialized (the pointers et.al. will be pointing
> > at the original percpu instance.)
> > 
> > So NAK, this will break.
> 
> I believe right now we only use the argument of __SPIN_LOCK_UNLOCKED
> as an identifier string for lockdep, but not for any pointers, so the
> patch would actually do what was intended, but break if we ever start
> relying on the pointer.
> 
> Maybe we can mangle the argument in some way to make sure it will break
> at build time when that happens, e.g.
> 
>      .lock   = __SPIN_LOCK_UNLOCKED(ipi_data.__lock)
> 
> This would at least let us remove SPIN_LOCK_UNLOCKED.

Or do one of the things I've suggested - one of which I've just completed
the code changes for, and results in this lock going away completely.
It's not a nice idea to have percpu data written to by 'foreign' CPUs.
