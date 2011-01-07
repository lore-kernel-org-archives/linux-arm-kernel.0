From: stanley.miao@windriver.com (stanley.miao)
Date: Fri, 7 Jan 2011 10:26:25 +0800
Subject: [PATCH V3 42/63] ST SPEAr: replace readl, writel with __raw_readl,
	__raw_writel in uncompress.h
In-Reply-To: <73a77c388f8d151ce5bc70000832fbb518babe3b.1292833229.git.viresh.kumar@st.com>
References: <cover.1292833228.git.viresh.kumar@st.com>
	<73a77c388f8d151ce5bc70000832fbb518babe3b.1292833229.git.viresh.kumar@st.com>
Message-ID: <4D2679D1.3080005@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh Kumar wrote:
> readl also calls outer cache maintainance operations 

I use readl here on spear13xx. It works fine.
This is the definition of readl, could you tell me which code calls 
outer cache maintainance ?

#define readl(c) ({ __u32 __v = le32_to_cpu((__force __le32) \
                                        __raw_readl(__mem_pci(c))); __v; })

> which are not available
> during Linux uncompression. This patch replaces readl, writel with __raw_readl
> and __raw_writel.
>   

I tried to make spear13xx working under big endian. The _raw_readl here 
brought me a big trouble.


Stanley.


> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  arch/arm/plat-spear/include/plat/uncompress.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-spear/include/plat/uncompress.h b/arch/arm/plat-spear/include/plat/uncompress.h
> index 99ba678..963aa5b 100644
> --- a/arch/arm/plat-spear/include/plat/uncompress.h
> +++ b/arch/arm/plat-spear/include/plat/uncompress.h
> @@ -24,10 +24,10 @@ static inline void putc(int c)
>  {
>  	void __iomem *base = (void __iomem *)SPEAR_DBG_UART_BASE;
>  
> -	while (readl(base + UART01x_FR) & UART01x_FR_TXFF)
> +	while (__raw_readl(base + UART01x_FR) & UART01x_FR_TXFF)
>  		barrier();
>  
> -	writel(c, base + UART01x_DR);
> +	__raw_writel(c, base + UART01x_DR);
>  }
>  
>  static inline void flush(void)
>   
