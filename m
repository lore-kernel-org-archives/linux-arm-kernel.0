From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 18 Sep 2012 22:12:46 +0200
Subject: [PATCH 08+09/24] ARM: ixp4xx: use __iomem pointers for MMIO
In-Reply-To: <1347658492-11608-10-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Fri, 14 Sep 2012 23:34:37 +0200")
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-10-git-send-email-arnd@arndb.de>
Message-ID: <m3ehlzdr9d.fsf_-_@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Actually, there are some minor problems here (both patches merged,
ixp4xx only):

Arnd Bergmann <arnd@arndb.de> writes:

> --- a/arch/arm/mach-ixp4xx/include/mach/cpu.h
> +++ b/arch/arm/mach-ixp4xx/include/mach/cpu.h
> @@ -37,7 +38,7 @@
>  
>  static inline u32 ixp4xx_read_feature_bits(void)
>  {
> -	u32 val = ~*IXP4XX_EXP_CFG2;
> +	u32 val = ~__raw_readl(IXP4XX_EXP_CFG2);
>  

This is all fine, but

> @@ -51,7 +52,7 @@ static inline u32 ixp4xx_read_feature_bits(void)
>  
>  static inline void ixp4xx_write_feature_bits(u32 value)
>  {
> -	*IXP4XX_EXP_CFG2 = ~value;
> +	__raw_writel(~cpu_to_le32(value), IXP4XX_EXP_CFG2);
>  }

The EXP_CFG2 register is already in host order, no need for
cpu_to_le32() as the replaced code clearly shows.

Can you merge both IXP4xx parts (in the two patches) and fix the above,
please? Thanks.
-- 
Krzysztof Halasa
