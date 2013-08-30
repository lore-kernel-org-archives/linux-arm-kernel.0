From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 30 Aug 2013 14:02:38 +0100
Subject: [PATCH] ARM64: KVM: Fix coherent_icache_guest_page() for host
 with external L3-cache.
In-Reply-To: <CAAhSdy0Hm1k+mWGGxUOzAA=5yVGNOERfo=36jcE1cvkUM=xtVg@mail.gmail.com>
References: <5935339137684ecf90dd484cc5739548@www.loen.fr>
 <20130815165344.GA3853@cbox>
 <CAAhSdy0mMAkziHQOYBw1yT1-h2N6vpQQdn_f25BEJpv2qYOHxA@mail.gmail.com>
 <CAAhSdy3W+q4yk992ajnHBb23SVDqmfe_4BiGfH9XTYkwfVmC-A@mail.gmail.com>
 <20130816171912.GB20246@cbox>
 <CAAhSdy2bk6Ou=326cYJW2wKvm9pffbRRmO2ABFwF9dmqwWdKqQ@mail.gmail.com>
 <20130816175034.GE20246@cbox>
 <CAAhSdy3B5JTcd7==u_QzS3V5k7pYkymtiLa7X=yZH+=eSBAw8w@mail.gmail.com>
 <20130830095215.GC62188@MacBook-Pro.local>
 <CAAhSdy0Hm1k+mWGGxUOzAA=5yVGNOERfo=36jcE1cvkUM=xtVg@mail.gmail.com>
Message-ID: <20130830130238.GB4650@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 30, 2013 at 11:44:30AM +0100, Anup Patel wrote:
> On Fri, Aug 30, 2013 at 3:22 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Fri, Aug 16, 2013 at 07:11:51PM +0100, Anup Patel wrote:
> >> On Fri, Aug 16, 2013 at 11:20 PM, Christoffer Dall
> >> <christoffer.dall@linaro.org> wrote:
> >> > On Fri, Aug 16, 2013 at 11:12:08PM +0530, Anup Patel wrote:
> >> >> Discussion here is about getting KVM ARM64 working in-presence
> >> >> of an external L3-cache (i.e. not part of CPU). Before starting a VCPU
> >> >> user-space typically loads images to guest RAM so, in-presence of
> >> >> huge L3-cache (few MBs). When the VCPU starts running some of the
> >> >> contents guest RAM will be still in L3-cache and VCPU runs with
> >> >> MMU off (i.e. cacheing off) hence VCPU will bypass L3-cache and
> >> >> see incorrect contents. To solve this problem we need to flush the
> >> >> guest RAM contents before they are accessed by first time by VCPU.
> >> >>
> >> > ok, I'm with you that far.
> >> >
> >> > But is it also not true that we need to decide between:
> >> >
> >> >   A.1: Flush the entire guest RAM before running the VCPU
> >> >   A.2: Flush the pages as we fault them in
> >>
> >> Yes, thats the decision we have to make.
> >>
> >> >
> >> > And (independently):
> >> >
> >> >   B.1: Use __flush_dcache_range
> >> >   B.2: Use something else + outer cache framework for arm64
> >>
> >> This would be __flush_dcache_all() + outer cache flush all.
> >
> > We need to be careful here since the __flush_dcache_all() operation uses
> > cache maintenance by set/way and these are *local* to a CPU (IOW not
> > broadcast). Do you have any guarantee that dirty cache lines don't
> > migrate between CPUs and __flush_dcache_all() wouldn't miss them?
> > Architecturally we don't, so this is not a safe operation that would
> > guarantee L1 cache flushing (we probably need to revisit some of the
> > __flush_dcache_all() calls in KVM, I haven't looked into this).
> >
> > So I think we are left to the range operation where the DC ops to PoC
> > would be enough for your L3.
> 
> If __flush_dcache_all() is *local" to a CPU then I guess DC ops to PoC
> by range would be the only option.

Yes. In the (upcoming) ARM ARMv8 there is a clear note that set/way
operations to flush the whole cache must not be used for the maintenance
of large buffer but only during power-down/power-up code sequences.

> > An outer cache flush all is probably only needed for cpuidle/suspend
> > (the booting part should be handled by the boot loader).
> 
> Yes, cpuidle/suspend would definitely require outer cache maintenance.
> 
> For KVM, we can avoid flushing d-cache to PoC every time in
> coherent_icache_guest_page() by only doing it when Guest MMU is
> turned-off. This may reduce the performance penalty.

That's for the KVM guys to decide ;)

-- 
Catalin
