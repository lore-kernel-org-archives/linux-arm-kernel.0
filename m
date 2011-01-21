From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Jan 2011 09:46:49 +0000
Subject: [PATCH 2/3] support ARM BE8 mode on a little endian machine
In-Reply-To: <1295419487-31185-3-git-send-email-stanley.miao@windriver.com>
References: <1295419487-31185-1-git-send-email-stanley.miao@windriver.com>
	<1295419487-31185-3-git-send-email-stanley.miao@windriver.com>
Message-ID: <20110121094649.GG13235@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 02:44:46PM +0800, Stanley.Miao wrote:
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index a00055d..a33075b 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -131,6 +131,9 @@ start:
>  		mov	r0, r0
>  		.endr
>  
> +#ifdef CONFIG_BE8_ON_LE
> +		setend	be
> +#endif

This should not be before the magic numbers.

>  		b	1f
>  		.word	0x016f2818		@ Magic numbers to help the loader
>  		.word	start			@ absolute load/run zImage address
> diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
> index f1e5a9b..1504d09 100644
> --- a/arch/arm/include/asm/setup.h
> +++ b/arch/arm/include/asm/setup.h
> @@ -173,15 +173,20 @@ struct tagtable {
>  	int (*parse)(const struct tag *);
>  };
>  
> +#ifdef CONFIG_BE8_ON_LE
> +#define read_tag(a)	le32_to_cpu(a)
> +#else
> +#define read_tag(a)	a
> +#endif

I think this is going to cause sparse errors.  Has it been checked with
sparse?

What about those structures which contain u8's and u16's ?  These can't
be dealt with a le32_to_cpu().
