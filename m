From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 06 Aug 2015 11:10:34 -0700
Subject: [PATCH v2] ata: ahci_brcmstb: Fix misuse of IS_ENABLED
In-Reply-To: <1438835298.28215.1.camel@ingics.com>
References: <1438835298.28215.1.camel@ingics.com>
Message-ID: <55C3A31A.6090103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/15 21:28, Axel Lin wrote:
> While IS_ENABLED() is perfectly fine for CONFIG_* symbols, it is not
> for other symbols such as __BIG_ENDIAN that is provided directly by
> the compiler.
> 
> Switch to use CONFIG_CPU_BIG_ENDIAN instead of __BIG_ENDIAN.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
> v2:
> Based on Florian's comment:
> Switch to use CONFIG_CPU_BIG_ENDIAN instead of __BIG_ENDIAN.
> 
>  drivers/ata/ahci_brcmstb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
> index 42b6cf4..14b7305 100644
> --- a/drivers/ata/ahci_brcmstb.c
> +++ b/drivers/ata/ahci_brcmstb.c
> @@ -92,7 +92,7 @@ static inline u32 brcm_sata_readreg(void __iomem *addr)
>  	 * Other architectures (e.g., ARM) either do not support big endian, or
>  	 * else leave I/O in little endian mode.
>  	 */
> -	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(__BIG_ENDIAN))
> +	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
>  		return __raw_readl(addr);
>  	else
>  		return readl_relaxed(addr);
> @@ -101,7 +101,7 @@ static inline u32 brcm_sata_readreg(void __iomem *addr)
>  static inline void brcm_sata_writereg(u32 val, void __iomem *addr)
>  {
>  	/* See brcm_sata_readreg() comments */
> -	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(__BIG_ENDIAN))
> +	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
>  		__raw_writel(val, addr);
>  	else
>  		writel_relaxed(val, addr);
> 


-- 
Florian
