From: boqun.feng@gmail.com (Boqun Feng)
Date: Wed, 2 Dec 2015 19:16:10 +0800
Subject: [PATCH] arm64: spinlock: serialise spin_unlock_wait against
 concurrent lockers
In-Reply-To: <20151202094002.GA14969@fixme-laptop.cn.ibm.com>
References: <1448624646-15863-1-git-send-email-will.deacon@arm.com>
 <20151201004017.GA1135@fixme-laptop.cn.ibm.com>
 <20151201163232.GD27751@arm.com>
 <20151202094002.GA14969@fixme-laptop.cn.ibm.com>
Message-ID: <20151202111610.GA17942@fixme-laptop.cn.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 05:40:02PM +0800, Boqun Feng wrote:
> On Tue, Dec 01, 2015 at 04:32:33PM +0000, Will Deacon wrote:
> > On Tue, Dec 01, 2015 at 08:40:17AM +0800, Boqun Feng wrote:
> > > Hi Will,
> > 
> > Hi Boqun,
> > 
> > > On Fri, Nov 27, 2015 at 11:44:06AM +0000, Will Deacon wrote:
> > > > Boqun Feng reported a rather nasty ordering issue with spin_unlock_wait
> > > > on architectures implementing spin_lock with LL/SC sequences and acquire
> > > > semantics:
> > > > 
> > > >  | CPU 1                   CPU 2                     CPU 3
> > > >  | ==================      ====================      ==============
> > > >  |                                                   spin_unlock(&lock);
> > > >  |                         spin_lock(&lock):
> > > >  |                           r1 = *lock; // r1 == 0;
> > > >  |                         o = READ_ONCE(object); // reordered here
> > > >  | object = NULL;
> > > >  | smp_mb();
> > > >  | spin_unlock_wait(&lock);
> > > >  |                           *lock = 1;
> > > >  | smp_mb();
> > > >  | o->dead = true;
> > > >  |                         if (o) // true
> > > >  |                           BUG_ON(o->dead); // true!!
> > > > 
> > > > The crux of the problem is that spin_unlock_wait(&lock) can return on
> > > > CPU 1 whilst CPU 2 is in the process of taking the lock. This can be
> > > > resolved by upgrading spin_unlock_wait to a LOCK operation, forcing it
> > > 
> > > I wonder whether upgrading it to a LOCK operation is necessary. Please
> > > see below.
> > > 
> > > > to serialise against a concurrent locker and giving it acquire semantics
> > > > in the process (although it is not at all clear whether this is needed -
> > > > different callers seem to assume different things about the barrier
> > > > semantics and architectures are similarly disjoint in their
> > > > implementations of the macro).
> > > > 
> > > > This patch implements spin_unlock_wait using an LL/SC sequence with
> > > > acquire semantics on arm64. For v8.1 systems with the LSE atomics, the
> > > 
> > > IIUC, you implement this with acquire semantics because a LOCK requires
> > > acquire semantics, right? I get that spin_unlock_wait() becoming a LOCK
> > > will surely simply our analysis, because LOCK->LOCK is always globally
> > > ordered. But for this particular problem, seems only a relaxed LL/SC
> > > loop suffices, and the use of spin_unlock_wait() in do_exit() only
> > > requires a control dependency which could be fulfilled by a relaxed
> > > LL/SC loop. So the acquire semantics may be not necessary here.
> > > 
> > > Am I missing something subtle here which is the reason you want to
> > > upgrading spin_unlock_wait() to a LOCK?
> > 
> > There's two things going on here:
> > 
> >   (1) Having spin_unlock_wait do a complete LL/SC sequence (i.e. writing
> >       to the lock, like a LOCK operation would)
> > 
> >   (2) Giving it ACQUIRE semantics
> > 
> > (2) is not necessary to fix the problem you described. However, LOCK
> > operations do imply ACQUIRE and it's not clear to me that what the
> > ordering semantics are for spin_unlock_wait.
> > 
> > I'd really like to keep this as simple as possible. Introducing yet
> > another magic barrier macro that isn't well understood or widely used
> > feels like a major step backwards to me, so I opted to upgrade
> > spin_unlock_wait to LOCK on arm64 so that I no longer have to worry
> > about it.
> > 
> 
> Fair enough ;-)
> 
> Another thing about the problem is that it happens only if
> spin_unlock_wait() observes lock is *unlocked* at the first time it
> checks that, IOW, if spin_unlock_wait() observes the transition of the
> state of a lock from locked to unlocked, AFAICS, the problem won't
> happen. Maybe we can use this for a little optimization like(in pseudo
> code):
> 
> 	while (1) { // ll/sc loop
> 		r1 = load_link(*lock);
> 		if (!is_locked(r1)) {
> 			res = store_conditional(lock, r1);
> 			if (res == SUCC) // store succeeded.
> 				return;
> 		}
> 		else
> 			break;
> 	}
> 
> 	smp_rmb();
> 	do {
> 		r1 = *lock;	
> 	} while(is_locked(r1));
> 
> I think this works, and will test this using a PPC litmus in herd to
> verify it.
> 

So herd and PPCMEM both disagree with me ;-(

I'm missing the requirement of B-cumulativity here, so this doesn't
works on PPC.

Regards,
Boqun
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151202/f675154c/attachment.sig>
