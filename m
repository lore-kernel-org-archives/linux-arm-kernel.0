From: B04825@freescale.com (Tabi Timur-B04825)
Date: Sun, 4 Mar 2012 23:13:09 +0000
Subject: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F53F704.8080703@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> +#ifdef PPC
> +#define read_ssi(addr)		in_be32(addr)
> +#define write_ssi(val, addr)	out_be32(addr, val)
> +#elif defined ARM
> +#define read_ssi(addr)		readl(addr)
> +#define write_ssi(val, addr)	writel(val, addr)
> +#endif

Can you also add an ARM version of clrsetbits_be32()?  Something like this:

#ifdef PPC
#define read_ssi(addr)		in_be32(addr)
#define write_ssi(val, addr)	out_be32(addr, val)
#define write_ssi_mask(addr, clear, set)	clrsetbits_be32(addr, clear, set)
#elif defined ARM
#define read_ssi(addr)		readl(addr)
#define write_ssi(val, addr)	writel(val, addr)
#define write_ssi_mask(addr, clear, set) \
	{ u32 __val; \
	val = readl(&ssi->scr); \
	val = (val & ~(clear) | (set); \
	writel(val, addr)
#endif

-- 
Timur Tabi
Linux kernel developer at Freescale
