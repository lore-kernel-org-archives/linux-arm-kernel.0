From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 18 Jan 2016 16:19:29 +0800
Subject: [v3,11/41] mips: reuse asm-generic/barrier.h
In-Reply-To: <20160114204827.GE3818@linux.vnet.ibm.com>
Message-ID: <20160118081929.GA30420@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
>
> You could use SYNC_ACQUIRE() to implement read_barrier_depends() and
> smp_read_barrier_depends(), but SYNC_RMB probably does not suffice.
> The reason for this is that smp_read_barrier_depends() must order the
> pointer load against any subsequent read or write through a dereference
> of that pointer.  For example:
> 
>        p = READ_ONCE(gp);
>        smp_rmb();
>        r1 = p->a; /* ordered by smp_rmb(). */
>        p->b = 42; /* NOT ordered by smp_rmb(), BUG!!! */
>        r2 = x; /* ordered by smp_rmb(), but doesn't need to be. */
> 
> In contrast:
> 
>        p = READ_ONCE(gp);
>        smp_read_barrier_depends();
>        r1 = p->a; /* ordered by smp_read_barrier_depends(). */
>        p->b = 42; /* ordered by smp_read_barrier_depends(). */
>        r2 = x; /* not ordered by smp_read_barrier_depends(), which is OK. */
> 
> Again, if your hardware maintains local ordering for address
> and data dependencies, you can have read_barrier_depends() and
> smp_read_barrier_depends() be no-ops like they are for most
> architectures.
> 
> Does that help?

This is crazy! smp_rmb started out being strictly stronger than
smp_read_barrier_depends, when did this stop being the case?
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
