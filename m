From: zhangfei.gao@linaro.org (zhangfei)
Date: Mon, 23 Nov 2015 16:10:49 +0800
Subject: [PATCH] ASoC: pxa: remove incorrect do_div() call
In-Reply-To: <7580645.enu4DmUPIv@wuerfel>
References: <7580645.enu4DmUPIv@wuerfel>
Message-ID: <5652CA09.5080101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/20/2015 05:32 PM, Arnd Bergmann wrote:
> The new optimized do_div implementation (now in asm-generic/next) exposes a
> glitch in the brownstone audio driver by producing a compile-time warning:
>
> sound/soc/pxa/brownstone.c: In function 'brownstone_wm8994_hw_params':
> sound/soc/pxa/brownstone.c:67:85: warning: comparison of distinct pointer types lacks a cast
> sound/soc/pxa/brownstone.c:67:10125: warning: right shift count >= width of type [-Wshift-count-overflow]
> sound/soc/pxa/brownstone.c:67:10254: warning: passing argument 1 of '__div64_32' from incompatible pointer type [-Wincompatible-pointer-types]
>
> The driver just divides two plain integer values, so it should not
> use do_div to start with, but has apparently done so ever since the
> code was first merged. This replaces do_div with a simple division
> operator.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I think this one is harmless, so we only need it in 4.5 to avoid the warning,
> but not backported to earlier kernels.
>
> Found today on ARM allmodconfig
>
> diff --git a/sound/soc/pxa/brownstone.c b/sound/soc/pxa/brownstone.c
> index 6147e86e9b0f..416ea646c3b1 100644
> --- a/sound/soc/pxa/brownstone.c
> +++ b/sound/soc/pxa/brownstone.c
> @@ -63,8 +63,7 @@ static int brownstone_wm8994_hw_params(struct snd_pcm_substream *substream,
>   		sysclk    = params_rate(params) * 512;
>   		sspa_mclk = params_rate(params) * 64;
>   	}
> -	sspa_div = freq_out;
> -	do_div(sspa_div, sspa_mclk);
> +	sspa_div = freq_out / sspa_mclk;
>
>   	snd_soc_dai_set_sysclk(cpu_dai, MMP_SSPA_CLK_AUDIO, freq_out, 0);
>   	snd_soc_dai_set_pll(cpu_dai, MMP_SYSCLK, 0, freq_out, sysclk);
>

Thanks Arnd.

Looks sspa_div is not used at all.
So we can remove sspa_div as well as do_div.

What do you think.

Thanks
