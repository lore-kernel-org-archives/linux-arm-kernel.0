From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 Oct 2013 12:24:26 +0100
Subject: [RFC PATCH] arm64: KVM: honor cacheability attributes on S2
 page fault
In-Reply-To: <525667DB.7090705@arm.com>
References: <1378806670-2467-1-git-send-email-marc.zyngier@arm.com>
 <CAAhSdy2E6aRndw88_S_3wfyTOYd5rQQTc4+Cw5Hd1DFXuM6EBA@mail.gmail.com>
 <523063AC.8040803@arm.com> <20130911193855.GN9860@cbox>
 <CAAhSdy0EZpzGOpVFOo-GWPs97XLHB8_uTZ7BTu0gP958y8JPeA@mail.gmail.com>
 <525667DB.7090705@arm.com>
Message-ID: <20131010112425.GB21380@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 10, 2013 at 09:39:55AM +0100, Marc Zyngier wrote:
> On 10/10/13 05:51, Anup Patel wrote:
> > Are you planning to go ahead with this approach ?
> 
> [adding Catalin, as we heavily discussed this recently]
> 
> Not as such, as it doesn't solve the full issue. It merely papers over
> the whole "my cache is off" problem. More specifically, any kind of
> speculative access from another CPU while caches are off in the guest
> completely nukes the benefit of this patch.
> 
> Also, turning the the caches off is another source of problems, as
> speculation also screws up set/way invalidation.

Indeed. The set/way operations trapping and broadcasting (or deferring)
to other CPUs in software just happens to work but there is no
guarantee, sooner or later we'll hit a problem. I'm even tempted to
remove flush_dcache_all() calls on the booting path for the arm64
kernel, we already require that whatever runs before Linux should
clean&invalidate the caches.

Basically, with KVM a VCPU even if running with caches/MMU disabled can
still get speculative allocation into the cache. The reason for this is
the other cacheable memory aliases created by the host kernel and
qemu/kvmtool. I can't tell whether Xen has this issue but it may be
easier in Xen to avoid memory aliases.

> > We really need this patch for X-Gene L3 cache.
> 
> So far, I can see two possibilities:
> - either we mandate caches to be always on (DC bit, and you're not
> allowed to turn the caches off).

That's my preferred approach. For hotplug, idle, the guest would use an
HVC call (PSCI) and the host takes care of re-enabling the DC bit. But
we may not catch all cases (kexec probably).

> - Or we mandate that caches are invalidated (by VA) for each write that
> is performed with caches off.

For some things like run-time code patching, on ARMv8 we need to do at
least I-cache maintenance since the CPU can allocate into the I-cache
(even if there are no aliases).

-- 
Catalin
