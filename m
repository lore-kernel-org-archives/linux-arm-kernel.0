From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 7 Sep 2010 06:13:49 +0200
Subject: [PATCH] pxa: fix cpu_is_pxa*() not expanded to zero when not
	configured
In-Reply-To: <AANLkTinqc=k3H0QL5PKNu6Je=qs=GBNAQ21nv5HkvGom@mail.gmail.com>
References: <AANLkTinqc=k3H0QL5PKNu6Je=qs=GBNAQ21nv5HkvGom@mail.gmail.com>
Message-ID: <201009070613.49827.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 7. z??? 2010 06:09:46 Eric Miao napsal(a):
> Marek,
> 
> Could you give this a run?

Fixed the problem.

Tested-by: Marek Vasut <marek.vasut@gmail.com>
> 
> diff --git a/arch/arm/mach-pxa/include/mach/hardware.h
> b/arch/arm/mach-pxa/include/mach/hardware.h
> index 7f64d24..b036500 100644
> --- a/arch/arm/mach-pxa/include/mach/hardware.h
> +++ b/arch/arm/mach-pxa/include/mach/hardware.h
> @@ -264,23 +264,35 @@
>   * <= 0x2 for pxa21x/pxa25x/pxa26x/pxa27x
>   * == 0x3 for pxa300/pxa310/pxa320
>   */
> +#if defined(CONFIG_PXA25x) || defined(CONFIG_PXA27x)
>  #define __cpu_is_pxa2xx(id)				\
>  	({						\
>  		unsigned int _id = (id) >> 13 & 0x7;	\
>  		_id <= 0x2;				\
>  	 })
> +#else
> +#define __cpu_is_pxa2xx(id)	(0)
> +#endif
> 
> +#ifdef CONFIG_PXA3xx
>  #define __cpu_is_pxa3xx(id)				\
>  	({						\
>  		unsigned int _id = (id) >> 13 & 0x7;	\
>  		_id == 0x3;				\
>  	 })
> +#else
> +#define __cpu_is_pxa3xx(id)	(0)
> +#endif
> 
> +#if defined(CONFIG_CPU_PXA930) || defined(CONFIG_CPU_PXA935)
>  #define __cpu_is_pxa93x(id)				\
>  	({						\
>  		unsigned int _id = (id) >> 4 & 0xfff;	\
>  		_id == 0x683 || _id == 0x693;		\
>  	 })
> +#else
> +#define __cpu_is_pxa93x(id)	(0)
> +#endif
> 
>  #define cpu_is_pxa2xx()					\
>  	({						\
