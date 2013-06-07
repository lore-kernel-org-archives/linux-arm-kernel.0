From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 07 Jun 2013 19:33:42 +0200
Subject: [PATCH v3 0/3] Separate generic header usage from
 ARCH_MULTIPLATFORM
In-Reply-To: <51B20F7B.1080909@arm.com>
References: <1370602111-28737-1-git-send-email-jonathan.austin@arm.com>
 <29798869.9FjkuBXpzS@wuerfel> <51B20F7B.1080909@arm.com>
Message-ID: <27974883.ZkGYubVYBp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013 17:51:07 Jonathan Austin wrote:
> 
> Thanks for the expansion. I like that as an aim :). We should remember 
> it'll still only make sense for platforms where PHYS_OFFSET/DRAM_BASE is 
> the same - not sure how many that will be.

Yes, this is much less about the practical value of actually running
a kernel that is built for multiple NOMMU machines than it is about
doing things in a consistent way throughout the kernel.

> I've had a play with keeping !MMU and ARCH_MULTIPLATFORM selectable 
> together, and of the fixes in your diff, only the following is required 
> to get R7 booting on top of Vexpress:
> 
> -----8<-------
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a7f066e..ead2b25 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -289,8 +289,7 @@ choice
> 
>   config ARCH_MULTIPLATFORM
>          bool "Allow multiple platforms to be selected"
> -       depends on MMU
> -       select ARM_PATCH_PHYS_VIRT
> +       select ARM_PATCH_PHYS_VIRT if MMU
>          select AUTO_ZRELADDR
>          select COMMON_CLK
>          select MULTI_IRQ_HANDLER
> ----->8--------
> 
> It's nice too, because we don't need to add back Makefile.boot for vexpress.

Ok, excellent. We can probably mark that for -stable backports so we
also get it in 3.8.x and 3.9.x.

> The R7 support, nommu-fixes and MPU patches I sent before and which I 
> hope to have merged for 3.11 (pull request for rmk coming shortly) can 
> all work fine using this instead of the NEED_NO_MACH_HEADERS series (IE 
> this series)....

Ok.

> It would be cool, then, to have the small patch above in for 3.11 too if 
> we're not too late and if nobody is against going down this route?
> 
> Arnd: would you like to send it as a patch to the list for 
> consideration, or shall I take this on?

Please send a patch with a correct description.

	Arnd
