From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Aug 2011 16:53:54 +0100
Subject: PB1176 broken in -rc1
In-Reply-To: <20110810153947.GK2680@pulham.picochip.com>
References: <20110810152400.GO10121@e102144-lin.cambridge.arm.com>
	<20110810153947.GK2680@pulham.picochip.com>
Message-ID: <20110810155354.GP10121@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 04:39:47PM +0100, Jamie Iles wrote:
> Hi Will,

Hi Jamie,

> On Wed, Aug 10, 2011 at 04:24:00PM +0100, Will Deacon wrote:
> > My PB1176 platform appears to lock up as soon as it hits userspace when
> > running a 3.1-rc1 kernel. If I revert the commit:
> > 
> > f022e4e4 ("ARM: 6986/1: mach-realview: add TCM support for PB1176")
> > 
> > Then things start working again.
 
> This may be to do with poisoning of the init mem.  The patch below 
> (which is in next as ARM: 7010/1: mm: fix invalid loop for 
> poison_init_mem) might resolve the issue.
> 
> Jamie
> 
> 8<------
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 2fee782..91bca35 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -441,7 +441,7 @@ static inline int free_area(unsigned long pfn, unsigned long end, char *s)
>  static inline void poison_init_mem(void *s, size_t count)
>  {
>  	u32 *p = (u32 *)s;
> -	while ((count = count - 4))
> +	for (; count != 0; count -= 4)
>  		*p++ = 0xe7fddef0;
>  }

Wahey, with this I can get a working system again. Thanks for saving me from
reaching for the JTAG debugger!

Will
