From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Sep 2014 20:13:16 +0200
Subject: [RFT PATCH] mtd: ixp4xx: Unrequire CONFIG_MTD_CFI_BE_BYTE_SWAP
In-Reply-To: <719460394.273364.1411492720358.JavaMail.zimbra@xes-inc.com>
References: <719460394.273364.1411492720358.JavaMail.zimbra@xes-inc.com>
Message-ID: <3290917.AsGO4THCdo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 September 2014 12:18:40 Aaron Sierra wrote:
> -#ifndef __ARMEB__
> -#ifndef CONFIG_MTD_CFI_BE_BYTE_SWAP
> -#  error CONFIG_MTD_CFI_BE_BYTE_SWAP required
> -#endif
>  
>  static inline u16 flash_read16(void __iomem *addr)
>  {
> -       return be16_to_cpu(__raw_readw((void __iomem *)((unsigned long)addr ^ 0x2)));
> +       return be16_to_cpu(__raw_readw(addr));
>  }
>  
>  static inline void flash_write16(u16 d, void __iomem *addr)
>  {
> -       __raw_writew(cpu_to_be16(d), (void __iomem *)((unsigned long)addr ^ 0x2));
> +       __raw_writew(cpu_to_be16(d), addr);
>  }
>  
>  #define        BYTE0(h)        ((h) & 0xFF)
>  #define        BYTE1(h)        (((h) >> 8) & 0xFF)
> 

Your patch looks like a good idea, but I think the above is still wrong
because you no longer fix up the address to swap the 16-bit halves of
a 32-bit word.

My guess is that you can just do 

static inline u16 flash_read16(void __iomem *addr)
{
	if (!IS_ENABLED(CPU_BIG_ENDIAN))
		addr = (void __iomem *)((unsigned long)addr ^ 0x2));

        return readl_relaxed(addr);
}

static inline void flash_write16(u16 d, void __iomem *addr)
{
	if (!IS_ENABLED(CPU_BIG_ENDIAN))
		addr = (void __iomem *)((unsigned long)addr ^ 0x2));

        writel_relaxed(d, addr);
}

to do this.

	Arnd
