From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 23 Feb 2015 16:04:08 +0100
Subject: [PATCH] [media] s5p-jpeg: Clear JPEG_CODEC_ON bits in sw reset
 function
In-Reply-To: <1418797339-27877-1-git-send-email-tony.kn@samsung.com>
References: <1418797339-27877-1-git-send-email-tony.kn@samsung.com>
Message-ID: <54EB4168.7090007@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 17/12/14 07:22, Tony K Nadackal wrote:
> Bits EXYNOS4_DEC_MODE and EXYNOS4_ENC_MODE do not get cleared
> on software reset. These bits need to be cleared explicitly.
> 
> Signed-off-by: Tony K Nadackal <tony.kn@samsung.com>
> ---
> This patch is created and tested on top of linux-next-20141210.
> It can be cleanly applied on media-next and kgene/for-next.
> 
> 
>  drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c b/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
> index ab6d6f43..e53f13a 100644
> --- a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
> +++ b/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
> @@ -21,6 +21,10 @@ void exynos4_jpeg_sw_reset(void __iomem *base)
>  	unsigned int reg;
>  
>  	reg = readl(base + EXYNOS4_JPEG_CNTL_REG);
> +	writel(reg & ~(EXYNOS4_DEC_MODE | EXYNOS4_ENC_MODE),
> +				base + EXYNOS4_JPEG_CNTL_REG);
> +
> +	reg = readl(base + EXYNOS4_JPEG_CNTL_REG);

Do we really need the second read? Wouldn't it also work as below ?

  	reg = readl(base + EXYNOS4_JPEG_CNTL_REG);

+	reg &= ~(EXYNOS4_DEC_MODE | EXYNOS4_ENC_MODE);
+	writel(reg, base + EXYNOS4_JPEG_CNTL_REG);

?
>  	writel(reg & ~EXYNOS4_SOFT_RESET_HI, base + EXYNOS4_JPEG_CNTL_REG);
>  
>  	udelay(100);
--
Thanks,
Sylwester
