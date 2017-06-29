From: will.deacon@arm.com (Will Deacon)
Date: Thu, 29 Jun 2017 11:28:51 +0100
Subject: [PATCH] arm64: fix endianness annotation for
 __apply_alternatives()/get_alt_insn()
In-Reply-To: <20170628145557.24454-1-luc.vanoostenryck@gmail.com>
References: <20170628145557.24454-1-luc.vanoostenryck@gmail.com>
Message-ID: <20170629102851.GF14607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 28, 2017 at 04:55:57PM +0200, Luc Van Oostenryck wrote:
> get_alt_insn() is used to read and create ARM instructions, which
> are always stored in memory in little-endian order. These values
> are thus correctly converted to/from native order when processed
> but the pointers used to hold the address of these instructions
> are declared as for native order values.
> 
> Fix this by declaring the pointers as __le32* instead of u32* and
> make the few appropriate needed changes.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  arch/arm64/kernel/alternative.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
> index 8840c109c..56bfda8cb 100644
> --- a/arch/arm64/kernel/alternative.c
> +++ b/arch/arm64/kernel/alternative.c
> @@ -60,7 +60,7 @@ static bool branch_insn_requires_update(struct alt_instr *alt, unsigned long pc)
>  
>  #define align_down(x, a)	((unsigned long)(x) & ~(((unsigned long)(a)) - 1))
>  
> -static u32 get_alt_insn(struct alt_instr *alt, u32 *insnptr, u32 *altinsnptr)
> +static u32 get_alt_insn(struct alt_instr *alt, __le32 *insnptr, __le32 *altinsnptr)
>  {
>  	u32 insn;
>  
> @@ -109,7 +109,7 @@ static void __apply_alternatives(void *alt_region, bool use_linear_alias)
>  {
>  	struct alt_instr *alt;
>  	struct alt_region *region = alt_region;
> -	u32 *origptr, *replptr, *updptr;
> +	__le32 *origptr, *replptr, *updptr;
>  
>  	for (alt = region->begin; alt < region->end; alt++) {
>  		u32 insn;
> @@ -122,9 +122,9 @@ static void __apply_alternatives(void *alt_region, bool use_linear_alias)
>  
>  		pr_info_once("patching kernel code\n");
>  
> -		origptr = ALT_ORIG_PTR(alt);
> -		replptr = ALT_REPL_PTR(alt);
> -		updptr = use_linear_alias ? (u32 *)lm_alias(origptr) : origptr;
> +		origptr = (__le32 __force *) ALT_ORIG_PTR(alt);
> +		replptr = (__le32 __force *) ALT_REPL_PTR(alt);

Why is the __force needed here?

Will
