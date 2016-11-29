From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Nov 2016 17:11:45 +0000
Subject: [RFC v2 PATCH 11/23] ARM: sleep: allow it to be build for R-class
In-Reply-To: <1480423205-48436-12-git-send-email-vladimir.murzin@arm.com>
References: <1480423205-48436-1-git-send-email-vladimir.murzin@arm.com>
 <1480423205-48436-12-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20161129171145.GW14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 12:39:53PM +0000, Vladimir Murzin wrote:
> Dependency on MMU is quite strict and prevent R-class from being built -
> relax this condition and guard against M-class only

I thought I'd already commented on some of this change, but it seems
not.

> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> index 0f6c100..0e7fddf 100644
> --- a/arch/arm/kernel/sleep.S
> +++ b/arch/arm/kernel/sleep.S
> @@ -119,14 +119,12 @@ ENDPROC(cpu_resume_after_mmu)
>  	.text
>  	.align
>  
> -#ifdef CONFIG_MMU
>  	.arm
>  ENTRY(cpu_resume_arm)
>   THUMB(	badr	r9, 1f		)	@ Kernel is entered in ARM.
>   THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
>   THUMB(	.thumb			)	@ switch to Thumb now.
>   THUMB(1:			)
> -#endif
>  
>  ENTRY(cpu_resume)
>  ARM_BE8(setend be)			@ ensure we are in BE mode
> @@ -160,9 +158,7 @@ THUMB(	mov	sp, r2			)
>  THUMB(	bx	r3			)
>  ENDPROC(cpu_resume)
>  
> -#ifdef CONFIG_MMU
>  ENDPROC(cpu_resume_arm)
> -#endif

These ifdefs were introduced to fix EFM32.  The commit description needs
to state why it's safe to remove them now (presumably because of the
dependency on !CPU_V7M).  However, it also needs to explain why it's
not going to cause a regression for EFM32 - EFM32 _was_ capable of
building this code.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
