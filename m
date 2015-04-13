From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Apr 2015 13:53:12 +0100
Subject: [PATCH v3 01/11] arm64: reduce ID map to a single page
In-Reply-To: <1428674035-26603-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1428674035-26603-1-git-send-email-ard.biesheuvel@linaro.org>
 <1428674035-26603-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150413125312.GE4076@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Fri, Apr 10, 2015 at 02:53:45PM +0100, Ard Biesheuvel wrote:
> Commit ea8c2e112445 ("arm64: Extend the idmap to the whole kernel
> image") changed the early page table code so that the entire kernel
> Image is covered by the identity map. This allows functions that
> need to enable or disable the MMU to reside anywhere in the kernel
> Image.
> 
> However, this change has the unfortunate side effect that the Image
> cannot cross a physical 512 MB alignment boundary anymore, since the
> early page table code cannot deal with the Image crossing a /virtual/
> 512 MB alignment boundary.
> 
> So instead, reduce the ID map to a single page, that is populated by
> the contents of the .idmap.text section. Only three functions reside
> there at the moment: __enable_mmu(), cpu_resume_mmu() and cpu_reset().

It would be worth mentioning in the cover letter which branch this is
based on (arm64 for-next/core?), given the __enable_mmu + __turn_mmu_on
folding isn't in mainline yet.

> If new code is introduced that needs to manipulate the MMU state, it
> should be added to this section as well.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Other than the minor nit below this looks good to me, and I've given it
a spin on Juno with 4K and 64K pages. Assuming you can fix that up:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

> @@ -669,6 +669,7 @@ ENDPROC(__secondary_switched)
>   *
>   * other registers depend on the function called upon completion
>   */
> +	.section	".idmap.text", #alloc, #execinstr

We should use "ax" rather than #alloc, #execinstr to keep things
consistent, unless there's some difference that I'm missing?

I've tested the patch locally with all instances changed to "ax".

Thanks,
Mark.
