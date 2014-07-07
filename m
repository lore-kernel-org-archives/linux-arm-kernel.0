From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Jul 2014 14:52:59 +0100
Subject: [PATCH 0/4] ABI updates
In-Reply-To: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
References: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
Message-ID: <20140707135259.GB32578@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 08:51:34PM +0100, Russell King - ARM Linux wrote:
> As a result of the recent discussions about android, several issues
> have been identified with existing kernels:
> 
> 1. HWCAP_SWP does not properly reflect whether the SWP instruction
>    should be used.  Turn HWCAP_SWP off on ARMv6+ where the exclusives
>    are available.
> 
> 2. SWP is unsafe when running on a SMP CPU; there is no bus locking
>    between the read and write parts of the instruction execution.
>    Force SWP emulation on ARMv7+ where we can disable the SWP
>    instruction.
> 
> 3. Reporting of alignment faults - kernel mode faults are silent due to
>    the requirements of the network stack, but we can note where the
>    last one occurs.
> 
> Testing reveals that at least my OMAP4430 userspace (supplied from TI)
> executes lots of SWP instructions, which is something that wasn't known
> before this patch.
> 
> Many systems today are not configured with SWP emulation enabled on SMP.
> This means that the SWP instruction is available, but unsafe.

The patches look fine to me (we are still discussing patch 4 but even if
it needs changing for TLS, it can be done separately from this series).

Question - should we go a step further and change the pr_debug() in
swp_emulate.c to something like pr_warn()?

Another deprecated feature is CP15 barriers (disable bit coming with the
virtualisation extensions). I think we should start emulating these soon
as well and print warnings.

-- 
Catalin
