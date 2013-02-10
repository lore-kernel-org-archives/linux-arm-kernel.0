From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Sun, 10 Feb 2013 01:10:02 +0000
Subject: [PATCH 2/2] ARM: mm: mm->context.id fix for big-endian
In-Reply-To: <1360451709-19740-3-git-send-email-ben.dooks@codethink.co.uk>
References: <1360451709-19740-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360451709-19740-3-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <a1bfc188774f0bff0452d3a3ab5b2624@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2013 23:15, Ben Dooks wrote:
> Since the new ASID code introduced in
> b5466f8728527a05a493cc4abe9e6f034a1bbaab
> uses 64bit operations, when running in BE mode we see the values in
> mm->context.id swapped around as the lowest word is being stored in
> mm->context.id + 4, instead of + 0.

The one thing I have just realised with this is that we are no-longer
going to be storing the mm->context.id data in the sat was a pre the
ASID changes, which could confuse debuggers which assume they can read
the data.

Should we fix this the easy way below, or go and change the code
in arch/arm/mm/context.c to deal with re-arranging the atomic64
accesses when in big-endian mode?

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/mm/proc-macros.S |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> index eb6aa73..5a6a347 100644
> --- a/arch/arm/mm/proc-macros.S
> +++ b/arch/arm/mm/proc-macros.S
> @@ -40,7 +40,11 @@
>   * mmid - get context id from mm pointer (mm->context.id)
>   */
>  	.macro	mmid, rd, rn
> +#ifdef __ARMEB__
> +	ldr	\rd, [\rn, #MM_CONTEXT_ID + 4 ]
> +#else
>  	ldr	\rd, [\rn, #MM_CONTEXT_ID]
> +#endif
>  	.endm
>
>  /*
