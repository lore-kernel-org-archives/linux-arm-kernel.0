From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 23 May 2015 00:04:41 +0100
Subject: [PATCH] ARM: nommu: avoid deprecated source register on mov
In-Reply-To: <1432334812-2892-1-git-send-email-stefan@agner.ch>
References: <1432334812-2892-1-git-send-email-stefan@agner.ch>
Message-ID: <20150522230441.GN2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 23, 2015 at 12:46:52AM +0200, Stefan Agner wrote:
> @@ -106,32 +106,26 @@ ENTRY(secondary_startup)
>  	movs	r10, r5				@ invalid processor?
>  	beq	__error_p			@ yes, error 'p'
>  
> -	adr	r4, __secondary_data
> -	ldmia	r4, {r7, r12}
> -
>  #ifdef CONFIG_ARM_MPU
>  	/* Use MPU region info supplied by __cpu_up */
> +	ldr	r7, __secondary_data

Almost, you want this above the #ifdef though, as r7 is used below.
("set up the stack pointer").  Apart from that, I don't see any
obvious problems, thanks.

>  	ldr	r6, [r7]			@ get secondary_data.mpu_szr
>  	bl      __setup_mpu			@ Initialize the MPU
>  #endif
>  
> -	badr	lr, __after_proc_init		@ return address
> -	mov	r13, r12			@ __secondary_switched address
> +	badr	lr, 1f				@ return (PIC) address
>  	ldr	r12, [r10, #PROCINFO_INITFUNC]
>  	add	r12, r12, r10
>  	ret	r12
> -ENDPROC(secondary_startup)
> -
> -ENTRY(__secondary_switched)
> +1:	bl	__after_proc_init
>  	ldr	sp, [r7, #12]			@ set up the stack pointer

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
