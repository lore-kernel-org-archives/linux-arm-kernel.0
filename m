From: dgreid@chromium.org (Dylan Reid)
Date: Tue, 23 Dec 2014 15:06:26 -0800
Subject: [alsa-devel] [PATCH 2/2] ASoC: rockchip: i2s: set TDL and RDL to
 16 bits
In-Reply-To: <1419325709-15374-3-git-send-email-jay.xu@rock-chips.com>
References: <1419325709-15374-1-git-send-email-jay.xu@rock-chips.com>
 <1419325709-15374-3-git-send-email-jay.xu@rock-chips.com>
Message-ID: <CAEUnVG79MOHUufRnJVe98ZTC4vouUNAEWtPsryEKWLc+Qpdjuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 23, 2014 at 1:08 AM, Jianqun Xu <jay.xu@rock-chips.com> wrote:
> Set Transmit Data Level(TDL) and Receive Data Level(RDL) to 16 bits.
> Without this setting, the TDL is default to be 0x00 (means 1 bit),
> and the RDL is default to be 0x1f (means 16 bits).

My impression from the TRM was that TDL and RDL were measured in
samples.  Are you sure it's 'bits'?

>
> This patch is helpful to fix pop sound, tested on rk3288 board.
>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> ---
>  sound/soc/rockchip/rockchip_i2s.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
> index c74ba37..1cd7efc 100644
> --- a/sound/soc/rockchip/rockchip_i2s.c
> +++ b/sound/soc/rockchip/rockchip_i2s.c
> @@ -247,6 +247,10 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
>
>         regmap_update_bits(i2s->regmap, I2S_TXCR, I2S_TXCR_VDW_MASK, val);
>         regmap_update_bits(i2s->regmap, I2S_RXCR, I2S_RXCR_VDW_MASK, val);
> +       regmap_update_bits(i2s->regmap, I2S_DMACR, I2S_DMACR_TDL_MASK,
> +                          I2S_DMACR_TDL(16));
> +       regmap_update_bits(i2s->regmap, I2S_DMACR, I2S_DMACR_RDL_MASK,
> +                          I2S_DMACR_RDL(16));
>
>         return 0;
>  }
> --
> 1.9.1
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
