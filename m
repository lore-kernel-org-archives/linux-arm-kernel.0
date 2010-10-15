From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 15 Oct 2010 15:30:21 +0100
Subject: [PATCH .36-rc8] arm: mm: allow, but warn, when issuing
	ioremap() on RAM
In-Reply-To: <1287152120-7201-1-git-send-email-felipe.contreras@gmail.com>
References: <1287152120-7201-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <1287153021.27165.6.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Fri, 2010-10-15 at 15:15 +0100, Felipe Contreras wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> Drivers have been relying on this behavior, but done so wrongly.
> However, rather than breaking drivers from .35 to .36, we should warn on
> .36 and only break on .37. This way we give a chance for contributors to
> fix the issues.
> 
> According to ARM, the behavior of having multiple mappings is
> unspecified from ARMv6+. This causes real issues specially on modern
> hardware, and specially with speculative prefetching. So drivers need to
> be fixed.
> 
> Also, since current hardware has palliative meassures to deal with
> multiple mappings with the same memory type but diferent cacheability
> attributes, ensure that such restriction is taking place.
> 
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Richard Woodruff <r-woodruff2@ti.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

I just showed a partial workaround but I did not sign off my patch. Not
sure if just posting a code snippet counts as an explicit signed-off-by.

> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -202,10 +202,14 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
>                 return NULL;
> 
>         /*
> -        * Don't allow RAM to be mapped - this causes problems with ARMv6+
> +        * This causes problems with ARMv6+. Will be disallowed soon.
> +        * Also avoid a second mapping with different shareability, which is
> +        * not supposed to work anyway.
>          */
>         if (WARN_ON(pfn_valid(pfn)))
> -               return NULL;
> +               if (__LINUX_ARM_ARCH__ >= 6 &&
> +                   (mtype != MT_DEVICE_CACHED && mtype != MT_DEVICE_WC))
> +                       mtype = MT_DEVICE_WC;
> 
>         type = get_mem_type(mtype);
>         if (!type)

And one of the reasons is that this patch is incomplete. You still
create a mapping alias (though now with the same memory type and
different cacheability attributes) but there isn't anything to take care
of the potential dirty cache lines in the original alias (e.g. kernel
linear mapping). You can easily end up with data corruption.

-- 
Catalin
