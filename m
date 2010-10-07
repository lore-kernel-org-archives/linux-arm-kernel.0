From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 7 Oct 2010 13:51:56 +0200
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <20101007115156.GE27250@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Thu, Oct 07, 2010 at 12:44:22PM +0300, Felipe Contreras wrote:
> Many drivers are broken, and there's no alternative in sight. Such a big
> change should stay as a warning for now, and only later should it
> actually fail.
> 
> The drivers are not doing something correct, we get it, but for now it's
> better to allow them to work (they do 99% of the time anyway) rather
> than to force everyone to revert this patch in their internal trees
> until there's a solution. A slightly broken functionality is better than
> no functionality at all.
> 
> A warning lets people know that what they are doing is not right, and
> they should fix it.

[snip]

> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -204,8 +204,7 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
>  	/*
>  	 * Don't allow RAM to be mapped - this causes problems with ARMv6+
>  	 */

Please change the comment to match the (new) code.

> -	if (WARN_ON(pfn_valid(pfn)))
> -		return NULL;
> +	WARN_ON(pfn_valid(pfn));
>  
>  	type = get_mem_type(mtype);
>  	if (!type)

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
