From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 11 Feb 2011 09:43:45 +0000
Subject: [PATCH v2 5/5] ARM: omap3: Thumb-2 compatibility for sleep34xx.S
In-Reply-To: <87d3mzh6vq.fsf@ti.com>
References: <1296756161-26092-1-git-send-email-dave.martin@linaro.org>
	<1296756161-26092-6-git-send-email-dave.martin@linaro.org>
	<87d3mzh6vq.fsf@ti.com>
Message-ID: <AANLkTimMdFPpjdO_A1yyYUpSnSbo9gkn_-D5132KWKyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 10, 2011 at 10:17 PM, Kevin Hilman <khilman@ti.com> wrote:
> Dave Martin <dave.martin@linaro.org> writes:
>
>> ?* Use BSYM() to get the correct Thumb branch address
>> ? ?for adr <Rd>, <label>
>>
>> ?* Fix an out-of-range ADR when building for ARM
>>
>> ?* Correctly call es3_sdrc_fix as Thumb when copied to SRAM.
>>
>> ?* Remove deprecated/undefined PC-relative stores
>>
>> ?* Add the required ENDPROC() directive for each ENTRY().
>>
>> ?* .align before data words
>>
>> Signed-off-by: Dave Martin <dave.martin@linaro.org>
>
> I'm attempting to test this series with OMAP PM, but some changes here
> don't compile for me.
>
> My toolchain is: gcc version 4.5.1 (Sourcery G++ Lite 2010.09-50)
>
> First, I merged your arm/omap-thumb2+merged branch with my pm branch
> from git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
>
> There were some minor conflicts here, but they looked simple enough and
> I just resolved in favor of your branch.

Thanks for giving it a try.

>
> Trying to build with CONFIG_THUMB2_KERNEL=y, I ran into a compile
> problem...
>
>

[...]

>> + ? ? adr ? ? r0, es3_sdrc_fix ? ? ? ?@ Not using BSYM clears the Thumb bit.
>
> This fails to compile:
>
> /work/kernel/omap/pm/arch/arm/mach-omap2/sleep34xx.S: Assembler messages:
> /work/kernel/omap/pm/arch/arm/mach-omap2/sleep34xx.S:361: Error: invalid immediate for address calculation (value = 0x00000004)

Unfortunately, this is caused by a bug in the assembler.
arch/arm/kernel/relocate_kernel.S also suffers from the same bug when
built with CONFIG_THUMB2_KERNEL.

If you had got as far a linking, it's likely you would hit a
'reference to discarded section problem' error in the linker, due to
discarding of some sections referenced by SMP_ON_UP fixups.

If you merge the 3 extra patches from dirty/arm/omap-thumb2+merged it
should resolve these issues, but how to fix these things upstream is
still under discussion.

Cheers
---Dave
