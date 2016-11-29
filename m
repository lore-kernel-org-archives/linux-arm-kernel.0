From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Nov 2016 17:14:32 +0000
Subject: [RFC v2 PATCH 08/23] ARM: NOMMU: implement secondary_startup_arm
In-Reply-To: <1480423205-48436-9-git-send-email-vladimir.murzin@arm.com>
References: <1480423205-48436-1-git-send-email-vladimir.murzin@arm.com>
 <1480423205-48436-9-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20161129171432.GX14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 12:39:50PM +0000, Vladimir Murzin wrote:
> Mediatek's and Qualcomm's platform code has reference to
> secondary_startup_arm and that breaks NOMMU build.

This needs to explain why this is safe in the presence of EFM32.

> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm/kernel/head-nommu.S |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
> index 7317554..2ab026f 100644
> --- a/arch/arm/kernel/head-nommu.S
> +++ b/arch/arm/kernel/head-nommu.S
> @@ -89,6 +89,12 @@ ENDPROC(stext)
>  
>  #ifdef CONFIG_SMP
>  	.text
> +	.arm
> +ENTRY(secondary_startup_arm)
> +	THUMB(	badr	r9, 1f		)	@ Kernel is entered in ARM.
> +	THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
> +	THUMB(	.thumb			)	@ switch to Thumb now.
> +	THUMB(1:			)
>  ENTRY(secondary_startup)
>  	/*
>  	 * Common entry point for secondary CPUs.
> @@ -126,6 +132,7 @@ ENTRY(secondary_startup)
>  	mov	fp, #0
>  	b	secondary_start_kernel
>  ENDPROC(secondary_startup)
> +ENDPROC(secondary_startup_arm)
>  
>  	.type	__secondary_data, %object
>  __secondary_data:
> -- 
> 1.7.9.5
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
