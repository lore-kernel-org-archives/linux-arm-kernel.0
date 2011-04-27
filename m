From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 27 Apr 2011 10:27:57 +0900
Subject: [PATCH] ARM: S3C64XX: Remove gpio-bank-X header files
In-Reply-To: <1303465894-16870-1-git-send-email-jy0922.shim@samsung.com>
References: <1303465894-16870-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <052c01cc047a$5cb8d500$162a7f00$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joonyoung Shim wrote:
> 
> The gpio-bank-X header files of S3C64XX have defines which can be
> substituted by more common API, so they can be removed. This is compile
> tested only.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> ---
>  arch/arm/mach-s3c64xx/dev-spi.c                  |   20 ++----
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-a.h |   48 --------------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-b.h |   60 -----------------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-c.h |   53 ---------------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-d.h |   49 --------------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-e.h |   44 -------------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-f.h |   71
--------------------
> -
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-g.h |   42 ------------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-h.h |   74
--------------------
> --
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-i.h |   40 ------------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-j.h |   36 -----------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-n.h |   54 ----------------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-o.h |   70
--------------------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-p.h |   69
--------------------
>  arch/arm/mach-s3c64xx/include/mach/gpio-bank-q.h |   46 -------------
>  arch/arm/mach-s3c64xx/mach-smdk6410.c            |    1 -
>  arch/arm/mach-s3c64xx/pm.c                       |   35 +++++------
>  arch/arm/mach-s3c64xx/setup-i2c0.c               |    7 +--
>  arch/arm/mach-s3c64xx/setup-i2c1.c               |    7 +--
>  arch/arm/mach-s3c64xx/sleep.S                    |    8 ++-
>  20 files changed, 34 insertions(+), 800 deletions(-)
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-a.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-b.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-c.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-d.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-e.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-f.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-g.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-h.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-i.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-j.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-n.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-o.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-p.h
>  delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-q.h
> 

Hi,

Oh, great.

I also tried to remove useless gpio header files :) and it is in my dev/gpio
branch. But I think, this is better.
Anyway there are small comments.

(snip)

>  void s3c_pm_debug_smdkled(u32 set, u32 clear)
>  {
> -	unsigned long flags;
> -	u32 reg;
> -
> -	local_irq_save(flags);
> -	reg = __raw_readl(S3C64XX_GPNCON);
> -	reg &= ~(S3C64XX_GPN_CONMASK(12) | S3C64XX_GPN_CONMASK(13) |
> -		 S3C64XX_GPN_CONMASK(14) | S3C64XX_GPN_CONMASK(15));
> -	reg |= S3C64XX_GPN_OUTPUT(12) | S3C64XX_GPN_OUTPUT(13) |
> -	       S3C64XX_GPN_OUTPUT(14) | S3C64XX_GPN_OUTPUT(15);
> -	__raw_writel(reg, S3C64XX_GPNCON);
> -
> -	reg = __raw_readl(S3C64XX_GPNDAT);
> -	reg &= ~(clear << 12);
> -	reg |= set << 12;
> -	__raw_writel(reg, S3C64XX_GPNDAT);
> -
> -	local_irq_restore(flags);
> +	int i;
> +
> +	for (i = 0; i < 4; i++) {
> +		if (clear & (1 << i))
> +			gpio_direction_output(S3C64XX_GPN(12 + i), 0);
> +		if (set & (1 << i))
> +			gpio_direction_output(S3C64XX_GPN(12 + i), 1);
> +	}

Hmm...

According to comments in gpio_direction_{input,output}, it isn't called more
than once...but it can be called twice in your code. And need
local_irq_{save,restore} around them.

So how about keeping old codes here? In addtion, as you know, need to keep
definitions of S3C64XX_GPNxxx now :(

Others looks ok.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
