From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 15:27:07 +0100
Subject: [PATCH v4 00/40] ARM: mm: Add generic macros for declaring various
	CPU structs
Message-ID: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds macros for declaring some CPU-related structured
defined in assembler, and ports the various processors, cache and
tlb implementations to use the macros.

(See `PATCH v4 changes' below for a summary of the changes specific
to v4 of this series.)

Where multiple proc_info structures are defined by a single source
file, the common elements are collapsed out of these by defining
and invoking an additional local macro for this purpose.

A primary goal for this series is to introduce no API or binary
changes except for fixing the few obvious bugs which became
apparent when working on the series.

NOTE: There is an overlap between this series and Will/Pawel's
http://lists.arm.linux.org.uk/lurker/message/20110617.081930.2ed0934d.en.html).
patches to include Cortex-A5 support (see Will has agreed to merge
with my series in his tree so that it can all be pulled from there,
providing that my series has been accepted by the community.


Anyone with an interest in any of the
arch/arm/mm/{proc,cache,tlb}-*.S files is invited to comment and/or
test.

Detailed notes follow.

Cheers
---Dave


  - This patch supersedes Peter Chubb's patch for the typo in
    http://lists.arm.linux.org.uk/lurker/message/20110530.235513.4e1a0d16.en.html),
    proc-arm7tdmi.S (see which I believe hasn't been merged.  If it
    has merged or is pending, I can easily rebase on top of it.

  - *_processor_functions structures are not referenced outside the
    proc-*.S in which they are defined and could all be demoted to
    local scope.  To minimise breakage risk, I've left these global
    for now.

  - Some cache_fns structures are not referenced outside the file
    in which they are defined and could be local.  To simplify the
    macro definition, these are currently all made global: this
    should be harmless.

  - Placement of the structures in sections appears somewhat
    inconsistent at present.  Possibly, everything should move to
    __CPUINITRODATA.  Currently, the data is mostly spread between
    __INIT, __TEXT and __INITDATA.i To avoid unintended breakage,
    this series does not automatically switch sections in the
    macros, leaving the preexisting section assignments completely
    unchanged for now.

  - This series introduces a few lines slightly longer than 80
    characters.  I don't think that splitting these lines will do a
    lot to help readability, but this can be done if people prefer.


PATCH v4 changes:

  - The optional arguments to define_processor_functions which
    permitted overriding of individual functions from the default
    names have been removed.  Instead, code using this macro is
    expected to supply symbols with the expected default names.
    Alias symbols can be defined to achieve this if multiple cache
    models share some functions.  This change also ensures that
    single-cache-model kernels will work correctly.

  - The xscale_dma_a0_map_area in proc-xscale.S has been renamed to
    xscale_80200_A0_A1_dma_map_area as a side-effect of the above
    change.  This is more consistent, and should not cause any
    problems.  The old symbol name does not appear to be directly
    referenced from anywhere else.

General notes:

Except as described below, I have confirmed that there is no change
in the objects which get built from any of these files, by diffing
disassembly and symbol tables, and by comparing binary section
dumps.  (Debug info sections do generally change, but this is
expected since they naturally depend on the exact characteristics
of the source code.  They don't end up in the kernel image.)

Under these criteria, the cache-*.S and tlb-*.S files are exactly
equivalent to the unpatched versions.

proc-*.S files change in the following ways: (mostly minor)

        proc-arm1020    a.cp. ..
        proc-arm1020e   a.cp. ..
        proc-arm1022    a.cp. ..
        proc-arm1022    a.cp. ..
        proc-arm6_7     ..... ..
        proc-arm720     ..... ..
        proc-arm740     a.... Z.
        proc-arm7tdmi   .n..u Z. 1
        proc-arm920     a.cp. ..
        proc-arm922     a.cp. ..
        proc-arm925     a.cp. .. 2
        proc-arm926     a.cp. ..
        proc-arm940     ..c.. Z.
        proc-arm946     ..c.. Z.
        proc-arm9tdmi   ....u ..
        proc-fa526      a..p. ..
        proc-feroceon   a.cp. ..
        proc-mohawk     a.c.. .X 34
        proc-sa110      ..... ..
        proc-sa1100     ..... ..
        proc-v6         ..... ..
        proc-v7         .n... ..
        proc-xsc3       ..c.. ..
        proc-xscale     ..c.. .X 5

Legend:

a       section alignment of .proc.info.init and/or .init.data increased
        from 1 to 4

n       one or more name string symbols promoted to STT_OBJECT
c       one or mote cache_fns symbols structured promoted to STT_OBJECT
p       one or more processor_functions symbols promoted to global scope

u       undefined symbol no longer referenced by .size
        directive (typo fix)

Z       missing string terminator added to one of more name
        strings.  In principle, the missing terminator could lead
        to overruns.  In practice, the effect appears to get hidden
        by .align directives; but it's safer to add them anyway.

X       missing flush_icache_all entry inserted at the start of
        one or more cache_fns structures.  The extra field was
        created in:

            commit 81d11955 (ARM: 6405/1: Handle
            __flush_icache_all for CONFIG_SMP_ON_UP),

        breaking various proc-*.S.  Some were fixed by subsequent
        patches, e.g.

            commit c8c90860 (ARM: 6466/1: implement
            flush_icache_all for the rest of the CPUs).

        A few proc-*.S files appear to have been missed.

Processor-specific notes:

1       proc-arm7tdmi: spurious undefined symbol
        cpu_s3c4510b (caused by misspelled .type directive)
        eliminated

2       proc-arm925: size of __arm915_proc_info and
        __arm925_proc_info symbols changed (typo'd duplicate .size
        directive in original)

3       proc-mohawk: mohawk_processor_functions became
        STT_OBJECT (missing .type directive in original)

4       proc-mohawk: missing mohawk_flush_icache_all now
        implemented (thanks to Nicolas Pitre).

5       proc-xscale: missing flush_icache_all funtion in
        xscale_80200_A0_A1_cache_fns assumed to be the same as for
        xscale_cache_fns.

---
Dave Martin (40):
  ARM: mm: proc-macros: Add generic proc/cache/tlb struct definition
    macros
  ARM: assembler.h: Add string declaration macro
  ARM: mm: cache-fa: Use the new processor struct macros
  ARM: mm: cache-v3: Use the new processor struct macros
  ARM: mm: cache-v4: Use the new processor struct macros
  ARM: mm: cache-v4wb: Use the new processor struct macros
  ARM: mm: cache-v4wt: Use the new processor struct macros
  ARM: mm: cache-v6: Use the new processor struct macros
  ARM: mm: cache-v7: Use the new processor struct macros
  ARM: mm: proc-arm1020: Use the new processor struct macros
  ARM: mm: proc-arm1020e: Use the new processor struct macros
  ARM: mm: proc-arm1022: Use the new processor struct macros
  ARM: mm: proc-arm1026: Use the new processor struct macros
  ARM: mm: proc-arm6_7: Use the new processor struct macros
  ARM: mm: proc-arm720: Use the new processor struct macros
  ARM: mm: proc-arm740: Use the new processor struct macros
  ARM: mm: proc-arm7tdmi: Use the new processor struct macros
  ARM: mm: proc-arm920: Use the new processor struct macros
  ARM: mm: proc-arm922: Use the new processor struct macros
  ARM: mm: proc-arm925: Use the new processor struct macros
  ARM: mm: proc-arm926: Use the new processor struct macros
  ARM: mm: proc-arm940: Use the new processor struct macros
  ARM: mm: proc-arm946: Use the new processor struct macros
  ARM: mm: proc-arm9tdmi: Use the new processor struct macros
  ARM: mm: proc-fa526: Use the new processor struct macros
  ARM: mm: proc-feroceon: Use the new processor struct macros
  ARM: mm: proc-mohawk: Use the new processor struct macros
  ARM: mm: proc-sa110: Use the new processor struct macros
  ARM: mm: proc-sa1100: Use the new processor struct macros
  ARM: mm: proc-v6: Use the new processor struct macros
  ARM: mm: proc-v7: Use the new processor struct macros
  ARM: mm: proc-xsc3: Use new generic struct definition macros
  ARM: mm: proc-xscale: Use new generic struct definition macros
  ARM: mm: tlb-fa: Use the new processor struct macros
  ARM: mm: tlb-v3: Use the new processor struct macros
  ARM: mm: tlb-v4: Use the new processor struct macros
  ARM: mm: tlb-v4wb: Use the new processor struct macros
  ARM: mm: tlb-v4wbi: Use the new processor struct macros
  ARM: mm: tlb-v6: Use the new processor struct macros
  ARM: mm: tlb-v7: Use the new processor struct macros

 arch/arm/include/asm/assembler.h |    9 +
 arch/arm/mm/cache-fa.S           |   15 +-
 arch/arm/mm/cache-v3.S           |   15 +-
 arch/arm/mm/cache-v4.S           |   15 +-
 arch/arm/mm/cache-v4wb.S         |   15 +-
 arch/arm/mm/cache-v4wt.S         |   15 +-
 arch/arm/mm/cache-v6.S           |   15 +-
 arch/arm/mm/cache-v7.S           |   15 +-
 arch/arm/mm/proc-arm1020.S       |   45 +---
 arch/arm/mm/proc-arm1020e.S      |   52 +----
 arch/arm/mm/proc-arm1022.S       |   52 +----
 arch/arm/mm/proc-arm1026.S       |   53 +----
 arch/arm/mm/proc-arm6_7.S        |  166 +++----------
 arch/arm/mm/proc-arm720.S        |   85 ++-----
 arch/arm/mm/proc-arm740.S        |   42 +---
 arch/arm/mm/proc-arm7tdmi.S      |  216 +++-------------
 arch/arm/mm/proc-arm920.S        |   53 +----
 arch/arm/mm/proc-arm922.S        |   53 +----
 arch/arm/mm/proc-arm925.S        |   88 ++------
 arch/arm/mm/proc-arm926.S        |   51 +----
 arch/arm/mm/proc-arm940.S        |   51 +----
 arch/arm/mm/proc-arm946.S        |   53 +----
 arch/arm/mm/proc-arm9tdmi.S      |   78 ++-----
 arch/arm/mm/proc-fa526.S         |   38 +---
 arch/arm/mm/proc-feroceon.S      |  202 ++++------------
 arch/arm/mm/proc-macros.S        |   63 +++++
 arch/arm/mm/proc-mohawk.S        |   61 ++----
 arch/arm/mm/proc-sa110.S         |   39 +---
 arch/arm/mm/proc-sa1100.S        |   84 ++-----
 arch/arm/mm/proc-v6.S            |   34 +---
 arch/arm/mm/proc-v7.S            |   31 +--
 arch/arm/mm/proc-xsc3.S          |   90 ++------
 arch/arm/mm/proc-xscale.S        |  507 ++++++--------------------------------
 arch/arm/mm/tlb-fa.S             |    8 +-
 arch/arm/mm/tlb-v3.S             |    8 +-
 arch/arm/mm/tlb-v4.S             |    8 +-
 arch/arm/mm/tlb-v4wb.S           |    8 +-
 arch/arm/mm/tlb-v4wbi.S          |    8 +-
 arch/arm/mm/tlb-v6.S             |    8 +-
 arch/arm/mm/tlb-v7.S             |    9 +-
 40 files changed, 488 insertions(+), 1970 deletions(-)

-- 
1.7.4.1
