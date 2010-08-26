From: dhylands@gmail.com (Dave Hylands)
Date: Thu, 26 Aug 2010 10:05:25 -0700
Subject: Problems with dma_alloc_writecombine
In-Reply-To: <20100825182416.GA30772@n2100.arm.linux.org.uk>
References: <AANLkTi=kbch5XF99nmjRsy_f2akwQwCR7co7eN=SDd0w@mail.gmail.com>
	<AANLkTi=-choRCYyU2KA7D2asOqLGwe5BJddt9mgV81KP@mail.gmail.com>
	<20100825182416.GA30772@n2100.arm.linux.org.uk>
Message-ID: <AANLkTik657gjC_KK7AkYfiM=BT=mEf1j_BGP8MuV5u8e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

...snip...
> Partly that's because it's overhead which we don't need there. ?Probably
> a better solution is to add the dsb() to __dma_alloc_remap() like this:
>
> ?arch/arm/mm/dma-mapping.c | ? ?2 ++
> ?1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index c704eed..4bc43e5 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -229,6 +229,8 @@ __dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot)
> ? ? ? ? ? ? ? ? ? ? ? ?}
> ? ? ? ? ? ? ? ?} while (size -= PAGE_SIZE);
>
> + ? ? ? ? ? ? ? dsb();
> +
> ? ? ? ? ? ? ? ?return (void *)c->vm_start;
> ? ? ? ?}
> ? ? ? ?return NULL;

I can confirm that your patch also addresses our issue.

-- 
Dave Hylands
Shuswap, BC, Canada
http://www.DaveHylands.com/
