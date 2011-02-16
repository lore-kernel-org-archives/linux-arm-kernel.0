From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 Feb 2011 10:32:12 +0000
Subject: [PATCH] ARM: errata: pl310 cache sync operation may be faulty
In-Reply-To: <20110216060351.GB16604@bnru02>
References: <1297768683-30273-1-git-send-email-srinidhi.kasagar@stericsson.com>
	<20110215113422.GE4152@n2100.arm.linux.org.uk>
	<20110216060351.GB16604@bnru02>
Message-ID: <AANLkTi=svL42XJE-61H16B-jgwwu-+pXjS3QcMKNJN6Z@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 February 2011 06:03, Srinidhi KASAGAR
<srinidhi.kasagar@stericsson.com> wrote:
> On Tue, Feb 15, 2011 at 12:34:22 +0100, Russell King - ARM Linux wrote:
>> On Tue, Feb 15, 2011 at 04:48:03PM +0530, srinidhi kasagar wrote:
>> > +#ifdef ARM_ERRATA_753970
>> > +#define L2X0_DUMMY_REG ?0x740
>> > + ? /* write to an unmmapped register */
>> > + ? writel_relaxed(0, base + L2X0_DUMMY_REG);
>> > + ? cache_wait(base + L2X0_CACHE_SYNC, 1);
>> > +#else
>> > ? ? writel_relaxed(0, base + L2X0_CACHE_SYNC);
>> > ? ? cache_wait(base + L2X0_CACHE_SYNC, 1);
>> > +#endif
>>
>> So why wrap cache_wait() up in that horrible ifdef as well - and why not
>> put the dummy register definition along side the other register definitions?
[...]
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -49,8 +49,14 @@ static inline void cache_wait(void __iomem *reg, unsigned long mask)
> ?static inline void cache_sync(void)
> ?{
> ? ? ? ?void __iomem *base = l2x0_base;
> +
> +#ifdef CONFIG_ARM_ERRATA_753970
> + ? ? ? /* write to an unmmapped register */
> + ? ? ? writel_relaxed(0, base + L2X0_DUMMY_REG);
> +#else
> ? ? ? ?writel_relaxed(0, base + L2X0_CACHE_SYNC);
> ? ? ? ?cache_wait(base + L2X0_CACHE_SYNC, 1);
> +#endif
> ?}

You could still leave cache_wait() after #endif, even though it is a
no-op. I think it is clearer that the erratum workaround only targets
the sync.

-- 
Catalin
