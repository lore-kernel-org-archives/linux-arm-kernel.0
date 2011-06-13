From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jun 2011 18:14:46 +0100
Subject: [PATCH 00/14] Re-jig cpu_suspend for a saner calling convention
Message-ID: <20110613171446.GF13643@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently cpu_suspend is not like a normal C function - when it's called
it returns normally to a bunch of code which is not expected to return.
The return path is via code pointed to by 'r3'.

It also corrupts a bunch of registers in ways which make it non-compliant
with a C API.

If we do make this complaint as a normal C-like function, it eliminates
this register saving.  We also swap 'lr' and 'r3', so cpu_suspend
effectively only returns to following code on resume - and r3 points
to the suspend code.

So, this becomes:
        ENTRY(acmeSoC_cpu_suspend)
                stmfd   sp!, {lr}
                adr     r3, soc_finish_suspend
                bl      cpu_suspend
                ldmfd   sp!, {pc}
        ENDPROC(acmeSoC_cpu_suspend)

        soc_finish_suspend:
                blah
                blah
                put soc to sleep
                never return

or even:

static void soc_suspend(void)
{
        [soc specific preparation]

        cpu_suspend(0, PLAT_PHYS_OFFSET - PAGE_OFFSET,
                soc_suspend_arg, soc_suspend_fn);

        [soc specific cleanup ]
}

where soc_suspend_fn can be either assembly or C code - but must never
return.

Tested on Assabet (SA1100) only.

 arch/arm/kernel/sleep.S       |   70 +++++++++++++++-------------------------
 arch/arm/mach-exynos4/sleep.S |   10 ++----
 arch/arm/mach-pxa/sleep.S     |   48 ++++++++++++++--------------
 arch/arm/mach-s3c64xx/sleep.S |   11 ++-----
 arch/arm/mach-s5pv210/sleep.S |   10 ++----
 arch/arm/mach-sa1100/sleep.S  |   17 +++-------
 arch/arm/plat-s3c24xx/sleep.S |   12 ++-----
 7 files changed, 67 insertions(+), 111 deletions(-)
