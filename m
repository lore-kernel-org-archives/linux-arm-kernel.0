From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 22 Jul 2015 12:21:00 +0100
Subject: [PATCH v3 0/5] arm64: alternative: Provide if/else/endif assembler
 macros
In-Reply-To: <1436536130-31438-1-git-send-email-daniel.thompson@linaro.org>
References: <1436536130-31438-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1437564065-4356-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will: This is a split out version of previous patch, as requested. I have
      retained a patch at the send of the series to nix alternative_insn
      but there's no need to take this one for 4.3. Likewise I've fully
      split out all the switch-over patches so you can just drop them
      if they bring any merge trouble.

The existing alternative_insn macro has some limitations that make it
hard to work with. In particular the fact it takes instructions from it
own macro arguments means it doesn't play very nicely with C pre-processor
macros because the macro arguments look like a string to the C
pre-processor. Workarounds are (probably) possible but things start to
look ugly.

This patchset introduces new macros that allow instructions to be
presented to the assembler as normal and overcomes these limitations,
together with patches to switch all existing users to the new macros.

My view is that these if_not/else/endif macros are more readable
than the original macro and that alone might be enough to justify them.
However below is an concrete example of an alterntive sequence that is
needlessly hard to write without them because ICC_PMR_EL1 is a C
pre-processor macro.

 	.macro	disable_irq, tmp
 	mov	\tmp, #ICC_PMR_EL1_MASKED
alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
	msr	daifset, #2
alternative_else
 	msr_s	ICC_PMR_EL1, \tmp
alternative_endif
	.endm

The new macros have received a fair degree of testing because I have
based my (not published since March) pseudo-NMI patch set on them.

v3:

 * Corrected some technical and spelling errors in the comments
   (Will Deacon).

v2:

 * Split big patch out into atomized components (Will Deacon).
   To show where I would like to go I have retained a patch to remove
   assembler_insn() from the code base although, based on Will's email
   I don't anticipate this patch being taken for 4.3.

 * Add some comments to make clear the constraints imposed on alternative
   sequences.

Daniel Thompson (5):
  arm64: alternative: Provide if/else/endif assembler macros
  arm64: mm: Adopt new alternative assembler macros
  arm64: kernel: Adopt new alternative assembler macros
  arm64: kvm: Adopt new alternative assembler macros
  arm64: alternative: Remove alternative_insn macro

 arch/arm64/include/asm/alternative.h | 41 ++++++++++++++++++++++++++++++------
 arch/arm64/kernel/entry.S            | 29 ++++++++++++-------------
 arch/arm64/kvm/hyp.S                 | 12 +++++++++--
 arch/arm64/mm/cache.S                |  7 +++++-
 4 files changed, 64 insertions(+), 25 deletions(-)

--
2.4.3
