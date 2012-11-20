From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 20 Nov 2012 18:46:16 +0000
Subject: [PATCH] arm/crypto: Make asm SHA-1 and AES code Thumb-2 compatible
In-Reply-To: <alpine.LFD.2.02.1211151723590.1238@xanadu.home>
References: <20121030100742.17910.70241.stgit@localhost6.localdomain6>
 <1352119337-22619-1-git-send-email-dave.martin@linaro.org>
 <alpine.LFD.2.02.1211151723590.1238@xanadu.home>
Message-ID: <20121120184616.GB1969@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 05:26:44PM -0500, Nicolas Pitre wrote:
> On Mon, 5 Nov 2012, Dave Martin wrote:
> 
> > This patch fixes aes-armv4.S and sha1-armv4-large.S to work
> > natively in Thumb.  This allows ARM/Thumb interworking workarounds
> > to be removed.
> > 
> > I also take the opportunity to convert some explicit assembler
> > directives for exported functions to the standard
> > ENTRY()/ENDPROC().
> > 
> > For the code itself:
> > 
> >   * In sha1_block_data_order, use of TEQ with sp is deprecated in
> >     ARMv7 and not supported in Thumb.  For the branches back to
> >     .L_00_15 and .L_40_59, the TEQ is converted to a CMP, under the
> >     assumption that clobbering the C flag here will not cause
> >     incorrect behaviour.
> > 
> >     For the first branch back to .L_20_39_or_60_79 the C flag is
> >     important, so sp is moved temporarily into another register so
> >     that TEQ can be used for the comparison.
> > 
> >   * In the AES code, most forms of register-indexed addressing with
> >     shifts and rotates are not permitted for loads and stores in
> >     Thumb, so the address calculation is done using a separate
> >     instruction for the Thumb case.
> > 
> >     The resulting code is unlikely to be optimally scheduled, but
> >     it should not have a large impact given the overall size of the
> >     code.  I haven't run any benchmarks.
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> I didn't test it either, only reviewed the patch.  Looks obvious enough.  
> And if something is wrong, then it is very unlikely to be unnoticed in 
> practice.

I'd prefer someone tests this before I upload to the patch system.

I can do that, but I'm busy so it won't happen quickly...

Or do you think I should just go ahead?

Cheers
---Dave

