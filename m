From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 May 2017 21:01:42 +0100
Subject: [PATCH v4 6/7] ARM: NOMMU: Set ARM_DMA_MEM_BUFFERABLE for
 M-class cpus
In-Reply-To: <1493029017-31382-7-git-send-email-vladimir.murzin@arm.com>
References: <1493029017-31382-1-git-send-email-vladimir.murzin@arm.com>
 <1493029017-31382-7-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20170523200142.GD22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 11:16:56AM +0100, Vladimir Murzin wrote:
> Now, we have dedicated non-cacheable region for consistent DMA
> operations. However, that region can still be marked as bufferable by
> MPU, so it'd be safer to have barriers by default.

What do you actually want here?  Your patch doesn't quite make sense,
the commit description seems to indicate that you require this option
to be set for V7M, but the patch says otherwise.

>  config ARM_DMA_MEM_BUFFERABLE
> -	bool "Use non-cacheable memory for DMA" if (CPU_V6 || CPU_V6K) && !CPU_V7
> -	default y if CPU_V6 || CPU_V6K || CPU_V7
> +	bool "Use non-cacheable memory for DMA" if (CPU_V6 || CPU_V6K || CPU_V7M) && !CPU_V7

This "if" conditional conditionalises the visibility of the option,
it doesn't conditionalise the value.

> +	default y if CPU_V6 || CPU_V6K || CPU_V7 || CPU_V7M

Taking both of these changes together what you end up with is an option
presented to the user for "Use non-cacheable memory for DMA" which
they can choose to disable.

If you require this option to be set, that's incorrect - your modification
to the default line is correct, but the first line is not.  To achieve
that, you want the if condition to evaluate false for V7M, thereby hiding
the option from the user.  In that case, the default value will always be
assigned to the option.

>  	help
>  	  Historically, the kernel has used strongly ordered mappings to
>  	  provide DMA coherent memory.  With the advent of ARMv7, mapping
> -- 
> 2.0.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
