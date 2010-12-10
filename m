From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Fri, 10 Dec 2010 19:14:19 +0100
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
In-Reply-To: <1292003346.13513.30.camel@laptop>
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
Message-ID: <1292004859.3580.387.camel@edumazet-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le vendredi 10 d?cembre 2010 ? 18:49 +0100, Peter Zijlstra a ?crit :
> On Fri, 2010-12-10 at 18:18 +0100, Eric Dumazet wrote:
> > Le vendredi 10 d?cembre 2010 ? 14:47 +0100, Peter Zijlstra a ?crit :
> 
> > Also irq_time_write_begin() and irq_time_write_end() could be faster
> > (called for current cpu)
> > 
> > static inline void irq_time_write_begin(void)
> > {
> > 	__this_cpu_inc(irq_time_seq.sequence);
> > 	smp_wmb();
> > }
> >  
> > static inline void irq_time_write_end(void)
> > {
> > 	smp_wmb();
> > 	__this_cpu_inc(irq_time_seq.sequence);
> > }
> 
> Yeah, but that kinda defeats the purpose of having it implemented in
> seqlock.h. Ideally we'd teach gcc about these long pointers and have
> something like: 
> 
>   write_seqcount_begin(&this_cpu_read(irq_time_seq));
> 
> do the right thing.

gcc wont be able to do this yet (%fs/%gs selectors)

But we can provide this_cpu_write_seqcount_{begin|end}()

static inline void this_cpu_write_seqcount_begin(seqcount_t *s)
{
	__this_cpu_inc(s->sequence);
	smp_wmb();
}
