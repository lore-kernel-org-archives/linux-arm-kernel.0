From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Jan 2012 21:50:24 +0000
Subject: [PATCH 7/8] S3C2412: move io-init to SoC specific files
In-Reply-To: <201201172216.06542.heiko@sntech.de>
References: <201201172210.51953.heiko@sntech.de>
 <201201172216.06542.heiko@sntech.de>
Message-ID: <20120117215024.GY1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2012 at 10:16:06PM +0100, Heiko St?bner wrote:
> @@ -103,15 +83,6 @@ static struct map_desc s3c_iodesc[] __initdata = {
>  
>  /* read cpu identificaiton code */
>  
> -static unsigned long s3c24xx_read_idcode_v5(void)
> -{
> -#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413)
> -	return __raw_readl(S3C2412_GSTATUS1);
> -#else
> -	return 1UL;	/* don't look like an 2400 */
> -#endif
> -}
> -
>  static unsigned long s3c24xx_read_idcode_v4(void)
>  {
>  	return __raw_readl(S3C2410_GSTATUS1);
> @@ -123,11 +94,7 @@ void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
>  	iotable_init(mach_desc, size);
>  	iotable_init(s3c_iodesc, ARRAY_SIZE(s3c_iodesc));
>  
> -	if (cpu_architecture() >= CPU_ARCH_ARMv5) {
> -		samsung_cpu_id = s3c24xx_read_idcode_v5();
> -	} else {
> -		samsung_cpu_id = s3c24xx_read_idcode_v4();
> -	}
> +	samsung_cpu_id = s3c24xx_read_idcode_v4();

I really don't like seeing patches which do this kind of thing:

patch 1: move A
patch 2: move B
patch 3: move C and delete D which A,B,C all depend on

It means that if, for whatever reason, patch 2 has to be reverted or
removed, you also have to revert patch 3.  Rather than this:

patch 1: move A
patch 2: move B
patch 3: move C
patch 4: delete D which A,B,C all depend on

This makes each 'move' patches _totally_ independent of each other, and
of the delete D patch, and makes the interdependencies of the patches
easier to express and understand.

Note that you didn't say you deleted D, which the others rely upon, in
the patch commentry:

> Move s3c2412 specific code from s3c24xx_init_io to s3c2412.c
> and make the s3c2412.h header obsolete.
