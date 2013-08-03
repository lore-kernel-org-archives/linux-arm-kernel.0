From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 2 Aug 2013 23:40:53 -0400 (EDT)
Subject: [PATCH v2 5/6] ARM: mm: Update runtime patching code to THUMB2
 mode
In-Reply-To: <1375289086-5315-6-git-send-email-santosh.shilimkar@ti.com>
References: <1375289086-5315-1-git-send-email-santosh.shilimkar@ti.com>
 <1375289086-5315-6-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <alpine.LFD.2.03.1308022333470.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 31 Jul 2013, Santosh Shilimkar wrote:

> From: Sricharan R <r.sricharan@ti.com>
> 
> Update the runtime patching  code to support Thumb2. In testing the
> 64 bit patching code, the issue was uncovered.
> 
> For better review, the patch is kept separate. If needed it can be
> merged into "ARM: LPAE: Correct virt_to_phys patching for 64 bit
> physical addresses"
> 
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> 
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> [santosh.shilimkar at ti.com: reduced #ifdef, updated commit log]
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/kernel/head.S |   69 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 40 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index aa3b0f7..a70d330 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -573,62 +573,73 @@ ENDPROC(__fixup_pv_table)
>  
>  	.text
>  __fixup_a_pv_table:
> -#ifdef CONFIG_THUMB2_KERNEL
> -	lsls	r6, #24
> -	beq	2f
> -	clz	r7, r6
> -	lsr	r6, #24
> -	lsl	r6, r7
> -	bic	r6, #0x0080
> -	lsrs	r7, #1
> -	orrcs	r6, #0x0080
> -	orr	r6, r6, r7, lsl #12
> -	orr	r6, #0x4000
> -	b	2f
> -1:	add     r7, r3
> -	ldrh	ip, [r7, #2]
> -	and	ip, 0x8f00
> -	orr	ip, r6	@ mask in offset bits 31-24
> -	strh	ip, [r7, #2]
> -2:	cmp	r4, r5
> -	ldrcc	r7, [r4], #4	@ use branch for delay slot
> -	bcc	1b
> -	bx	lr
> -#else
>  	adr	r0, 5f
>  	b	4f
>  1:	ldr	ip, [r7, r3]
> + THUMB(	1:	add	r7, r3)
> + THUMB(	ldrh	ip, [r7])
> + THUMB(	ldrh	r6, [r7, #2])
> + THUMB(	orr	ip, r6, ip, lsl #16)
> + ARM( 1: ldr	ip, [r7, r3])
>  	lsr	r6, ip, #20		@ extract opcode

Please don't do this.

- Remember my comment about using mnemonics such as "lsr" in an 
  ARM-mode compiled kernel when old binutils are used.

- There is rather little commonalities between the patching of ARM 
  instructions vs Thumb instructions.  Especially after you take into 
  account my previous comments.  Interlacing them makes it harder 
  to follow as well in this case.


Nicolas
