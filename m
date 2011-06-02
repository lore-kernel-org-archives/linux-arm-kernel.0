From: will.deacon@arm.com (Will Deacon)
Date: Thu, 2 Jun 2011 10:59:38 +0100
Subject: Clarification on ARM V6 context switching code
In-Reply-To: <20110602081105.GA651@T61>
References: <20110602081105.GA651@T61>
Message-ID: <001501cc210b$c8ecc9e0$5ac65da0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linu,

> While trying to understand the v6 context switching code, found some
> disparity with the code and the architecture specification/TRM.

Ok.
 
> Here is my doubt,
> 
> 1. According to the architecture spec(ARM DDI 0406B), while switching
> the ASID, the architecture expects the TTBR to contain ONLY global
> mappings except the below cases where we
> -  switch to a reserved context ID
> -  disable the non global mappings

Actually, on modern CPUs (Cortex-A15) we can't even use the reserved context
ID safely.

> as explained in section "Synchronization of changes of ASID and TTBR.
> 
> In "cpu_v6_switch_mm" function  in arch/arm/mm/proc-v6.S,
> we use TTBR0 during the switch which points to process page table
> having both global and non global entries. We neither switch to a
> reserved context ID nor disable non global mappings.
> 
> This appears to be out of sync with the spec?

It is out of sync with the spec, but the spec is the v7 ARM ARM and covers the
case of speculating, out-of-order CPUs.
 
> If the above is true, how about using the reserved context id during
> the switch ?

I don't believe that this is necessary for any existing v6 cores. Since we are
only using global mappings during context-switch and we assume that no
speculation is taking place, then not using a reserved ASID should be fine.

Of course, if you're seeing issues on real hardware then this needs to be fixed!

> 2. In the same function, are we not missing a IMB sequence after
> writing to the context ID register as expected by the  the ARM 11
> MPCore TRM(ARM DDI 0360F, section  3.4.25 )  ?

Since we don't use the user mappings during context-switch, I don't think an
instruction barrier is necessary for any existing v6 implementations.

> Please point out if i misunderstood the spec/TRM.

It looks like you've understood the specs, but Linux takes some shortcuts
because of the nature of real v6 hardware.

Will
