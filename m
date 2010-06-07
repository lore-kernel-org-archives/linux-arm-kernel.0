From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Jun 2010 11:51:12 +0300
Subject: [PATCH 4/5] [ARM] Auto calculate ZRELADDR and provide option
	for exceptions
In-Reply-To: <1275550613-9553-5-git-send-email-eric.miao@canonical.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-5-git-send-email-eric.miao@canonical.com>
Message-ID: <20100607085112.GD15515@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Eric Miao <eric.miao@canonical.com> [100603 10:36]:
> From: Eric Miao <eric.y.miao@gmail.com>
> 
> Original idea and prototype came from Nicolas Pitre.
> 
> As long as the zImage is placed within the 256MB range from the
> start of the memory, ZRELADDR (Address where the decompressed
> kernel will be placed, usually  == PHYS_OFFSET + TEXT_OFFSET)
> can be determined at run-time by masking PC with 0xf000_0000.
> 
> Running through all the Makefile.boot, all those zreladdr-y
> address == 0x[0-f]000_0000 + TEXT_OFFSET can be determined at
> run-time.
> 
> Option CONFIG_AUTO_ZRELADDR and CONFIG_ZRELADDR are introduced,
> CONFIG_ZRELADDR _must_ be explicitly specified if:
> 
>  - ((zreladdr-y - TEXT_OFFSET) & ~0xf0000000) != 0, which means
>    a maksing of PC with 0xf000_0000 will result an incorrect
>    address.
> 
>  - or the assumption of the zImage being loaded by the boot
>    loader within 256MB from the start address is simply
>    incorrect
> 
>  - or when ZBOOT_ROM is used, where the above assumption is
>    normally wrong

Nice series of patches!

> +config ZRELADDR
> +	hex "Physical address of the decompressed kernel image"
> +	depends on !AUTO_ZRELADDR
> +	default 0x00008000 if ARCH_BCMRING || ARCH_CNS3XXX || ARCH_DOVE ||\
> +			      ARCH_EBSA110 || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR ||\
> +			      ARCH_IOP13XX || ARCH_IOP33X || ARCH_IXP2000 ||\
> +			      ARCH_IXP23XX || ARCH_IXP4XX || ARCH_KIRKWOOD ||\
> +			      ARCH_KS8695  || ARCH_LOKI || ARCH_MMP || ARCH_MV78XX0 ||\
> +			      ARCH_NOMADIK || ARCH_NUC93X || ARCH_NS9XXX ||\
> +			      ARCH_ORION5X || ARCH_SPEAR3XX || ARCH_SPEAR6XX ||\
> +			      ARCH_UX5XX || ARCH_VERSATILE || ARCH_W90X900
> +	default 0x08008000 if ARCH_MX1 || ARCH_SHARK
> +	default 0x10008000 if ARCH_MSM || ARCH_OMAP1 || ARCH_RPC
> +	default 0x20008000 if ARCH_S5P6440 || ARCH_S5P6442 ||\
> +			      ARCH_S5PC100 || ARCH_S5PV210
> +	default 0x30008000 if ARCH_S3C2410 || ARCH_S3C2400 || ARCH_S3C2412 ||\
> +			      ARCH_S3C2416 || ARCH_S3C2440 || ARCH_S3C2443
> +	default 0x40008000 if ARCH_STMP378X || ARCH_STMP37XX || ARCH_SH7372 ||\
> +			      ARCH_SH7377
> +	default 0x50008000 if ARCH_S3C64XX || ARCH_SH7367
> +	default 0x60008000 if ARCH_VEXPRESS
> +	default 0x80008000 if ARCH_MX25 || ARCH_MX3 || ARCH_NETX ||\
> +			      ARCH_OMAP2 || ARCH_PNX4008

Please s/ARCH_OMAP2/ARCH_OMAP2PLUS/ above, then it covers ARCH_OMAP2, 3 and 4.

Regards,

Tony
