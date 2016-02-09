From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 9 Feb 2016 21:59:19 +0100
Subject: [PATCH 0/8] KVM/ARM: Guest Entry/Exit optimizations
In-Reply-To: <1454931622-14902-1-git-send-email-marc.zyngier@arm.com>
References: <1454931622-14902-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160209205919.GF5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 11:40:14AM +0000, Marc Zyngier wrote:
> I've recently been looking at our entry/exit costs, and profiling
> figures did show some very low hanging fruits.
> 
> The most obvious cost is that accessing the GIC HW is slow. As in
> "deadly slow", specially when GICv2 is involved. So not hammering the
> HW when there is nothing to write is immediately beneficial, as this
> is the most common cases (whatever people seem to think, interrupts
> are a *rare* event).
> 
> Another easy thing to fix is the way we handle trapped system
> registers. We do insist on (mostly) sorting them, but we do perform a
> linear search on trap. We can switch to a binary search for free, and
> get immediate benefits (the PMU code, being extremely trap-happy,
> benefits immediately from this).
> 
> With these in place, I see an improvement of 20 to 30% (depending on
> the platform) on our world-switch cycle count when running a set of
> hand-crafted guests that are designed to only perform traps.

I'm curious about the weight of these two?  My guess based on the
measurement work I did is that the GIC is by far the worst sinner, but
that was exacerbated on X-Gene compared to Seattle.

> 
> Methodology:
> 
> * NULL-hypercall guest: Perform 65536 PSCI_0_2_FN_PSCI_VERSION calls,
> and then a power-off:
> 
> __start:
> 	mov	x19, #(1 << 16)
> 1:	mov	x0, #0x84000000
> 	hvc	#0
> 	sub	x19, x19, #1
> 	cbnz	x19, 1b
> 	mov	x0, #0x84000000
> 	add	x0, x0, #9
> 	hvc	#0
> 	b	.
> 
> * sysreg trap guest: Perform 2^20 PMSELR_EL0 accesses, and power-off:
> 
> __start:
> 	mov	x19, #(1 << 20)
> 1:	mrs	x0, PMSELR_EL0
> 	sub	x19, x19, #1
> 	cbnz	x19, 1b
> 	mov	x0, #0x84000000
> 	add	x0, x0, #9
> 	hvc	#0
> 	b	.
> 
> * These guests are profiled using perf and kvmtool:
> 
> taskset -c 1 perf stat -e cycles:kh lkvm run -c1 --kernel do_sysreg.bin 2>&1 >/dev/null| grep cycles

these would be good to add to kvm-unit-tests so we can keep an eye on
this sort of thing...


> 
> The result is then divided by the number of iterations (2^16 or 2^20).
> 
> These tests have been run on Seattle, Mustang, and LS2085, and shown
> significant improvements in all cases. I've only touched the arm64
> GIC code, but obviously the 32bit code should use it as well once
> we've migrated it to C.
> 
> I've pushed out a branch (kvm-arm64/suck-less) to the usual location.
> 

Looks promising!

-Christoffer
