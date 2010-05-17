From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 17 May 2010 09:12:38 +0100
Subject: [PATCH 1/3] ARM: Samsung: fix broken timer irq base
In-Reply-To: <1274077795-30873-2-git-send-email-m.szyprowski@samsung.com>
References: <1274077795-30873-1-git-send-email-m.szyprowski@samsung.com>
	<1274077795-30873-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20100517081238.GZ6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 17, 2010 at 08:29:53AM +0200, Marek Szyprowski wrote:
> Timer interrupts range was defined as 43-47, what overlaps with VIC0 range
> (32-64). This was caused probably by a typo while the common interrupts
> definition was refactored. This patch moves timer interrupt range to safe
> area of 11-15 (just before uart range).
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-s5p/include/plat/irqs.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-s5p/include/plat/irqs.h b/arch/arm/plat-s5p/include/plat/irqs.h
> index 42e757f..9ff3d71 100644
> --- a/arch/arm/plat-s5p/include/plat/irqs.h
> +++ b/arch/arm/plat-s5p/include/plat/irqs.h
> @@ -79,7 +79,7 @@
>  #define S5P_IRQ_VIC2(x)		(S5P_VIC2_BASE + (x))
>  #define S5P_IRQ_VIC3(x)		(S5P_VIC3_BASE + (x))
>  
> -#define S5P_TIMER_IRQ(x)	S5P_IRQ(11 + (x))
> +#define S5P_TIMER_IRQ(x)	(11 + (x))

87aef30e (Atul Dahiya 2010-01-29 09:08:28 +0900 82) #define S5P_TIMER_IRQ(x)    S5P_IRQ(11 + (x))

is the one to blame here.

    ARM: S5P: Change S5P_TIMER_IRQ based to 11 for SAMSUNG S5P series.
    
    Currently, S5P_TIMER_IRQ is based at the end of VICs. This patch changes
    the S5P_TIMER_IRQ base from end of VICs to 11 in ISA IRQ space.
    No of VICs varies between SOCs. This causes an exception on S5P6442.
    
    Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
    Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
    Signed-off-by: Ben Dooks <ben-linux@fluff.org>

So it looks like this was intended to re-use the ISA interrupt range
but didn't get it quite right.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
