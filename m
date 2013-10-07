From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 7 Oct 2013 11:18:07 +0200
Subject: [PATCH 5/5] DRM: Armada: add support for drm tda19988 driver
In-Reply-To: <E1VSwYO-0000iT-CU@rmk-PC.arm.linux.org.uk>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <E1VSwYO-0000iT-CU@rmk-PC.arm.linux.org.uk>
Message-ID: <20131007111807.5e86ea6e@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 06 Oct 2013 23:11:56 +0100
Russell King <rmk+kernel@arm.linux.org.uk> wrote:

> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/gpu/drm/armada/Kconfig      |    9 +++++++
>  drivers/gpu/drm/armada/armada_drv.c |   42 +++++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/gpu/drm/armada/Kconfig b/drivers/gpu/drm/armada/Kconfig
> index c7a0a94..87e62dd 100644
> --- a/drivers/gpu/drm/armada/Kconfig
> +++ b/drivers/gpu/drm/armada/Kconfig
> @@ -13,3 +13,12 @@ config DRM_ARMADA
>  	  This driver provides no built-in acceleration; acceleration is
>  	  performed by other IP found on the SoC.  This driver provides
>  	  kernel mode setting and buffer management to userspace.
> +
> +config DRM_ARMADA_TDA1998X
> +	bool "Support TDA1998X HDMI output"
> +	depends on DRM_ARMADA != n
> +	depends on I2C && DRM_I2C_NXP_TDA998X = y
> +	default y
> +	help
> +	  Support the TDA1998x HDMI output device found on the Solid-Run
> +	  CuBox.

It seems we are going backwards: as the Armada based boards will soon
move to full DT (mvebu), you are making an exception for the Cubox, so
that there should be Cubox specific kernels. I don't like that...

> diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
> index db62f1b..69517cf 100644
> --- a/drivers/gpu/drm/armada/armada_drv.c
> +++ b/drivers/gpu/drm/armada/armada_drv.c
> @@ -16,6 +16,42 @@
>  #include <drm/armada_drm.h>
>  #include "armada_ioctlP.h"
>  
> +#ifdef CONFIG_DRM_ARMADA_TDA1998X
> +#include <drm/i2c/tda998x.h>
> +#include "armada_slave.h"
> +
> +static struct tda998x_encoder_params params = {
> +	/* With 0x24, there is no translation between vp_out and int_vp
> +	FB	LCD out	Pins	VIP	Int Vp
> +	R:23:16	R:7:0	VPC7:0	7:0	7:0[R]
> +	G:15:8	G:15:8	VPB7:0	23:16	23:16[G]
> +	B:7:0	B:23:16	VPA7:0	15:8	15:8[B]
> +	*/
> +	.swap_a = 2,
> +	.swap_b = 3,
> +	.swap_c = 4,
> +	.swap_d = 5,
> +	.swap_e = 0,
> +	.swap_f = 1,

I still don't agree. You don't need to invert R <-> B for the Cubox at
the tda998x level: this may be done setting as it should be the
CFG_GRA_SWAPRB flag of the lcd register LCD_SPU_DMA_CTRL0.

> +	.audio_cfg = BIT(2),
> +	.audio_frame[1] = 1,
> +	.audio_format = AFMT_SPDIF,
> +	.audio_sample_rate = 44100,

These values are rather mysterious!

Looking at the tda998x driver, I found that:
- audio_cfg can be 0x03 for i2s input and 0x04 for spdif input
- audio_frame[1] is the (channel count - 1)
- audio_format and audio_sample_rate are hardcoding the audio input to
  spdif and the sample rate to 44.1kHz

I don't think that these parameters are needed:

- the tda998x must be prepared to get either i2s or spdif as the audio
  input at any time. The choice of this input results from the audio
  subsystem constraints (codec) found at audio streaming start time.

- the channel count is always 2 for spdif. Do we need to accept four
  channels for i2s?

- audio on hdmi works fine for me at any input rate setting the tda998x
  sample rate to 96 kHz. Anyway, in the actual tda998x driver, this
  audio_sample_rate value is just used to set an approximate value of
  ACR. But this value is not used because an optimal value is computed
  by the hardware thanks to the flag AIP_CNTRL_0_ACR_MAN!

	[snip]

The remaining patch is Cubox specific.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
