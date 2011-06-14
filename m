From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 14 Jun 2011 11:58:20 +0100
Subject: [RFC PATCH v2 0/5] Add generic macros for declaring various CPU
	structs
Message-ID: <1308049105-16080-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on previous discussions, this series provides an alternative
macro for defining CPU-specific structures compactly.

I don't get to have so much fun with macros in this version, but
it's more straightforward and actually allows the declarations to
be collapsed down further by taking advantage of common naming
conventions.

In this RFC, only the arch names, processor_functions and
cache_functions are turned into macros, to show how this could
work.  This could be straightforwardly extended to cover tlb_fns,
but proc_info is more complex and may require a bit more thought.

A couple of files are ported to use the macros as an example.

These patches are for illustration only and **untested** (although
I have build-tested omap2plus_defconfig).

Unresolved issues:

 * The architecture/CPU name strings were previously split out into
   separate places, with the CPU name in .text and the other
   strings in .rodata.  This looked anomalous, so now a common
   mergeable string section .rodata.str is used instead.  This can
   be changed if needed.

 * For consistency, I've renamed the arch/CPU name string labels.
   If that is seen as unnecessary churn, it can be undone.

 * It's unclear whether it's better to switch sections inside the
   macros or outside.  Currently I switch inside, but the previous
   section is always restored using .popsection at the end of the
   macro to avoid confusion.  I'm assuming that there will never
   be a need to put any of this data in a custom section: if that's
   a bad assumption, we could move the section directives back
   outside the macros.

Dave Martin (5):
  ARM: mm: Add generic proc/arch struct definition macros
  ARM: proc-v7: Use new generic struct definition macros
  ARM: cache-v7: Use new generic struct definition macros
  ARM: proc-v6: Use new generic struct definition macros
  ARM: cache-v6: Use new generic struct definition macros

 arch/arm/mm/cache-v6.S    |   16 +--------
 arch/arm/mm/cache-v7.S    |   16 +--------
 arch/arm/mm/proc-macros.S |   79 +++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/proc-v6.S     |   43 +++---------------------
 arch/arm/mm/proc-v7.S     |   46 ++++---------------------
 5 files changed, 94 insertions(+), 106 deletions(-)

-- 
1.7.4.1
