From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 20 May 2017 20:04:03 +0200
Subject: [PATCH] ASoC: remove NULL pointer check for clk_disable_unprepare
In-Reply-To: <1495302158-30951-1-git-send-email-yamada.masahiro@socionext.com>
References: <1495302158-30951-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170520180403.mqwfrcjsyukv3phr@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 21, 2017 at 02:42:38AM +0900, Masahiro Yamada wrote:
> After long term efforts of fixing non-common clock implementations,
> clk_disable() is a no-op for a NULL pointer input, and this is now
> tree-wide consistent.
> 
> All clock consumers can safely call clk_disable(_unprepare) without
> NULL pointer check.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  sound/soc/codecs/adau17x1.c                | 3 +--
>  sound/soc/codecs/da7213.c                  | 3 +--
>  sound/soc/codecs/da7218.c                  | 3 +--
>  sound/soc/codecs/da7219-aad.c              | 5 ++---
>  sound/soc/codecs/da7219.c                  | 3 +--
>  sound/soc/codecs/es8328.c                  | 3 +--
>  sound/soc/codecs/wm8731.c                  | 3 +--
>  sound/soc/davinci/davinci-evm.c            | 3 +--
>  sound/soc/fsl/imx-audmux.c                 | 6 ++----
>  sound/soc/intel/boards/bytcr_rt5640.c      | 2 +-
>  sound/soc/intel/boards/cht_bsw_rt5645.c    | 3 +--
>  sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 6 ++----
>  sound/soc/samsung/i2s.c                    | 3 +--
>  13 files changed, 16 insertions(+), 30 deletions(-)
> 

(...)

> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> index af3ba4d..3a06acd 100644
> --- a/sound/soc/samsung/i2s.c
> +++ b/sound/soc/samsung/i2s.c
> @@ -1122,8 +1122,7 @@ static int i2s_runtime_suspend(struct device *dev)
>  	i2s->suspend_i2scon = readl(i2s->addr + I2SCON);
>  	i2s->suspend_i2spsr = readl(i2s->addr + I2SPSR);
>  
> -	if (i2s->op_clk)
> -		clk_disable_unprepare(i2s->op_clk);
> +	clk_disable_unprepare(i2s->op_clk);
>  	clk_disable_unprepare(i2s->clk);

I think the check in i2s_runtime_resume() should be removed then as well
to keep it symmetrical. Otherwise it looks suspicious.

Best regards,
Krzysztof
