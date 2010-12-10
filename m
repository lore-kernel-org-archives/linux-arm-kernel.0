From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Fri, 10 Dec 2010 22:22:45 +0100
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
In-Reply-To: <alpine.DEB.2.00.1012101505250.13986@router.home>
References: <20101208142814.GE9777@n2100.arm.linux.org.uk>
	<1291851079-27061-1-git-send-email-venki@google.com>
	<1291899120.29292.7.camel@twins>
	<AANLkTikd3X4pLs5De-LO6=XD+JqUz3-Ku7YM8+0-oK8t@mail.gmail.com>
	<1291917330.6803.7.camel@twins>
	<AANLkTin+eO_jPceSOHL4e7vqd+tf0ZCMHJ-USoz8aZL1@mail.gmail.com>
	<1291920939.6803.38.camel@twins>
	<AANLkTim+v21RpWobdw6exEbazDJwm4JjemPVB2+3PuRJ@mail.gmail.com>
	<1291936593.13513.3.camel@laptop>
	<AANLkTi=_qf8NAgj2HHMP0qG-ibnH-726NzoXbxd-bS1N@mail.gmail.com>
	<1291975704.6803.59.camel@twins>  <1291987065.6803.151.camel@twins>
	<1291987635.6803.161.camel@twins>  <1291988866.6803.171.camel@twins>
	<1292001500.3580.268.camel@edumazet-laptop>
	<1292003346.13513.30.camel@laptop>
	<1292004859.3580.387.camel@edumazet-laptop>
	<alpine.DEB.2.00.1012101236300.13986@router.home>
	<1292006788.13513.43.camel@laptop>
	<alpine.DEB.2.00.1012101344570.13986@router.home>
	<1292011644.13513.61.camel@laptop>
	<alpine.DEB.2.00.1012101410571.13986@router.home>
	<1292013590.2746.2.camel@edumazet-laptop>
	<1292014165.2746.9.camel@edumazet-laptop>
	<alpine.DEB.2.00.1012101505250.13986@router.home>
Message-ID: <1292016165.2746.14.camel@edumazet-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le vendredi 10 d?cembre 2010 ? 15:09 -0600, Christoph Lameter a ?crit :
> On Fri, 10 Dec 2010, Eric Dumazet wrote:
> 
> >
> > By the way, we need smp_wmb(), not barrier(), even only the "owner cpu"
> > can write into its 'percpu' seqcount.
> >
> > There is nothing special about a seqcount being percpu or a 'global'
> > one. We must have same memory barrier semantics.
> 
> There is certainly a major difference in that execution of a stream of
> instructions on the same cpu is guaranteed to have a coherent view of
> the data. That is not affected by interrupts etc.
> 

We dont care of interrupts. We care of doing a transaction over a
complex set of data, that cannot be done using an atomic op (or we need
a spinlock/mutex/rwlock), and should not because of performance.

> >
> > 	this_cpu_write_seqcount_begin(&myseqcount);
> > 	this_cpu_add(mydata1, add1);
> > 	this_cpu_add(mydata2, add2);
> > 	this_cpu_inc(mydata3);
> > 	this_cpu_write_seqcount_end(&myseqcount);
> >
> > We protect the data[1,2,3] set with a seqcount, so need smp_wmb() in
> > both _begin() and _end()
> 
> There is nothing to protect there since processing is on the same cpu. The
> data coherency guarantees of the processor will not allow anything out of
> sequence to affect execution. An interrupt f.e. will not cause updates to
> mydata1 to get lost.
> 

Please take a look at include/linux/u64_stats_sync.h, maybe you'll
understand the concern about using a seqcount to protect a set of data,
for example a 256 bit counter increment.