> 
> 
> 
> 
> > ---
> > 
> > For now, I have built the code but not tested it.  I'll consider the
> > patch an RFC until someone gives me a Tested-by (or failing that, when I
> > get around to testing it myself...)
> > 
> > Cheers
> > ---Dave
> > 
> >  arch/arm/crypto/aes-armv4.S        |   64 +++++++++++------------------------
> >  arch/arm/crypto/sha1-armv4-large.S |   24 +++++--------
> >  2 files changed, 29 insertions(+), 59 deletions(-)
> > 
> > diff --git a/arch/arm/crypto/aes-armv4.S b/arch/arm/crypto/aes-armv4.S
> > index e59b1d5..19d6cd6 100644
> > --- a/arch/arm/crypto/aes-armv4.S
> > +++ b/arch/arm/crypto/aes-armv4.S
> > @@ -34,8 +34,9 @@
> >  @ A little glue here to select the correct code below for the ARM CPU
> >  @ that is being targetted.
> >  
> > +#include <linux/linkage.h>
> > +
> >  .text
> > -.code	32
> >  
> >  .type	AES_Te,%object
> >  .align	5
> > @@ -145,10 +146,8 @@ AES_Te:
> >  
> >  @ void AES_encrypt(const unsigned char *in, unsigned char *out,
> >  @ 		 const AES_KEY *key) {
> > -.global AES_encrypt
> > -.type   AES_encrypt,%function
> >  .align	5
> > -AES_encrypt:
> > +ENTRY(AES_encrypt)
> >  	sub	r3,pc,#8		@ AES_encrypt
> >  	stmdb   sp!,{r1,r4-r12,lr}
> >  	mov	r12,r0		@ inp
> > @@ -239,15 +238,8 @@ AES_encrypt:
> >  	strb	r6,[r12,#14]
> >  	strb	r3,[r12,#15]
> >  #endif
> > -#if __ARM_ARCH__>=5
> >  	ldmia	sp!,{r4-r12,pc}
> > -#else
> > -	ldmia   sp!,{r4-r12,lr}
> > -	tst	lr,#1
> > -	moveq	pc,lr			@ be binary compatible with V4, yet
> > -	.word	0xe12fff1e			@ interoperable with Thumb ISA:-)
> > -#endif
> > -.size	AES_encrypt,.-AES_encrypt
> > +ENDPROC(AES_encrypt)
> >  
> >  .type   _armv4_AES_encrypt,%function
> >  .align	2
> > @@ -386,10 +378,8 @@ _armv4_AES_encrypt:
> >  	ldr	pc,[sp],#4		@ pop and return
> >  .size	_armv4_AES_encrypt,.-_armv4_AES_encrypt
> >  
> > -.global private_AES_set_encrypt_key
> > -.type   private_AES_set_encrypt_key,%function
> >  .align	5
> > -private_AES_set_encrypt_key:
> > +ENTRY(private_AES_set_encrypt_key)
> >  _armv4_AES_set_encrypt_key:
> >  	sub	r3,pc,#8		@ AES_set_encrypt_key
> >  	teq	r0,#0
> > @@ -658,15 +648,11 @@ _armv4_AES_set_encrypt_key:
> >  
> >  .Ldone:	mov	r0,#0
> >  	ldmia   sp!,{r4-r12,lr}
> > -.Labrt:	tst	lr,#1
> > -	moveq	pc,lr			@ be binary compatible with V4, yet
> > -	.word	0xe12fff1e			@ interoperable with Thumb ISA:-)
> > -.size	private_AES_set_encrypt_key,.-private_AES_set_encrypt_key
> > +.Labrt:	mov	pc,lr
> > +ENDPROC(private_AES_set_encrypt_key)
> >  
> > -.global private_AES_set_decrypt_key
> > -.type   private_AES_set_decrypt_key,%function
> >  .align	5
> > -private_AES_set_decrypt_key:
> > +ENTRY(private_AES_set_decrypt_key)
> >  	str	lr,[sp,#-4]!            @ push lr
> >  #if 0
> >  	@ kernel does both of these in setkey so optimise this bit out by
> > @@ -748,15 +734,8 @@ private_AES_set_decrypt_key:
> >  	bne	.Lmix
> >  
> >  	mov	r0,#0
> > -#if __ARM_ARCH__>=5
> >  	ldmia	sp!,{r4-r12,pc}
> > -#else
> > -	ldmia   sp!,{r4-r12,lr}
> > -	tst	lr,#1
> > -	moveq	pc,lr			@ be binary compatible with V4, yet
> > -	.word	0xe12fff1e			@ interoperable with Thumb ISA:-)
> > -#endif
> > -.size	private_AES_set_decrypt_key,.-private_AES_set_decrypt_key
> > +ENDPROC(private_AES_set_decrypt_key)
> >  
> >  .type	AES_Td,%object
> >  .align	5
> > @@ -862,10 +841,8 @@ AES_Td:
> >  
> >  @ void AES_decrypt(const unsigned char *in, unsigned char *out,
> >  @ 		 const AES_KEY *key) {
> > -.global AES_decrypt
> > -.type   AES_decrypt,%function
> >  .align	5
> > -AES_decrypt:
> > +ENTRY(AES_decrypt)
> >  	sub	r3,pc,#8		@ AES_decrypt
> >  	stmdb   sp!,{r1,r4-r12,lr}
> >  	mov	r12,r0		@ inp
> > @@ -956,15 +933,8 @@ AES_decrypt:
> >  	strb	r6,[r12,#14]
> >  	strb	r3,[r12,#15]
> >  #endif
> > -#if __ARM_ARCH__>=5
> >  	ldmia	sp!,{r4-r12,pc}
> > -#else
> > -	ldmia   sp!,{r4-r12,lr}
> > -	tst	lr,#1
> > -	moveq	pc,lr			@ be binary compatible with V4, yet
> > -	.word	0xe12fff1e			@ interoperable with Thumb ISA:-)
> > -#endif
> > -.size	AES_decrypt,.-AES_decrypt
> > +ENDPROC(AES_decrypt)
> >  
> >  .type   _armv4_AES_decrypt,%function
> >  .align	2
> > @@ -1064,7 +1034,9 @@ _armv4_AES_decrypt:
> >  	and	r9,lr,r1,lsr#8
> >  
> >  	ldrb	r7,[r10,r7]		@ Td4[s1>>0]
> > -	ldrb	r1,[r10,r1,lsr#24]	@ Td4[s1>>24]
> > + ARM(	ldrb	r1,[r10,r1,lsr#24]  )	@ Td4[s1>>24]
> > + THUMB(	add	r1,r10,r1,lsr#24    ) 	@ Td4[s1>>24]
> > + THUMB(	ldrb	r1,[r1]		    )
> >  	ldrb	r8,[r10,r8]		@ Td4[s1>>16]
> >  	eor	r0,r7,r0,lsl#24
> >  	ldrb	r9,[r10,r9]		@ Td4[s1>>8]
> > @@ -1077,7 +1049,9 @@ _armv4_AES_decrypt:
> >  	ldrb	r8,[r10,r8]		@ Td4[s2>>0]
> >  	and	r9,lr,r2,lsr#16
> >  
> > -	ldrb	r2,[r10,r2,lsr#24]	@ Td4[s2>>24]
> > + ARM(	ldrb	r2,[r10,r2,lsr#24]  )	@ Td4[s2>>24]
> > + THUMB(	add	r2,r10,r2,lsr#24    )	@ Td4[s2>>24]
> > + THUMB(	ldrb	r2,[r2]		    )
> >  	eor	r0,r0,r7,lsl#8
> >  	ldrb	r9,[r10,r9]		@ Td4[s2>>16]
> >  	eor	r1,r8,r1,lsl#16
> > @@ -1090,7 +1064,9 @@ _armv4_AES_decrypt:
> >  	and	r9,lr,r3		@ i2
> >  
> >  	ldrb	r9,[r10,r9]		@ Td4[s3>>0]
> > -	ldrb	r3,[r10,r3,lsr#24]	@ Td4[s3>>24]
> > + ARM(	ldrb	r3,[r10,r3,lsr#24]  )	@ Td4[s3>>24]
> > + THUMB(	add	r3,r10,r3,lsr#24    )	@ Td4[s3>>24]
> > + THUMB(	ldrb	r3,[r3]		    )
> >  	eor	r0,r0,r7,lsl#16
> >  	ldr	r7,[r11,#0]
> >  	eor	r1,r1,r8,lsl#8
> > diff --git a/arch/arm/crypto/sha1-armv4-large.S b/arch/arm/crypto/sha1-armv4-large.S
> > index 7050ab1..92c6eed 100644
> > --- a/arch/arm/crypto/sha1-armv4-large.S
> > +++ b/arch/arm/crypto/sha1-armv4-large.S
> > @@ -51,13 +51,12 @@
> >  @ Profiler-assisted and platform-specific optimization resulted in 10%
> >  @ improvement on Cortex A8 core and 12.2 cycles per byte.
> >  
> > -.text
> > +#include <linux/linkage.h>
> >  
> > -.global	sha1_block_data_order
> > -.type	sha1_block_data_order,%function
> > +.text
> >  
> >  .align	2
> > -sha1_block_data_order:
> > +ENTRY(sha1_block_data_order)
> >  	stmdb	sp!,{r4-r12,lr}
> >  	add	r2,r1,r2,lsl#6	@ r2 to point at the end of r1
> >  	ldmia	r0,{r3,r4,r5,r6,r7}
> > @@ -194,7 +193,7 @@ sha1_block_data_order:
> >  	eor	r10,r10,r7,ror#2		@ F_00_19(B,C,D)
> >  	str	r9,[r14,#-4]!
> >  	add	r3,r3,r10			@ E+=F_00_19(B,C,D)
> > -	teq	r14,sp
> > +	cmp	r14,sp
> >  	bne	.L_00_15		@ [((11+4)*5+2)*3]
> >  #if __ARM_ARCH__<7
> >  	ldrb	r10,[r1,#2]
> > @@ -374,7 +373,9 @@ sha1_block_data_order:
> >  						@ F_xx_xx
> >  	add	r3,r3,r9			@ E+=X[i]
> >  	add	r3,r3,r10			@ E+=F_20_39(B,C,D)
> > -	teq	r14,sp			@ preserve carry
> > + ARM(	teq	r14,sp		)	@ preserve carry
> > + THUMB(	mov	r11,sp		)
> > + THUMB(	teq	r14,r11		)	@ preserve carry
> >  	bne	.L_20_39_or_60_79	@ [+((12+3)*5+2)*4]
> >  	bcs	.L_done			@ [+((12+3)*5+2)*4], spare 300 bytes
> >  
> > @@ -466,7 +467,7 @@ sha1_block_data_order:
> >  	add	r3,r3,r9			@ E+=X[i]
> >  	add	r3,r3,r10			@ E+=F_40_59(B,C,D)
> >  	add	r3,r3,r11,ror#2
> > -	teq	r14,sp
> > +	cmp	r14,sp
> >  	bne	.L_40_59		@ [+((12+5)*5+2)*4]
> >  
> >  	ldr	r8,.LK_60_79
> > @@ -485,19 +486,12 @@ sha1_block_data_order:
> >  	teq	r1,r2
> >  	bne	.Lloop			@ [+18], total 1307
> >  
> > -#if __ARM_ARCH__>=5
> >  	ldmia	sp!,{r4-r12,pc}
> > -#else
> > -	ldmia	sp!,{r4-r12,lr}
> > -	tst	lr,#1
> > -	moveq	pc,lr			@ be binary compatible with V4, yet
> > -	.word	0xe12fff1e			@ interoperable with Thumb ISA:-)
> > -#endif
> >  .align	2
> >  .LK_00_19:	.word	0x5a827999
> >  .LK_20_39:	.word	0x6ed9eba1
> >  .LK_40_59:	.word	0x8f1bbcdc
> >  .LK_60_79:	.word	0xca62c1d6
> > -.size	sha1_block_data_order,.-sha1_block_data_order
> > +ENDPROC(sha1_block_data_order)
> >  .asciz	"SHA1 block transform for ARMv4, CRYPTOGAMS by <appro@openssl.org>"
> >  .align	2
> > -- 
> > 1.7.4.1
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
