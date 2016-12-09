From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 09 Dec 2016 09:57:07 +0000
Subject: [PATCH v2 2/2] firmware: arm_scpi: check the payload length in
 scpi_send_message
In-Reply-To: <20161125005432.1205-3-martin.blumenstingl@googlemail.com>
References: <20161124001845.20830-1-martin.blumenstingl@googlemail.com>
 <20161125005432.1205-1-martin.blumenstingl@googlemail.com>
 <20161125005432.1205-3-martin.blumenstingl@googlemail.com>
Message-ID: <1481277427.2902.12.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-11-25 at 01:54 +0100, Martin Blumenstingl wrote:
> This adds a sanity check to ensure we're not writing data beyond the
> end of our rx_buf and tx_buf. Currently we are still far from reaching
> this limit, so this is a non-critical fix.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/firmware/arm_scpi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
> index 8c183d8..78ea8c7 100644
> --- a/drivers/firmware/arm_scpi.c
> +++ b/drivers/firmware/arm_scpi.c
> @@ -538,6 +538,11 @@ static int scpi_send_message(u8 idx, void *tx_buf, unsigned int tx_len,
>  			scpi_info->num_chans;
>  	scpi_chan = scpi_info->channels + chan;
>  
> +	if (tx_len > scpi_chan->max_payload_len)
> +		return -EINVAL;
> +	if (rx_len > scpi_chan->max_payload_len)
> +		return -EINVAL;

What is max_payload_len? I don't see it in anywhere in the kernel tree.
Also, why is the check needed? Surely having a channel not be able to
support the requirements of the SCPI protocol is a bit of a
design/configuration flaw of the system and shouldn't happen. If a check
is really needed perhaps it also warrants a WARN_ON or similar?

> +
>  	msg = get_scpi_xfer(scpi_chan);
>  	if (!msg)
>  		return -ENOMEM;

-- 
Tixy
