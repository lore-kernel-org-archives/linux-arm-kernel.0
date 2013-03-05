From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 5 Mar 2013 17:35:22 +0100
Subject: [PATCH] lglock: add read-preference local-global rwlock
In-Reply-To: <51361540.3060603@cn.fujitsu.com>
References: <512CC509.1050000@linux.vnet.ibm.com>
 <CACvQF50UgiqPpDk3HCmV86zKSf6tPjqr0bZowfPEOJs0g0r0MQ@mail.gmail.com>
 <512D0D67.9010609@linux.vnet.ibm.com>
 <CACvQF53ph2ixdM-otzetjM5cR+2kcZj6sckOp3TnzzA_x-EZ8w@mail.gmail.com>
 <512E7879.20109@linux.vnet.ibm.com> <5130E8E2.50206@cn.fujitsu.com>
 <20130301182854.GA3631@redhat.com>
 <CANN689HEW=b5S93J27p+rBX-5m7jkW4FER=eHDCp7OgMaTWLPw@mail.gmail.com>
 <20130302170656.GB29769@redhat.com> <51361540.3060603@cn.fujitsu.com>
Message-ID: <20130305163522.GA4179@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05, Lai Jiangshan wrote:
>
> On 03/03/13 01:06, Oleg Nesterov wrote:
> > On 03/02, Michel Lespinasse wrote:
> >>
> >> My version would be slower if it needs to take the
> >> slow path in a reentrant way, but I'm not sure it matters either :)
> >
> > I'd say, this doesn't matter at all, simply because this can only happen
> > if we race with the active writer.
>
> It can also happen when interrupted. (still very rarely)
>
> arch_spin_trylock()
> 	------->interrupted,
> 		__this_cpu_read() returns 0.
> 		arch_spin_trylock() fails
> 		slowpath, any nested will be slowpath too.
> 		...
> 		..._read_unlock()
> 	<-------interrupt
> __this_cpu_inc()
> ....

Yes sure. Or it can take the local lock after we already take the global
fallback_lock.

But the same can happen with FALLBACK_BASE, just because we need to take
a lock (local or global) first, then increment the counter.

> (I worries to much. I tend to remove FALLBACK_BASE now, we should
> add it only after we proved we needed it, this part is not proved)

Agreed, great ;)

Oleg.
