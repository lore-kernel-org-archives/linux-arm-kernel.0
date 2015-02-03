From: will.deacon@arm.com (Will Deacon)
Date: Tue, 3 Feb 2015 16:57:33 +0000
Subject: __HAVE_ARCH_CMPXCHG on ARM?
In-Reply-To: <20150203164848.GA15156@nathan3500-linux-VM>
References: <20150129185618.GA31459@nathan3500-linux-VM>
 <CAM2zO=CVCZFNiSukgcgNNT0==xgLK4w5HF3Pz=dcFmrEHPtLdw@mail.gmail.com>
 <20150202133933.GD31847@arm.com>
 <20150203164848.GA15156@nathan3500-linux-VM>
Message-ID: <20150203165733.GE25497@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 03, 2015 at 04:48:48PM +0000, Nathan Sullivan wrote:
> On Mon, Feb 02, 2015 at 01:39:33PM +0000, Will Deacon wrote:
> > On Fri, Jan 30, 2015 at 08:44:48AM +0000, Yong Zhang wrote:
> > > On Fri, Jan 30, 2015 at 2:56 AM, Nathan Sullivan <nathan.sullivan at ni.com<mailto:nathan.sullivan@ni.com>> wrote:
> > > 
> > > While investigating a performance issue on RT 3.14, I noticed that
> > > __HAVE_ARCH_CMPXCHG is not defined for ARM.  This causes -rt locks to
> > > always use the slow path and impacts performance.  ARMv6 and above
> > > have a cmpxchg implementation already that will work just fine.
> > > 
> > > In 2012, Yong Zhang submitted a patch to fix this[1], but it mysteriously
> > > disappeared afterwards.  I did notice that the s-o-b line has a different
> > > email address than the windriver one.  Yong, do you mind re-submitting the
> > > 
> > > It actually doesn't matter. Anyway feel free to add another s-o-b to
> > > the patch:
> > > 
> > > Signed-off-by: Yong Zhang <yong.zhang at windriver.com<mailto:yong.zhang@windriver.com>>
> > 
> > [...]
> > 
> > > diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
> > > index 7eb18c1..a91b44e 100644
> > > --- a/arch/arm/include/asm/cmpxchg.h
> > > +++ b/arch/arm/include/asm/cmpxchg.h
> > > @@ -127,6 +127,8 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
> > > 
> > >  #else  /* min ARCH >= ARMv6 */
> > > 
> > > +#define __HAVE_ARCH_CMPXCHG 1
> > 
> > Is it even possible to have CONFIG_SMP=y on an architecture that doesn't
> > support native cmpxchg? Certainly, the asm-generic cmpxchg.h barfs if
> > SMP, so couldn't we just change/extend the __HAVE_ARCH_CMPXCHG check in
> > rtmutex.c to work automatically with SMP architectures? That would help
> > arm64 too.
> > 
> > Will
> 
> What about single Cortex-A8s, for example?  Seems like a non-SMP build
> should still have cmpxchg.

If you have benchmarks that show an improvement then sure, but I don't
know how much an uncontended rtmutex would really care.

Will
