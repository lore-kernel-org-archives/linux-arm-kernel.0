From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue, 20 May 2014 10:44:41 +0530
Subject: [PATCH] ASoC: samsung: Allow setting OP_CLK of the IIS Multi
 Audio Interface
In-Reply-To: <1400520638-6907-1-git-send-email-s.nawrocki@samsung.com>
References: <1400520638-6907-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <537AE4C1.7050703@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/2014 11:00 PM, Sylwester Nawrocki wrote:
> This patch adds support for setting source clock of the "Core CLK"
> of the IIS Multi Audio Interface.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c |    4 ++++
>  sound/soc/samsung/i2s.h |    1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> index 048ead9..ae02811 100644
> --- a/sound/soc/samsung/i2s.c
> +++ b/sound/soc/samsung/i2s.c
> @@ -451,6 +451,10 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
>  	u32 mod = readl(i2s->addr + I2SMOD);
>  
>  	switch (clk_id) {
> +	case SAMSUNG_I2S_OPCLK:
> +		mod &= ~MOD_OPCLK_MASK;
> +		mod |= dir;

I am assuming here that dir is one of SND_SOC_CLOCK_IN or
SND_SOC_CLOCK_OUT. In that case, you need to take care of offset (30).

Also the value of this bit-field doesn't match with SND_SOC_CLOCK_XXX
macros.

Bit-field (2'b):
00	Codec Clock out
01	Codec Clock in
10	Bit clock out
11	Audio bus clock

Value of macros:
SND_SOC_CLOCK_IN	0
SND_SOC_CLOCK_OUT	1

In the manual, this field is suggested to be Audio bus clock always. Is
there an use-case where we might need to update this?

The default value for audio playback right now is 00 (2'b), which needs
to be fixed anyways.

-- 
Tushar Behera
