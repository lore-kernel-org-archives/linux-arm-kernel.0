From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 22 Oct 2013 15:53:57 -0700
Subject: [PATCH] SOUND/SPI: Fix "clk_round_rate" undefined reference error.
In-Reply-To: <1381228833-24082-1-git-send-email-csmanjuvijay@gmail.com>
References: <1381228833-24082-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <20131022225357.GB19819@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Majunath,

On Tue, Oct 08, 2013 at 04:10:33PM +0530, Majunath Goudar wrote:
> This patch adds a COMMON_CLK dependency to configure the
> SND_AT73C213 for Atmel AT73C213 DAC driver. Without this patch,
> build system can lead to build failure. This was observed during
> randconfig testing, in which SND_AT73C213 was enabled w/o COMMON_CLK
> being enabled. leading to the following error:
> 
> sound/built-in.o: In function `snd_at73c213_probe':
> :(.text+0x328c4): undefined reference to `clk_round_rate'
> make: *** [vmlinux] Error 1
> 
> Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  sound/spi/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/spi/Kconfig b/sound/spi/Kconfig
> index e6485be..798d1ee 100644
> --- a/sound/spi/Kconfig
> +++ b/sound/spi/Kconfig
> @@ -11,7 +11,7 @@ if SND_SPI
>  
>  config SND_AT73C213
>  	tristate "Atmel AT73C213 DAC driver"
> -	depends on ATMEL_SSC
> +	depends on ATMEL_SSC && COMMON_CLK

I do not see clk_round_rate() being protected by CONFIG_COMMON_CLK so it
looks to me that ATMEL_SSC is at fault here.

Thanks.

-- 
Dmitry
