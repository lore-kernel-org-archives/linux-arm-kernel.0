From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 14:39:44 +0100
Subject: [PATCH 6/7] ARM: davinci: fix a problematic usage of WARN()
In-Reply-To: <06d69890c56bd84a831a1dccee26e34b4988a241.1448456395.git.geliangtang@163.com>
References: <86c73f180d3054c1bf17bdac8c89026209167c9b.1448456395.git.geliangtang@163.com>
 <06d69890c56bd84a831a1dccee26e34b4988a241.1448456395.git.geliangtang@163.com>
Message-ID: <12268783.CeI9Q9YHFN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 November 2015 21:12:19 Geliang Tang wrote:
> +++ b/arch/arm/mach-davinci/board-dm355-evm.c
> @@ -385,7 +385,7 @@ static __init void dm355_evm_init(void)
>  
>         aemif = clk_get(&dm355evm_dm9000.dev, "aemif");
>         if (IS_ERR(aemif))
> -               WARN("%s: unable to get AEMIF clock\n", __func__);
> +               WARN(1, "%s: unable to get AEMIF clock\n", __func__);
>         else
>                 clk_prepare_enable(aemif);
>  
> 

How about writing this as 

	if (!WARN(IS_ERR(aemif)), "unable to get AEMIF clock\n"))
		clk_prepare_enable(aemif);

Note that WARN() already contains file and line, so you don't really
need the __func__ here either.

	Arnd
