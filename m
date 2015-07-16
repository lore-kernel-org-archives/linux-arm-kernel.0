From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Jul 2015 19:19:29 +0100
Subject: [PATCH] arm64: alternative: Provide if/else/endif assembler macros
In-Reply-To: <1436536130-31438-1-git-send-email-daniel.thompson@linaro.org>
References: <1436536130-31438-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20150716181929.GU26390@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Fri, Jul 10, 2015 at 02:48:50PM +0100, Daniel Thompson wrote:
> The existing alternative_insn macro has some limitations that make it
> hard to work with. In partiuclar the fact it takes instructions from it
> own macro arguments means it doesn't play very nicely with C pre-processor
> macros because the macro arguments look like a string to the C
> pre-processor. Workarounds are (probably) possible but things start to
> look ugly.
> 
> Introduce an alternative set of macros that allows instructions to be
> presented to the assembler as normal and switch everything over to the
> new macros.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> 
> Notes:
>     To be honest these if not/else/endif macros are simply more readable
>     than the original macro and that might be enough to justify them on
>     their own. However below is an example that is needlessly hard to
>     write without them because ICC_PMR_EL1 is a C pre-processor macro.
>     
>      	.macro	disable_irq, tmp
>      	mov	\tmp, #ICC_PMR_EL1_MASKED
>     alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
>     	msr	daifset, #2
>     alternative_else
>      	msr_s	ICC_PMR_EL1, \tmp
>     alternative_endif
>     	.endm
>     
>     The new macros have received a fair degree of testing because I have
>     based my (not published since March) pseudo-NMI patch set on them.
> 
>  arch/arm64/include/asm/alternative.h | 18 ++++++++++++------
>  arch/arm64/kernel/entry.S            | 29 +++++++++++++----------------
>  arch/arm64/kvm/hyp.S                 | 12 ++++++++++--
>  arch/arm64/mm/cache.S                |  7 ++++++-
>  4 files changed, 41 insertions(+), 25 deletions(-)

After some consideration, I think I prefer your suggestion over what we
currently have in mainline. However, there are a bunch of patches that
are candidates for 4.3 which will conflict horribly with this.

Would you be able to:

  (1) Split this up so that you have a patch introducing the new macro,
      then a patch converting entry.S and cache.S then a separate one
      for kvm/hyp.S?

  (2) Keep alternative_insn around for the moment

  (3) Once the dust has settled for 4.3, we can see how easy the old
      macro is to remove

Sound ok to you?

Cheers,

Will
