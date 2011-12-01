From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Dec 2011 13:33:58 +0000
Subject: [patch 1/1] ixp4xx: add io{read,write}{16,32}be functions
In-Reply-To: <20111201110520.631683330@rtp-net.org>
References: <20111201110520.631683330@rtp-net.org>
Message-ID: <201112011333.59001.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 December 2011, Arnaud Patard wrote:
> Some driver are now requiring some be io functions, as noted in
> commit (06901bd83412db5a31de7526e637101ed0c2c472). Otherwise, it may lead
> to build errors like this one :
> 
> drivers/net/mlx4/en_tx.c: In function ???mlx4_en_xmit???:
> drivers/net/mlx4/en_tx.c:815: error: implicit declaration of function ???iowrite32be???
> make[3]: *** [drivers/net/mlx4/en_tx.o] Error 1
> make[2]: *** [drivers/net/mlx4] Error 2
> make[1]: *** [drivers/net] Error 2
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> 
> Index: linux-2.6/arch/arm/mach-ixp4xx/include/mach/io.h
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-ixp4xx/include/mach/io.h	2011-10-27 22:19:37.000000000 +0200
> +++ linux-2.6/arch/arm/mach-ixp4xx/include/mach/io.h	2011-12-01 09:23:47.000000000 +0100
> @@ -385,6 +385,20 @@ static inline unsigned int ioread16(cons
>  #endif
>  }
>  
> +#define	ioread16be(p)			ioread16be(p)
> +static inline unsigned int ioread16be(const void __iomem *addr)
> +{
> +	unsigned long port = (unsigned long __force)addr;
> +	if (__is_io_address(port))
> +		return	(unsigned int)inw(port & PIO_MASK);
> +	else
> +#ifndef CONFIG_IXP4XX_INDIRECT_PCI
> +		return be16_to_cpu((__force __be16)__raw_readw(addr));
> +#else
> +		return be16_to_cpu((__force __le16)(unsigned int)__indirect_readw(addr));
> +#endif
> +}

You forgot to swap bytes in case of PIO.

The cast to from 16 bit to 32 bit and back looks fishy.

I think it would be nicer to avoid the excessive #ifdef here and in the
existing code and just express this like the generic ioread* functions:

#ifndef CONFIG_IXP4XX_INDIRECT_PCI
#define __indirect_readb  __raw_readb
#define __indirect_readw  __raw_readw
#define __indirect_readl  __raw_readl
#define __indirect_writeb __raw_writeb
#define __indirect_writew __raw_writew
#define __indirect_writel __raw_writel
#endif

unsigned int ioread16be(void __iomem *addr)
{
        IO_COND(addr,
		return swab16(inw(port)),
		return be16_to_cpu(addr)(__force __le16)__indirect_readw(addr)));
        return 0xffff;
}

More generally speaking, we might want to formalize the indirect PCI access
and put it into common code eventually, at least of highbank turns out to
need this as well.  Given the complexity of the indirect functions, it's
probably best at that stage to just move all of it to an out-of-line
implementation.

Deepak, you are listed as the original author of this file. Do you remember
if you did any tests back when you implemented this to determine if an
inline implementation was actually better here than moving it all into
extern functions?

	Arnd
