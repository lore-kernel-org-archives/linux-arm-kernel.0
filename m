From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 09 Sep 2014 16:58:58 +0200
Subject: [PATCH 2/3] [media] s5p-jpeg: Fix compilation with COMPILE_TEST
In-Reply-To: <b7343e6296b5d1d68b7229b8307442fd4141bcb3.1410273306.git.m.chehab@samsung.com>
References: <20140909124306.2d5a0d76@canb.auug.org.au>
 <6cbd00c5f2d342b573aaf9c0e533778374dd2e1e.1410273306.git.m.chehab@samsung.com>
 <b7343e6296b5d1d68b7229b8307442fd4141bcb3.1410273306.git.m.chehab@samsung.com>
Message-ID: <540F15B2.3000902@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/14 16:38, Mauro Carvalho Chehab wrote:
> ERROR: "__bad_ndelay" [drivers/media/platform/s5p-jpeg/s5p-jpeg.ko] undefined!
> 
> Yet, it sounds a bad idea to use ndelay to wait for 100 us
> for the device to reset.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Mauro Carvalho Chehab <m.chehab@samsung.com>
> 
> diff --git a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c b/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
> index e51c078360f5..01eeacf28843 100644
> --- a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
> +++ b/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
> @@ -23,7 +23,9 @@ void exynos4_jpeg_sw_reset(void __iomem *base)
>  	reg = readl(base + EXYNOS4_JPEG_CNTL_REG);
>  	writel(reg & ~EXYNOS4_SOFT_RESET_HI, base + EXYNOS4_JPEG_CNTL_REG);
>  
> +#ifndef CONFIG_COMPILE_TEST
>  	ndelay(100000);
> +#endif

Wouldn't be a better fix to replace ndelay(100000); with udelay(100),
rather than sticking in a not so pretty #ifndef ?

I guess usleep_range() couldn't simply be used, since
exynos4_jpeg_sw_reset() is called with a spinlock held.

--
Regards,
Sylwester
