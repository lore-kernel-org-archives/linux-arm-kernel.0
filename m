From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 5 Jun 2013 13:51:14 +0200
Subject: [PATCH 01/02] ARM: shmobile: Let romImage rely on default ATAGS
In-Reply-To: <20130605075522.17653.20769.sendpatchset@w520>
References: <20130605075514.17653.77135.sendpatchset@w520>
 <20130605075522.17653.20769.sendpatchset@w520>
Message-ID: <201306051351.14978.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 June 2013, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Remove the ATAGS data structure from head-shmobile.S
> since a default ATAGS is already provided by the code
> in arch/arm/kernel/atags_parser.c. Passing a NULL as
> ATAGS is valid. For actual hardware specific setup
> the fixup callback in the board code may be used.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Makes sense to me, but it's not really my area of expertise.
Maybe Russell has some input on this.

What about the rest of head-shmobile.S? If we ignore the mmcif boot
code, can we boot an shmobile system using just the regular head.S
code once we get to a multiplatform image with shmobile?

	Arnd

>  arch/arm/boot/compressed/head-shmobile.S |   19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
> 
> --- 0001/arch/arm/boot/compressed/head-shmobile.S
> +++ work/arch/arm/boot/compressed/head-shmobile.S	2013-06-05 11:59:06.000000000 +0900
> @@ -55,26 +55,9 @@ __tmp_stack:
>  __continue:
>  #endif /* CONFIG_ZBOOT_ROM_MMC || CONFIG_ZBOOT_ROM_SH_MOBILE_SDHI */
>  
> -	b	1f
> -__atags:@ tag #1
> -	.long	12			@ tag->hdr.size = tag_size(tag_core);
> -	.long	0x54410001		@ tag->hdr.tag = ATAG_CORE;
> -	.long   0			@ tag->u.core.flags = 0;
> -	.long	0			@ tag->u.core.pagesize = 0;
> -	.long	0			@ tag->u.core.rootdev = 0;
> -	@ tag #2
> -	.long	8			@ tag->hdr.size = tag_size(tag_mem32);
> -	.long	0x54410002		@ tag->hdr.tag = ATAG_MEM;
> -	.long	CONFIG_MEMORY_SIZE	@ tag->u.mem.size = CONFIG_MEMORY_SIZE;
> -	.long	CONFIG_MEMORY_START	@ @ tag->u.mem.start = CONFIG_MEMORY_START;
> -	@ tag #3
> -	.long	0			@ tag->hdr.size = 0
> -	.long	0			@ tag->hdr.tag = ATAG_NONE;
> -1:
> -
>  	/* Set board ID necessary for boot */
>  	ldr	r7, 1f				@ Set machine type register
> -	adr	r8, __atags			@ Set atag register
> +	mov	r8, #0				@ pass null pointer as atag
>  	b	2f
>  
>  1 :	.long MACH_TYPE
> 
