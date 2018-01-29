From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Jan 2018 10:27:39 +0100
Subject: [PATCH v2 04/16] iio: adc: sun4i-gpadc-iio: rework: sampling
 start/end code readout reg
In-Reply-To: <20180128232919.12639-5-embed3d@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-5-embed3d@gmail.com>
Message-ID: <20180129092739.665yh3k7pb3ty33u@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 29, 2018 at 12:29:07AM +0100, Philipp Rossak wrote:
> For adding newer sensor some basic rework of the code is necessary.
> 
> This commit reworks the code and allows the sampling start/end code and
> the position of value readout register to be altered. Later the start/end
> functions will be used to configure the ths and start/stop the
> sampling.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>

That signed-off-by chain doesn't really make much sense. If Icenowy is
the author, she should be reported as such in the commit, and if
you're the author, you shouldn't have her Signed-off-by.

> ---
>  drivers/iio/adc/sun4i-gpadc-iio.c | 44 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index 03804ff9c006..db57d9fffe48 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -49,6 +49,15 @@ static unsigned int sun6i_gpadc_chan_select(unsigned int chan)
>  	return SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(chan);
>  }
>  
> +struct sun4i_gpadc_iio;
> +
> +/*
> + * Prototypes for these functions, which enable these functions to be
> + * referenced in gpadc_data structures.
> + */
> +static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info);
> +static int sun4i_gpadc_sample_end(struct sun4i_gpadc_iio *info);
> +
>  struct gpadc_data {
>  	int		temp_offset;
>  	int		temp_scale;
> @@ -56,6 +65,9 @@ struct gpadc_data {
>  	unsigned int	tp_adc_select;
>  	unsigned int	(*adc_chan_select)(unsigned int chan);
>  	unsigned int	adc_chan_mask;
> +	unsigned int	temp_data;
> +	int		(*sample_start)(struct sun4i_gpadc_iio *info);
> +	int		(*sample_end)(struct sun4i_gpadc_iio *info);
>  };
>  
>  static const struct gpadc_data sun4i_gpadc_data = {
> @@ -65,6 +77,9 @@ static const struct gpadc_data sun4i_gpadc_data = {
>  	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
>  	.adc_chan_select = &sun4i_gpadc_chan_select,
>  	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
> +	.temp_data = SUN4I_GPADC_TEMP_DATA,

You can use a regmap_field there.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180129/fc2a1896/attachment.sig>
