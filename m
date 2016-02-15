From: horms@verge.net.au (Simon Horman)
Date: Tue, 16 Feb 2016 06:59:04 +0900
Subject: [PATCH v3 0/2] ARM: shmobile: Avoid writing to .text
In-Reply-To: <1455538808-6816-1-git-send-email-geert+renesas@glider.be>
References: <1455538808-6816-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20160215215904.GD15913@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 01:20:06PM +0100, Geert Uytterhoeven wrote:
>         Hi Simon, Magnus,
> 
> When CONFIG_DEBUG_RODATA=y, the kernel crashes during system suspend:
> 
>     Freezing user space processes ... (elapsed 0.004 seconds) done.
>     Freezing remaining freezable tasks ... (elapsed 0.002 seconds)
>     done.
>     PM: suspend of devices complete after 111.948 msecs
>     PM: late suspend of devices complete after 1.086 msecs
>     PM: noirq suspend of devices complete after 11.576 msecs
>     Disabling non-boot CPUs ...
>     Kernel panic - not syncing: Attempted to kill the idle task!
>     1014ec ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
>     CPU0: stopping
> 
> This happens because the shmobile assembler sources have several
> variables that are written to in the .text section, while .text is
> mapped read-only after kernel bootup if CONFIG_DEBUG_RODATA=y.
> 
> This series fixes this by moving variables from .text to .bss, or just
> removing them.
> Note that there's still an issue with shmobile_boot_fn in
> arch/arm/mach-shmobile/headsmp.S.  So far I didn't manage to fix this
> (the code and data are copied to SRAM on some SoCs).  However, currently
> this is mostly harmless, as this is written to during early kernel boot
> up only, before .text is marked read-only. It does matter for XIP
> (anyone using that with SMP?), so we do want to fix that in the long
> run, too.
> 
> These issues were uncovered by "[PATCH v2] ARM: mm: flip priority of
> CONFIG_DEBUG_RODATA". As that patch is already queued in arm/for-next, I
> think all these fixes should be queued for v4.5, to avoid a dependency
> with the arm tree.

Thanks Geert,

I have queued these up.
