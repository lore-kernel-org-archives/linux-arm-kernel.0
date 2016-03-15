From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 15 Mar 2016 19:03:55 +0100
Subject: [PATCH] arm64: fix KASLR boot-time I-cache maintenance
In-Reply-To: <1458040977-27558-1-git-send-email-mark.rutland@arm.com>
References: <1458040977-27558-1-git-send-email-mark.rutland@arm.com>
Message-ID: <CAKv+Gu_z=RsdRZyVRTrh1akO9xv7jnSjJRPZMAp4DrML-E4pQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 March 2016 at 12:22, Mark Rutland <mark.rutland@arm.com> wrote:
> Commit f80fb3a3d50843a4 ("arm64: add support for kernel ASLR") missed a
> DSB necessary to complete I-cache maintenance in the primary boot path,
> and hence stale instructions may still be present in the I-cache and may
> be executed until the I-cache maintenance naturally completes.
>
> Since commit 8ec41987436d566f ("arm64: mm: ensure patched kernel text is
> fetched from PoU"), all CPUs invalidate their I-caches after their MMU
> is enabled. Prior a CPU's MMU having been enabled, arbitrary lines may
> have been fetched from the PoC into I-caches. We never patch text
> expected to be executed with the MMU off. Thus, it is unnecessary to
> perform broadcast I-cache maintenance in the primary boot path.
>
> This patch reduces the scope of the I-cache maintenance to the local
> CPU, and adds the missing DSB with similar scope, matching prior
> maintenance in the primary boot path.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesehvuel <ard.biesheuvel@linaro.org>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/head.S | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> Note: this applies atop of the arm64 for-next/core branch.
>
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 50c2134..1672ca9 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -766,8 +766,9 @@ __enable_mmu:
>
>         msr     sctlr_el1, x19                  // re-enable the MMU
>         isb
> -       ic      ialluis                         // flush instructions fetched
> -       isb                                     // via old mapping
> +       ic      iallu                           // flush instructions fetched
> +       dsb     nsh                             // via old mapping
> +       isb
>         add     x27, x27, x23                   // relocated __mmap_switched
>  #endif
>         br      x27
> --
> 1.9.1
>
