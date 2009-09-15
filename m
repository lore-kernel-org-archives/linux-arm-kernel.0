From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 15 Sep 2009 22:39:19 +0200
Subject: [PATCH] arm: remove unused code in delay.S
In-Reply-To: <1253043875.3273.131.camel@linux-1lbu>
References: <1252875960-21512-1-git-send-email-felipe.contreras@gmail.com>
	<94a0d4530909151158y489a96e3x63ff932c713822b0@mail.gmail.com>
	<1253043875.3273.131.camel@linux-1lbu>
Message-ID: <200909152239.19543.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 15. z??? 2009 21:44:35 Steve Chen napsal(a):
> Felipe,
> 
> Here is the updated patch.  If you don't mind add your signed-off, I can
> submit the patch.

Do you guys really have so much free time on your hands to argue about this? 
btw. here's my nitpick then -- 'accurate delays' is really bad way to call it 
;-)
> 
> Regards,
> 
> Steve
> 
> Document #if 0 code block in delay.S and make it selectable for compile.
> 
> Signed-off-by: Steve Chen <schen@mvista.com>
> 
> ---
> 
>  arch/arm/Kconfig     |    8 ++++++++
>  arch/arm/lib/delay.S |    2 +-
>  2 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index aef63c8..ca8d535 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -813,6 +813,14 @@ config ARM_ERRATA_460075
>  	  ACTLR register. Note that setting specific bits in the ACTLR
> register
>  	  may not be available in non-secure mode.
> 
> +config OLD_CPU_DELAY
> +	depends on CPU_32v3 || CPU_32v4 || CPU_32v4T
> +	bool "Accurate delays"
> +	def_bool n
> +	help
> +	  Enable if observing longer than expected delays and need more
> +	  accuracy.  This only applies to older CPUs.
> +
>  endmenu
> 
>  source "arch/arm/common/Kconfig"
> diff --git a/arch/arm/lib/delay.S b/arch/arm/lib/delay.S
> index 8d6a876..67e679b 100644
> --- a/arch/arm/lib/delay.S
> +++ b/arch/arm/lib/delay.S
> @@ -42,7 +42,7 @@ ENTRY(__const_udelay)				@ 0 <= r0 <= 0x7fffff06
>  @ Delay routine
>  ENTRY(__delay)
>  		subs	r0, r0, #1
> -#if 0
> +#ifdef CONFIG_OLD_CPU_DELAY
>  		movls	pc, lr
>  		subs	r0, r0, #1
>  		movls	pc, lr
> 
