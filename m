From: oleg@redhat.com (Oleg Nesterov)
Date: Sat, 2 Mar 2013 18:20:03 +0100
Subject: [PATCH V2] lglock: add read-preference local-global rwlock
In-Reply-To: <5131FB4C.7070408@cn.fujitsu.com>
References: <CACvQF51RvhM8XNqu3-1OTQ=cZUZ=pAX+_zx0a29+W67N1X+BgQ@mail.gmail.com>
 <512CC509.1050000@linux.vnet.ibm.com>
 <CACvQF50UgiqPpDk3HCmV86zKSf6tPjqr0bZowfPEOJs0g0r0MQ@mail.gmail.com>
 <512D0D67.9010609@linux.vnet.ibm.com>
 <CACvQF53ph2ixdM-otzetjM5cR+2kcZj6sckOp3TnzzA_x-EZ8w@mail.gmail.com>
 <512E7879.20109@linux.vnet.ibm.com> <5130E8E2.50206@cn.fujitsu.com>
 <20130301182854.GA3631@redhat.com>
 <CANN689HEW=b5S93J27p+rBX-5m7jkW4FER=eHDCp7OgMaTWLPw@mail.gmail.com>
 <5131FB4C.7070408@cn.fujitsu.com>
Message-ID: <20130302172003.GC29769@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02, Lai Jiangshan wrote:
>
> +void lg_rwlock_local_read_unlock(struct lgrwlock *lgrw)
> +{
> +	switch (__this_cpu_read(*lgrw->reader_refcnt)) {
> +	case 1:
> +		__this_cpu_write(*lgrw->reader_refcnt, 0);
> +		lg_local_unlock(&lgrw->lglock);
> +		return;
> +	case FALLBACK_BASE:
> +		__this_cpu_write(*lgrw->reader_refcnt, 0);
> +		read_unlock(&lgrw->fallback_rwlock);
> +		rwlock_release(&lg->lock_dep_map, 1, _RET_IP_);

I guess "case 1:" should do rwlock_release() too.

Otherwise, at first glance looks correct...

However, I still think that FALLBACK_BASE only adds the unnecessary
complications. But even if I am right this is subjective of course, please
feel free to ignore.

And btw, I am not sure about lg->lock_dep_map, perhaps we should use
fallback_rwlock->dep_map ?

We need rwlock_acquire_read() even in the fast-path, and this acquire_read
should be paired with rwlock_acquire() in _write_lock(), but it does
spin_acquire(lg->lock_dep_map). Yes, currently this is the same (afaics)
but perhaps fallback_rwlock->dep_map would be more clean.

Oleg.
