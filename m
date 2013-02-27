From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 27 Feb 2013 20:25:51 +0100
Subject: [PATCH v6 04/46] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
In-Reply-To: <CANN689FuuEb9wpV43DkTtgv6syvBYL-LQxByWznyAq8dkrhzBw@mail.gmail.com>
References: <51226F91.7000108@linux.vnet.ibm.com>
 <CACvQF53bdh4_BxF0y1fnTVR+T2OmRc0jmWQYftsvx92-fg-Lug@mail.gmail.com>
 <512BBAD8.8010006@linux.vnet.ibm.com>
 <CACvQF51jCxk5jUqmhD=QBBtUsBkQWZzakacrKO4Gsk=w61rNwQ@mail.gmail.com>
 <512C7A38.8060906@linux.vnet.ibm.com>
 <CACvQF51RvhM8XNqu3-1OTQ=cZUZ=pAX+_zx0a29+W67N1X+BgQ@mail.gmail.com>
 <512CC509.1050000@linux.vnet.ibm.com>
 <CACvQF50UgiqPpDk3HCmV86zKSf6tPjqr0bZowfPEOJs0g0r0MQ@mail.gmail.com>
 <512D0D67.9010609@linux.vnet.ibm.com>
 <CANN689FuuEb9wpV43DkTtgv6syvBYL-LQxByWznyAq8dkrhzBw@mail.gmail.com>
Message-ID: <20130227192551.GA8333@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27, Michel Lespinasse wrote:
>
> +void lg_rwlock_local_read_lock(struct lgrwlock *lgrw)
> +{
> +       preempt_disable();
> +
> +       if (__this_cpu_read(*lgrw->local_refcnt) ||
> +           arch_spin_trylock(this_cpu_ptr(lgrw->lglock->lock))) {
> +               __this_cpu_inc(*lgrw->local_refcnt);

Please look at __this_cpu_generic_to_op(). You need this_cpu_inc()
to avoid the race with irs. The same for _read_unlock.

But otherwise I agree, looks like a clever and working idea to me.
And simple!

> There is an interesting case where lg_rwlock_local_read_lock could be
> interrupted after getting the local lglock but before incrementing
> local_refcnt to 1; if that happens any nested readers within that
> interrupt will have to take the global rwlock read side. I think this
> is perfectly acceptable

Agreed.

Or interrupt can do spin_trylock(percpu-lock) after we take the global
->fallback_rwlock (if we race with write_lock + write_unlock), but I do
not see any possible deadlock in this case.

Oleg.
