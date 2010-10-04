From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 4 Oct 2010 15:02:08 -0700
Subject: [PATCH 9/10] ASoC: SAMSUNG: Add S/PDIF CPU driver
In-Reply-To: <1286194397-19904-1-git-send-email-sw.youn@samsung.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
	<1286194397-19904-1-git-send-email-sw.youn@samsung.com>
Message-ID: <20101004220207.GA3545@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 04, 2010 at 09:13:17PM +0900, Seungwhan Youn wrote:

> +static int spdif_set_sysclk(struct snd_soc_dai *cpu_dai,
> +				int clk_id, unsigned int freq, int dir)
> +{

If you save the clock rate here...

> +	case SND_SOC_SPDIF_MAIN_AUDIO_CLK:
> +		switch (div) {
> +		case 256:
> +			con |= CON_MCLKDIV_256FS;
> +			break;
> +		case 384:
> +			con |= CON_MCLKDIV_384FS;
> +			break;
> +		case 512:
> +			con |= CON_MCLKDIV_512FS;
> +			break;

...then you can calculate this dynamically at runtime in hw_params which
makes life easier for users.

> +/**
> + * struct samsung_spdif_info - Samsung S/PDIF Controller information
> + * @lock: Spin lock for S/PDIF.
> + * @dev: The parent device passed to use from the probe.
> + * @regs: The pointer to the device register block.
> + * @pclk: The peri-clock pointer for spdif master operation.
> + * @sclk: The source clock pointer for making sync signals.
> + * @save_clkcon: Backup clkcon reg. in suspend.
> + * @save_con: Backup con reg. in suspend.
> + * @save_cstas: Backup cstas reg. in suspend.
> + * @dma_playback: DMA information for playback channel.
> + */
> +struct samsung_spdif_info {
> +	spinlock_t	lock;

No need to have this in the headers.

> +/* Registers */
> +#define CLKCON				0x00
> +#define CON				0x04
> +#define BSTAS				0x08

These should all be namespaced or in the driver file to avoid collisoons
with other things - even if only used in this driver things like CON are
risky for collisions with normal kernel headers the driver needs.
