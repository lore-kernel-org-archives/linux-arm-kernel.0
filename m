From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 04 Dec 2011 16:25:45 +0400
Subject: [PATCH] arm, davinci: configure davinci aemif chipselects through
 OF
In-Reply-To: <1322991679-20947-1-git-send-email-hs@denx.de>
References: <1322991679-20947-1-git-send-email-hs@denx.de>
Message-ID: <4EDB66C9.9050302@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04-12-2011 13:41, Heiko Schocher wrote:

> Signed-off-by: Heiko Schocher<hs@denx.de>
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: grant.likely at secretlab.ca
> Cc: Sekhar Nori<nsekhar@ti.com>
> Cc: Kevin Hilman<khilman@ti.com>
> Cc: Wolfgang Denk<wd@denx.de>

> diff --git a/arch/arm/mach-davinci/aemif.c b/arch/arm/mach-davinci/aemif.c
> index 1ce70a9..12c559f 100644
> --- a/arch/arm/mach-davinci/aemif.c
> +++ b/arch/arm/mach-davinci/aemif.c
[...]
> @@ -131,3 +138,99 @@ int davinci_aemif_setup_timing(struct davinci_aemif_timing *t,
>   	return 0;
>   }
>   EXPORT_SYMBOL(davinci_aemif_setup_timing);
> +
> +#if defined(CONFIG_OF)
> +static int dv_get_value(struct device_node *np, const char *name)
> +{
> +	const u32 *data;
> +	int len;
> +
> +	data = of_get_property(np, name,&len);
> +	if (data)
> +		return be32_to_cpu(readl(data));

    Why readl() here?! Device tree is not a peripheral device...

> +
> +	return -EINVAL;
> +}

    Isn't there already a standard helper for that, of_property_read_u32()?

WBR, Sergei
