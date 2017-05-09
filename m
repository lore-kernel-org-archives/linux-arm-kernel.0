From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 9 May 2017 22:37:19 +0300
Subject: [PATCH 3/3] arm64/locking: qspinlocks and qrwlocks support
In-Reply-To: <20170509184829.scwjixgc2kxxxku7@yury-N73SV>
References: <20170503145141.4966-1-ynorov@caviumnetworks.com>
 <20170503145141.4966-4-ynorov@caviumnetworks.com>
 <20170509044708.vvwgzhvdrqyljy6s@tardis>
 <20170509184829.scwjixgc2kxxxku7@yury-N73SV>
Message-ID: <20170509193719.is3naupydwuytzdt@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 09, 2017 at 09:48:29PM +0300, Yury Norov wrote:
> On Tue, May 09, 2017 at 12:47:08PM +0800, Boqun Feng wrote:
> > On Wed, May 03, 2017 at 05:51:41PM +0300, Yury Norov wrote:
> > > From: Jan Glauber <jglauber@cavium.com>
> > > 
> > > Ported from x86_64 with paravirtualization support removed.
> > > 
> > > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> > > 
> > > Note. This patch removes protection from direct inclusion of
> > > arch/arm64/include/asm/spinlock_types.h. It's done because
> > > kernel/locking/qrwlock.c file does it thru the header
> > > include/asm-generic/qrwlock_types.h. Until now the only user
> > > of qrwlock.c was x86, and there's no such protection too.
> > > 
> > > I'm not happy to remove the protection, but if it's OK for x86,
> > > it should be also OK for arm64. If not, I think we'd fix it
> > > for x86, and add the protection there too.
> > > 
> > > Yury
> > > 
> > > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> 
> [...]
> 
> > > +#define	queued_spin_unlock queued_spin_unlock
> > > +/**
> > > + * queued_spin_unlock - release a queued spinlock
> > > + * @lock : Pointer to queued spinlock structure
> > > + *
> > > + * A smp_store_release() on the least-significant byte.
> > > + */
> > > +static inline void queued_spin_unlock(struct qspinlock *lock)
> > > +{
> > > +	smp_store_release((u8 *)lock, 0);
> > 
> > I think this part will cause endian issues, maybe you want something
> > like what we do in queued_write_lock().
> > 
> > Have you tested this on an BE environment?
> 
> No. I think I have to. Thanks for the pointing it.
> 
> > 
> > Regards,
> > Boqun
> 
> I think it's just the issue of copying from x86, and there's no any
> specific need to cast to u8* type on arm64. So the correct version of
> it would be like this, I believe: smp_store_release(&lock->val).
> 
> Yury

Oops, it would rather be like this:

static inline void queued_spin_unlock(struct qspinlock *lock)
{
#if IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN)
       smp_store_release((u8 *) &lock->val + 3, 0);
#else
       smp_store_release((u8 *) &lock->val, 0);
#endif
}

Or with the helper, like here in ppc port:
https://www.spinics.net/lists/linux-virtualization/msg29390.html
