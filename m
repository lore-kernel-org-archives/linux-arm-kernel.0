From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 17 Sep 2013 12:35:48 -0400 (EDT)
Subject: [PATCH] ARM: fix Thumb-2 bug in AES assembler code
In-Reply-To: <1379434519-23299-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1379434519-23299-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <alpine.LFD.2.03.1309171234120.20709@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Sep 2013, Ard Biesheuvel wrote:

> Patch 638591c enabled building the AES assembler code in Thumb2 mode.
> However, this code uses arithmetic involving PC rather than adr{l}
> instructions to generate PC-relative references to the lookup tables,
> and this needs to take into account the different PC offset when
> running in Thumb mode.

Wouldn't it be better to fix this using adr instead?


> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> This needs cc to stable for 3.10/3.11 as well.
> 
> 
>  arch/arm/crypto/aes-armv4.S | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/crypto/aes-armv4.S b/arch/arm/crypto/aes-armv4.S
> index 19d6cd6..33c30ab 100644
> --- a/arch/arm/crypto/aes-armv4.S
> +++ b/arch/arm/crypto/aes-armv4.S
> @@ -148,7 +148,8 @@ AES_Te:
>  @ 		 const AES_KEY *key) {
>  .align	5
>  ENTRY(AES_encrypt)
> -	sub	r3,pc,#8		@ AES_encrypt
> +ARM(	sub	r3,pc,#8	)	@ AES_encrypt
> +THUMB(	sub	r3,pc,#4	)
>  	stmdb   sp!,{r1,r4-r12,lr}
>  	mov	r12,r0		@ inp
>  	mov	r11,r2
> @@ -381,7 +382,8 @@ _armv4_AES_encrypt:
>  .align	5
>  ENTRY(private_AES_set_encrypt_key)
>  _armv4_AES_set_encrypt_key:
> -	sub	r3,pc,#8		@ AES_set_encrypt_key
> +ARM(	sub	r3,pc,#8	)	@ AES_set_encrypt_key
> +THUMB(	sub	r3,pc,#4	)
>  	teq	r0,#0
>  	moveq	r0,#-1
>  	beq	.Labrt
> @@ -843,8 +845,9 @@ AES_Td:
>  @ 		 const AES_KEY *key) {
>  .align	5
>  ENTRY(AES_decrypt)
> -	sub	r3,pc,#8		@ AES_decrypt
> -	stmdb   sp!,{r1,r4-r12,lr}
> +ARM(	sub	r3,pc,#8	)	@ AES_decrypt
> +THUMB(	sub	r3,pc,#4	)
> +		stmdb   sp!,{r1,r4-r12,lr}
>  	mov	r12,r0		@ inp
>  	mov	r11,r2
>  	sub	r10,r3,#AES_decrypt-AES_Td		@ Td
> -- 
> 1.8.1.2
> 
