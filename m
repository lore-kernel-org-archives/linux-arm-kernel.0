From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 29 Aug 2013 11:52:35 +0100
Subject: [PATCH] ARM64: KVM: Fix coherent_icache_guest_page() for host
 with external L3-cache.
In-Reply-To: <CAAhSdy3W+q4yk992ajnHBb23SVDqmfe_4BiGfH9XTYkwfVmC-A@mail.gmail.com>
References: <da83e967f5a266ca28ee54638a4a9be9@www.loen.fr>
 <CAAhSdy3-+tJ34QQgieifo931pfGoYt3RAqr8OkVtkxO6jgGdHQ@mail.gmail.com>
 <3ebe469fcf451cc7396dd2a5d3f01272@www.loen.fr>
 <CAAhSdy3WwZcLW6s05mV=Mn8=w8TcubTdYrgNqAChqiHxXC53eg@mail.gmail.com>
 <747a0675165da4ef147bbda4e140549b@www.loen.fr>
 <CAAhSdy3t1B_94qiYiLeR2-imQU0KCct6+76kjW_FS=QgAtTb3g@mail.gmail.com>
 <5935339137684ecf90dd484cc5739548@www.loen.fr>
 <20130815165344.GA3853@cbox>
 <CAAhSdy0mMAkziHQOYBw1yT1-h2N6vpQQdn_f25BEJpv2qYOHxA@mail.gmail.com>
 <CAAhSdy3W+q4yk992ajnHBb23SVDqmfe_4BiGfH9XTYkwfVmC-A@mail.gmail.com>
Message-ID: <20130829105235.GC13704@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anup,

Jumping late into this thread (holidays).

On Fri, Aug 16, 2013 at 07:57:55AM +0100, Anup Patel wrote:
> The approach of flushing d-cache by set/way upon first run of VCPU will
> not work because for set/way operations ARM ARM says: "For set/way
> operations, and for All (entire cache) operations, the point is defined to be
> to the next level of caching". In other words, set/way operations work upto
> point of unification.

I don't understand where you got the idea that set/way operations work
up to the point of unification. This is incorrect, the set/way
operations work on the level of cache specified by bits 3:1 in the
register passed to the DC CISW instruction. For your L3 cache, those
bits would be 2 (and __flush_dcache_all() implementation does this
dynamically).

For the I-cache all operation, that's correct, it only invalidates to
the PoU but it doesn't need to go any further, you do the D-cache
maintenance for this (no point in duplicating functionality).

> Also, Guest Linux already does __flush_dcache_all() from __cpu_setup()
> at bootup time which does not work for us when L3-cache is enabled so,
> there is no point is adding one more __flush_dcache_all() upon first run of
> VCPU in KVM ARM64.

Do you mean the CPU is not aware of the L3 cache? Does CLIDR_EL1 report
an L3 cache on your implementation?

It's not clear to me whether your L3 cache is inner or outer (or a mix).
You say that D-cache maintenance to PoC flushes the L3 which looks to me
like an inner cache, in which cache it should be reported in the LoC
bits in CLIDR_EL1.

> IMHO, we are left with following options:
> 1. Flush all RAM regions of VCPU using __flush_dcache_range()
>     upon first run of VCPU
> 2. Implement outer-cache framework for ARM64 and flush all
>     caches + outer cache (i.e. L3-cache) upon first run of VCPU

Do you have specific instructions for flushing the L3 cache only? It's
not clear to me what an outer-cache framework would to on AArch64. It
was added on AArch32 for the L2x0/PL310 which need separate instructions
by physical address for flushing the cache. I really hope we don't get
these again on ARMv8 hardware.

> 3. Use an alternate version of flush_icache_range() which will
>     flush d-cache by PoC instead of PoU. We can also ensure
>     that coherent_icache_guest_page() function will be called
>     upon Stage2 prefetch aborts only.

flush_icache_range() is meant to flush only to the PoU to ensure the I-D
cache coherency. I don't think we should change this.

-- 
Catalin
