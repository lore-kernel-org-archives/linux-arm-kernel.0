From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 23 Apr 2010 14:12:51 +0400
Subject: [PATCH 2/2] i.MX35: remove get_3_3_div helper function
In-Reply-To: <1272008426-14435-3-git-send-email-s.hauer@pengutronix.de>
References: <1272008426-14435-1-git-send-email-s.hauer@pengutronix.de>
	<1272008426-14435-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4BD172A3.8050500@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Sascha Hauer wrote:
> In the v2 reference manual there are no dividers combined of two
> dividers. Instead, all dividers are simple 6bit dividers. I assume
> the combined dividers only exist in preliminary hardware.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mx3/clock-imx35.c |   13 ++++---------
>  1 files changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
> index 5c87338..c6ef64e 100644
> --- a/arch/arm/mach-mx3/clock-imx35.c
> +++ b/arch/arm/mach-mx3/clock-imx35.c
> @@ -178,16 +178,11 @@ static unsigned long get_rate_ipg(struct clk *clk)
>  	return get_rate_ahb(NULL) >> 1;
>  }
>  
> -static unsigned long get_3_3_div(unsigned long in)
> -{
> -	return (((in >> 3) & 0x7) + 1) * ((in & 0x7) + 1);
> -}
> -
>  static unsigned long get_rate_uart(struct clk *clk)
>  {
>  	unsigned long pdr3 = __raw_readl(CCM_BASE + CCM_PDR3);
>  	unsigned long pdr4 = __raw_readl(CCM_BASE + CCM_PDR4);
> -	unsigned long div = get_3_3_div(pdr4 >> 10);
> +	unsigned long div = ((pdr4 >> 10) & 0x3f) + 1;
>  
>  	if (pdr3 & (1 << 14))
>  		return get_rate_arm() / div;
> @@ -218,7 +213,7 @@ static unsigned long get_rate_sdhc(struct clk *clk)
>  		break;
>  	}
>  
> -	return rate / get_3_3_div(div);
> +	return rate / (div + 1);
>   

   You're adding 1 to divisor twice here...

>  }
>  
>  static unsigned long get_rate_mshc(struct clk *clk)
> @@ -272,7 +267,7 @@ static unsigned long get_rate_csi(struct clk *clk)
>  	else
>  		rate = get_rate_ppll();
>  
> -	return rate / get_3_3_div((pdr2 >> 16) & 0x3f);
> +	return rate / (((pdr2 >> 16) & 0x3f) + 1);
>  }
>  
>  static unsigned long get_rate_otg(struct clk *clk)
> @@ -285,7 +280,7 @@ static unsigned long get_rate_otg(struct clk *clk)
>  	else
>  		rate = get_rate_ppll();
>  
> -	return rate / get_3_3_div((pdr4 >> 22) & 0x3f);
> +	return rate / (((pdr4 >> 22) & 0x3f) + 1);
>   

   ... but not here. Is that right?

WBR, Sergei
