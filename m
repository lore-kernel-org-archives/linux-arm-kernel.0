From: labbott@redhat.com (Laura Abbott)
Date: Mon, 19 Sep 2016 11:28:49 -0700
Subject: [RFC] arm64: Ensure proper addressing for ldnp/stnp
In-Reply-To: <1474306586-25118-1-git-send-email-bdegraaf@codeaurora.org>
References: <1474306586-25118-1-git-send-email-bdegraaf@codeaurora.org>
Message-ID: <50fcc549-d785-6332-83bd-292a4f44e8d4@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2016 10:36 AM, Brent DeGraaf wrote:
> According to section 6.3.8 of the ARM Programmer's Guide, non-temporal
> loads and stores do not verify that address dependency is met between a
> load of an address to a register and a subsequent non-temporal load or
> store using that address on the executing PE. Therefore, context switch
> code and subroutine calls that use non-temporally accessed addresses as
> parameters that might depend on a load of an address into an argument
> register must ensure that ordering requirements are met by introducing
> a barrier prior to the successive non-temporal access.  Add appropriate
> barriers whereever this specific situation comes into play.
>

Was this found by code inspection or is there a (public) exciting test
case to observe this behavior?

Thanks,
Laura

> Signed-off-by: Brent DeGraaf <bdegraaf@codeaurora.org>
> ---
>  arch/arm64/kernel/entry.S  | 1 +
>  arch/arm64/lib/copy_page.S | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 441420c..982c4d3 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -679,6 +679,7 @@ ENTRY(cpu_switch_to)
>  	ldp	x27, x28, [x8], #16
>  	ldp	x29, x9, [x8], #16
>  	ldr	lr, [x8]
> +	dmb	nshld	// Existence of instructions with loose load-use dependencies (e.g. ldnp/stnp) make this barrier necessary
>  	mov	sp, x9
>  	and	x9, x9, #~(THREAD_SIZE - 1)
>  	msr	sp_el0, x9
> diff --git a/arch/arm64/lib/copy_page.S b/arch/arm64/lib/copy_page.S
> index 4c1e700..21c6892 100644
> --- a/arch/arm64/lib/copy_page.S
> +++ b/arch/arm64/lib/copy_page.S
> @@ -47,6 +47,8 @@ alternative_endif
>  	ldp	x14, x15, [x1, #96]
>  	ldp	x16, x17, [x1, #112]
>
> +	dmb	nshld // In case x0 (for stnp) is dependent on a load
> +
>  	mov	x18, #(PAGE_SIZE - 128)
>  	add	x1, x1, #128
>  1:
>
