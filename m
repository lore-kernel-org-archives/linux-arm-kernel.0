From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 13 Jun 2015 19:30:42 +0100
Subject: [PATCH 1/1] iio:adc: XADC: Set offset explicitly to zero on
 voltage channels
In-Reply-To: <1434010946-8118-1-git-send-email-imrehg@gmail.com>
References: <1434010946-8118-1-git-send-email-imrehg@gmail.com>
Message-ID: <557C76D2.7030306@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/15 09:22, Gergely Imreh wrote:
> The Xilinx XADC driver has both a temperature channel and 8 voltage
> channels. The voltage channels have no offset, but actually were still
> set the same offset as the temperature channel. This did not cause
> problems in /sys/bus/iio/ but can cause problems with other drivers
> using iio data. For example iio-hwmon did return wrong voltage values
> because of the offset.
> 
> Change tested with the Parallella board.
> 
> Signed-off-by: Gergely Imreh <imrehg@gmail.com>
Well spotted on the bug, but I think we are better off fixing this at the
true source of the problem which is in drivers/iio/inkern.c 
iio_convert_raw_to_processed_unlocked which does a call to 
iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_OFFSET) then uses
the error return to check if the offset parameter is available. It should
be checking that before making this call with a call to iio_channel_has_info.

I don't suppose you could prepare a patch fixing that as you found the problem?

If not I can fix it up sometime if no one else beats me to it.

Thanks

Jonathan
> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index ab52be2..36efab7 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -877,9 +877,17 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		}
>  	case IIO_CHAN_INFO_OFFSET:
> -		/* Only the temperature channel has an offset */
> -		*val = -((273150 << 12) / 503975);
> -		return IIO_VAL_INT;
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = 0;
> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			/* Only the temperature channel has an offset */
> +			*val = -((273150 << 12) / 503975);
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		ret = xadc_read_adc_reg(xadc, XADC_REG_CONF2, &val16);
>  		if (ret)
> 
