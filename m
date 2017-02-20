From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Feb 2017 17:24:03 +0000
Subject: [PATCH 0/4] kuser updates for ARM-only vs Thumb
In-Reply-To: <20170220170632.GA6558@botnar.kaiser.cx>
References: <20170209121756.GC27312@n2100.armlinux.org.uk>
 <20170220170632.GA6558@botnar.kaiser.cx>
Message-ID: <20170220172403.GM21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 06:06:32PM +0100, Martin Kaiser wrote:
> Thus wrote Russell King - ARM Linux (linux at armlinux.org.uk):
> 
> > A while back, an issue was raised about the return instruction used
> > in the kuser page when building an ARMv4 and later environment.
> 
> > In order to fix this, I suggested building the kuser code for both
> > variants and selecting the appropriate version at run time.  This
> > seemed to be a simple solution, but due to the fix-ups and need to
> > build the appropriate version for the Kconfig options selected,
> > turned out to be not quite as trivial as I hoped.
> 
> > Nevertheless, this patch series provides that solution.
> 
> > As a side effect of this, the first patch is one which should be
> > merged irrespective of the remainder as it provides a useful cleanup
> > to the large number of dependencies for the ARM_THUMB option.
> 
> Since this was merged (commit bf4b17749f8632696134c8705f294ce02c85c1fa),
> linux-next would stop working on my imx258 (ARM926T).

Thanks for the report.

> Kernel panic - not syncing: Attempted to kill init!  exitcode=0x00000004
> 
> It turned out that CONFIG_ARM_THUMB was not set in my kernel config,
> enabling it fixed the problem.
> 
> Does this mean the kuser helpers now use thumb instructions and a user
> space binary crashes when it uses the helpers and thumb binaries are not
> supported?
> 
> If CONFIG_CPU_THUMB_CAPABLE requires CONFIG_ARM_THUMB, should we make
> this more explicit in the code?

No, that makes no sense:

"CPU_THUMB_CAPABLE" => "is this CPU capable of thumb support?"
"ARM_THUMB" => "this CPU supports thumb and we want userspace support"

Clearly, it does _not_ make sense to turn that upside down, especially
given that ARM_THUMB depends on CPU_THUMB_CAPABLE being set.

The problem here is that this test:

        if (!(elf_hwcap & HWCAP_THUMB))
                kuser_v4_init(vectors);
        else
                kuser_thumb_init(vectors);

is insufficient - if CONFIG_ARM_THUMB is disabled, we clear the thumb
bit in elf_hwcap, so we try to use the v4 code.  The v4 code is only
built into the kernel if we're supporting an ARMv3 or ARMv4 CPU, so
we end up with no kuser helpers at all.

This is not the point in the cycle to start messing around trying to
fix this, so I'll have to drop it for 4.11, and we'll have another go
for 4.12.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
