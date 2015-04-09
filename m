From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Apr 2015 12:29:12 +0200
Subject: [PATCH 4/7] ARM: cache-v7: optimise branches in
 v7_flush_cache_louis
In-Reply-To: <20150409082116.GV12732@n2100.arm.linux.org.uk>
References: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
 <2570741.Vc3c6Ovx3m@wuerfel> <20150409082116.GV12732@n2100.arm.linux.org.uk>
Message-ID: <2927556.fYRDzU3Hag@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 April 2015 09:21:16 Russell King - ARM Linux wrote:
> On Thu, Apr 09, 2015 at 10:13:06AM +0200, Arnd Bergmann wrote:
> > 
> > With this in linux-next, I get a build failure on randconfig kernels with
> > THUMB2_KERNEL enabled:
> > 
> > arch/arm/mm/cache-v7.S: Assembler messages:
> > arch/arm/mm/cache-v7.S:99: Error: ALT_UP() content must assemble to exactly 4 bytes
> > 
> > Any idea for a method that will work with all combinations of SMP/UP
> > and ARM/THUMB? The best I could come up with was to add an extra 'mov r0,r0',
> > but that gets rather ugly as you then have to do it only for THUMB2.
> 
> How about we make ALT_UP() add the additional padding?  Something like
> this maybe?
> 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index f67fd3afebdf..79f421796aab 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -237,6 +237,9 @@
>  	.pushsection ".alt.smp.init", "a"			;\
>  	.long	9998b						;\
>  9997:	instr							;\
> +	.if . - 9997b == 2					;\
> +		nop						;\
> +	.endif
>  	.if . - 9997b != 4					;\
>  		.error "ALT_UP() content must assemble to exactly 4 bytes";\
>  	.endif							;\
> 

This looks like a good solution, and works fine after adding the
missing ';\' characters behind the .endif.

I don't expect any problems but I'm doing some more randconfig builds
now with this patch, and if you don't hear back today, feel free to add

Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

	Arnd
