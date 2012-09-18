From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Sep 2012 21:25:44 +0000
Subject: [PATCH 08+09/24] ARM: ixp4xx: use __iomem pointers for MMIO
In-Reply-To: <m3ehlzdr9d.fsf_-_@intrepid.localdomain>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-10-git-send-email-arnd@arndb.de>
 <m3ehlzdr9d.fsf_-_@intrepid.localdomain>
Message-ID: <201209182125.44494.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 September 2012, Krzysztof Halasa wrote:
> > @@ -51,7 +52,7 @@ static inline u32 ixp4xx_read_feature_bits(void)
> >  
> >  static inline void ixp4xx_write_feature_bits(u32 value)
> >  {
> > -     *IXP4XX_EXP_CFG2 = ~value;
> > +     __raw_writel(~cpu_to_le32(value), IXP4XX_EXP_CFG2);
> >  }
> 
> The EXP_CFG2 register is already in host order, no need for
> cpu_to_le32() as the replaced code clearly shows.
> 
> Can you merge both IXP4xx parts (in the two patches) and fix the above,
> please? Thanks.

Thanks for pointing this out, that was a mistake on my end, because I first
tried to convert to writel, with byteswap and then made up my mind and used
__raw_writel instead because it seemed silly to do two byteswaps.

	Arnd
