From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 4 Mar 2012 23:28:17 +0000
Subject: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <4F53F704.8080703@freescale.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
 <4F53F704.8080703@freescale.com>
Message-ID: <20120304232817.GA13516@n2100.arm.linux.org.uk>
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

Is the SCR shared between capture and playback?  In that case, what
makes this read-modify-write thread safe?
