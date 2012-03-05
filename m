From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 5 Mar 2012 15:39:32 +0800
Subject: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <4F53F704.8080703@freescale.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
 <4F53F704.8080703@freescale.com>
Message-ID: <20120305073930.GC16232@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 04, 2012 at 11:13:09PM +0000, Tabi Timur-B04825 wrote:
> Shawn Guo wrote:
> > +#ifdef PPC
> > +#define read_ssi(addr)		in_be32(addr)
> > +#define write_ssi(val, addr)	out_be32(addr, val)
> > +#elif defined ARM
> > +#define read_ssi(addr)		readl(addr)
> > +#define write_ssi(val, addr)	writel(val, addr)
> > +#endif
> 
> Can you also add an ARM version of clrsetbits_be32()?  Something like this:
> 
> #ifdef PPC
> #define read_ssi(addr)		in_be32(addr)
> #define write_ssi(val, addr)	out_be32(addr, val)
> #define write_ssi_mask(addr, clear, set)	clrsetbits_be32(addr, clear, set)
> #elif defined ARM
> #define read_ssi(addr)		readl(addr)
> #define write_ssi(val, addr)	writel(val, addr)
> #define write_ssi_mask(addr, clear, set) \
> 	{ u32 __val; \
> 	val = readl(&ssi->scr); \
> 	val = (val & ~(clear) | (set); \
> 	writel(val, addr)
> #endif
> 
Yeah, it makes the diff neat.  However I would make it an inline
function which is easier to play.

#ifdef PPC
#define read_ssi(addr)                   in_be32(addr)
#define write_ssi(val, addr)             out_be32(addr, val)
#define write_ssi_mask(addr, clear, set) clrsetbits_be32(addr, clear, set)
#elif defined ARM
#define read_ssi(addr)                   readl(addr)
#define write_ssi(val, addr)             writel(val, addr)
static inline void write_ssi_mask(void __iomem *addr, u32 clear, u32 set)
{
        u32 val = readl(addr);
        val = (val & ~clear) | set;
        writel(val, addr);
}
#endif

-- 
Regards,
Shawn
