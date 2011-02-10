From: ccross@google.com (Colin Cross)
Date: Wed, 9 Feb 2011 19:15:25 -0800
Subject: [PATCH v3 2/5] ARM: pm: add generic CPU suspend/resume support
In-Reply-To: <20110207141734.GG31929@n2100.arm.linux.org.uk>
References: <20110206191117.GA17808@n2100.arm.linux.org.uk>
	<E1PmA28-0000AC-2t@rmk-PC.arm.linux.org.uk>
	<20110207120103.GC31929@n2100.arm.linux.org.uk>
	<20110207121052.GD31929@n2100.arm.linux.org.uk>
	<AANLkTintBD2Gfb3pkPZPe2mreU5EatUnNwUqR-id7q+M@mail.gmail.com>
	<20110207133457.GE31929@n2100.arm.linux.org.uk>
	<AANLkTi=B45PuOErxR49Gfhfq6-=y_NugbWBLBo0MEoCt@mail.gmail.com>
	<20110207141734.GG31929@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimCtaSZ=CHT5snWZ496_bi4sH=0LU7vJ-Jfh=dP@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 7, 2011 at 6:17 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 0c1172b..a5187dd 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> +ENTRY(cpu_v7_do_suspend)
> + ? ? ? stmfd ? sp!, {r4 - r11, lr}
> + ? ? ? mrc ? ? p15, 0, r4, c13, c0, 0 ?@ FCSE/PID
> + ? ? ? mrc ? ? p15, 0, r5, c13, c0, 1 ?@ Context ID
> + ? ? ? mrc ? ? p15, 0, r6, c3, c0, 0 ? @ Domain ID
> + ? ? ? mrc ? ? p15, 0, r7, c2, c0, 0 ? @ TTB 0
> + ? ? ? mrc ? ? p15, 0, r8, c2, c0, 1 ? @ TTB 1
> + ? ? ? mrc ? ? p15, 0, r9, c1, c0, 0 ? @ Control register
> + ? ? ? mrc ? ? p15, 0, r10, c1, c0, 1 ?@ Auxiliary control register
> + ? ? ? mrc ? ? p15, 0, r11, c1, c0, 2 ?@ Co-processor access control

The diagnostic register also needs to be saved to keep the errata bits
set in __v7_setup.

> + ? ? ? stmia ? r0, {r4 - r11}
> + ? ? ? ldmfd ? sp!, {r4 - r11, pc}
> +ENDPROC(cpu_v7_do_suspend)
> +
> +ENTRY(cpu_v7_do_resume)
> + ? ? ? mov ? ? ip, #0
> + ? ? ? mcr ? ? p15, 0, ip, c8, c7, 0 ? @ invalidate TLBs
> + ? ? ? mcr ? ? p15, 0, ip, c7, c5, 0 ? @ invalidate I cache

Does this need the same ALT_SMP/ALT_UP combo as v7_flush_icache_all?

<snip>

Tegra2 suspend and cpuidle works on top of this patch and the patch
that adds SMP support to sleep_save_sp.  Tegra seems to need to
invalidate the entire l1 data cache before enabling it, so I'm using a
custom reset vector that branches to cpu_resume, and I'm handling the
TLB invalidate in the function cpu_resume returns to.

Tested-by: Colin Cross <ccross@android.com>

Are you targeting 2.6.39 with these patches?  They replace a few
hundred lines of code in the Tegra2 suspend, hotplug, and idle
patches, so I'd like to wait until this is in before pushing mine.
