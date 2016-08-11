From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Aug 2016 22:26:26 +0200
Subject: [PATCH 1/5] arm/defconfigs: Remove CONFIG_IPV6_PRIVACY
In-Reply-To: <20160811170035.GD7296@nazgul.tnic>
References: <1459338168-29334-1-git-send-email-bp@alien8.de>
 <571752E8.2040103@mleia.com> <20160811170035.GD7296@nazgul.tnic>
Message-ID: <4958578.R1lMSWqhcA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, August 11, 2016 7:00:35 PM CEST Borislav Petkov wrote:
> On Wed, Apr 20, 2016 at 12:59:04PM +0300, Vladimir Zapolskiy wrote:
> > Probably you may do something similar for S3C24xx and send the change
> > to Samsung maintainers.
> 
> How does that look like?

I'd prefer not to do it mechanically, please check the things that
changed to see if they made sense.

> diff --git a/arch/arm/configs/s3c2410_defconfig b/arch/arm/configs/s3c2410_defconfig
> index b3ade552a2a5..7339d6f5d71b 100644
> --- a/arch/arm/configs/s3c2410_defconfig
> +++ b/arch/arm/configs/s3c2410_defconfig
> @@ -1,4 +1,3 @@
> -CONFIG_EXPERIMENTAL=y
>  CONFIG_SYSVIPC=y
>  CONFIG_IKCONFIG=m
>  CONFIG_IKCONFIG_PROC=y
> @@ -12,9 +11,6 @@ CONFIG_PARTITION_ADVANCED=y
>  CONFIG_BSD_DISKLABEL=y
>  CONFIG_SOLARIS_X86_PARTITION=y
>  CONFIG_ARCH_S3C24XX=y
> -CONFIG_S3C_BOOT_ERROR_RESET=y

The option is gone, that is fine.

> -CONFIG_S3C_ADC=y

This one moved around, better not mix that with the other changes.

> -CONFIG_S3C24XX_PWM=y

Two boards select this, and are apparently enabled by default.
Why? Could we remove the 'select' and leave this line?

> @@ -38,20 +34,18 @@ CONFIG_MACH_AT2440EVB=y
>  CONFIG_MACH_MINI2440=y
>  CONFIG_MACH_NEXCODER_2440=y
>  CONFIG_MACH_OSIRIS=y
> -CONFIG_MACH_OSIRIS_DVS=m

Why remove this? Is TPS65010 disabled now? Maybe its dependencies
need to be updated.


>  CONFIG_FPE_NWFPE=y
>  CONFIG_FPE_NWFPE_XP=y
> -CONFIG_BINFMT_AOUT=y
>  CONFIG_APM_EMULATION=m
>  CONFIG_NET=y
>  CONFIG_PACKET=y

This was removed in v3.11, but a lot of defconfigs still
try to enable it. Maybe do them all at once?

> @@ -67,7 +61,6 @@ CONFIG_NET_IPIP=m
>  CONFIG_INET_AH=m
>  CONFIG_INET_ESP=m
>  CONFIG_INET_IPCOMP=m
> -# CONFIG_INET_LRO is not set
>  CONFIG_TCP_CONG_ADVANCED=y
>  CONFIG_TCP_CONG_HSTCP=m
>  CONFIG_TCP_CONG_HYBLA=m

Same thing, removed in v4.6, but still referenced in 199 files.

	Arnd
