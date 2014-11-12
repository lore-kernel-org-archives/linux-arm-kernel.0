From: chanho.min@lge.com (Chanho Min)
Date: Thu, 13 Nov 2014 08:35:00 +0900
Subject: arm: Error handling for cacheflush
In-Reply-To: <20141112180335.GE26437@arm.com>
References: <004c01cffe64$cb83a220$628ae660$@min@lge.com>
 <20141112180335.GE26437@arm.com>
Message-ID: <005701cffed1$470084b0$d5018e10$@min@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: Thursday, November 13, 2014 3:04 AM
> To: Chanho Min
> Cc: '???'; 'Jongsung Kim'; 'HyoJun Im'
> Subject: Re: arm: Error handling for cacheflush
> 
> On Wed, Nov 12, 2014 at 10:38:28AM +0000, Chanho Min wrote:
> > Dear Will Deacon,
> 
> Hello,
> 
> > Since commit 28256d612726 ("ARM: cacheflush: split user cache-flushing
> > into interruptible chunks"), cacheflush can return -EINTR if it is interrupted
> > by signal and process has user-defined signal handler.
> >
> > But, most user of cacheflush haven't handled -EINTR and no man page or guide
> > is not founded. So, Would you check that cacheflush's behavior is changed to
> > to as the follows or you have another intention?
> >
> > int cacheflush(void *addr, size_t nbytes, int cache)
> > {
> >         int err;
> >         do err = syscall(__ARM_NR_cacheflush, addr, addr + nbytes, cache);
> >         while (err < 0 && errno == EINTR);
> >         return err;
> > }
> 
> Well, the system call could always have failed, so applications should be
> checking for that anyway. It's true that -EINTR is a new error code for
> this system call, but it was needed to prevent the machine being stalled
> from userspace for large ranges.

I fully understand the intention of this patch.
But, In this case, cacheflush should be re-invoked from the start of address.
(restart_syscall is not available in userspace)
So Handling of -EINTR may cause regression.

> 
> I don't know of any manpage for the ARM cacheflush system call, as it's
> private to the architecture.
> 
> Will

Chanho
