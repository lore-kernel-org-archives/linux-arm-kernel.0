From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Fri, 10 Dec 2010 21:39:50 +0100
Subject: [BUG] 2.6.37-rc3 massive interactivity regression on ARM
In-Reply-To: <alpine.DEB.2.00.1012101410571.13986@router.home>
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
Message-ID: <1292013590.2746.2.camel@edumazet-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le vendredi 10 d?cembre 2010 ? 14:23 -0600, Christoph Lameter a ?crit :
> On Fri, 10 Dec 2010, Peter Zijlstra wrote:
> 
> > Its not about passing per-cpu pointers, its about passing long pointers.
> >
> > When I write:
> >
> > void foo(u64 *bla)
> > {
> > 	*bla++;
> > }
> >
> > DEFINE_PER_CPU(u64, plop);
> >
> > void bar(void)
> > {
> > 	foo(__this_cpu_ptr(plop));
> > }
> >
> > I want gcc to emit the equivalent to:
> >
> > __this_cpu_inc(plop); /* incq %fs:(%0) */
> >
> > Now I guess the C type system will get in the way of this ever working,
> > since a long pointer would have a distinct type from a regular
> > pointer :/
> >
> > The idea is to use 'regular' functions with the per-cpu data in a
> > transparent manner so as not to have to replicate all logic.
> 
> That would mean you would have to pass information in the pointer at
> runtime indicating that this particular pointer is a per cpu pointer.
> 
> Code for the Itanium arch can do that because it has per cpu virtual
> mappings. So you define a virtual area for per cpu data and then map it
> differently for each processor. If we would have a different page table
> for each processor then we could avoid using segment register and do the
> same on x86.
> 
> > > Seems that you do not have that use case in mind. So a seqlock restricted
> > > to a single processor? If so then you wont need any of those smp write
> > > barriers mentioned earlier. A simple compiler barrier() is sufficient.
> >
> > The seqcount is sometimes read by different CPUs, but I don't see why we
> > couldn't do what Eric suggested.
> 
> But you would have to define a per cpu seqlock. Each cpu would have
> its own seqlock. Then you could have this_cpu_read_seqcount_begin and
> friends:
> 
> 

Yes. It was the idea.

> DEFINE_PER_CPU(seqcount, bla);
> 
> 

This is in Peter patch :)

> 
> 
> /* Start of read using pointer to a sequence counter only.  */
> static inline unsigned this_cpu_read_seqcount_begin(const seqcount_t __percpu *s)
> {
>         /* No other processor can be using this lock since it is per cpu*/
>         ret = this_cpu_read(s->sequence);
> 	barrier();
>         return ret;
> }
> 
> /*
>  * Test if reader processed invalid data because sequence number has changed.
>  */
> static inline int this_cpu_read_seqcount_retry(const seqcount_t __percpu *s, unsigned start)
> {
> 	barrier();
>         return this_cpu_read(s->sequence) != start;
> }
> 
> 
> /*
>  * Sequence counter only version assumes that callers are using their
>  * own mutexing.
>  */
> static inline void this_cpu_write_seqcount_begin(seqcount_t __percpu *s)
> {
>         __this_cpu_inc(s->sequence);
> 	barrier();
> }
> 
> static inline void this_cpuwrite_seqcount_end(seqcount_t __percpu *s)
> {
>         __this_cpu_dec(s->sequence);
> 	barrier();
> }
> 
> 
> Then you can do
> 
> this_cpu_read_seqcount_begin(&bla)
> 
> ...

This was exactly my suggestion Christoph.

I am glad you understand it now.
