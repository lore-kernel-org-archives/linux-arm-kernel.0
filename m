From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Sep 2018 10:50:09 +0100
Subject: [PATCH] arch/arm64/include/asm/jump_label.h: use asm_volatile_goto
In-Reply-To: <20180909154731.GA20381@gmail.com>
References: <20180909154731.GA20381@gmail.com>
Message-ID: <20180910095008.GB31531@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 09, 2018 at 05:47:31PM +0200, Miguel Ojeda wrote:
> All other uses of "asm goto" go through asm_volatile_goto
> (including the arm version of the same file). For consistency,
> use it here as well.
> 
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>  arch/arm64/include/asm/jump_label.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, I'll pick this up as a fix.

Will

> diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> index 1b5e0e843c3a..7e2b3e360086 100644
> --- a/arch/arm64/include/asm/jump_label.h
> +++ b/arch/arm64/include/asm/jump_label.h
> @@ -28,7 +28,7 @@
>  
>  static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
>  {
> -	asm goto("1: nop\n\t"
> +	asm_volatile_goto("1: nop\n\t"
>  		 ".pushsection __jump_table,  \"aw\"\n\t"
>  		 ".align 3\n\t"
>  		 ".quad 1b, %l[l_yes], %c0\n\t"
> @@ -42,7 +42,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
>  
>  static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
>  {
> -	asm goto("1: b %l[l_yes]\n\t"
> +	asm_volatile_goto("1: b %l[l_yes]\n\t"
>  		 ".pushsection __jump_table,  \"aw\"\n\t"
>  		 ".align 3\n\t"
>  		 ".quad 1b, %l[l_yes], %c0\n\t"
> -- 
> 2.17.1
> 
