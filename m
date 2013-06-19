From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 19 Jun 2013 12:19:40 +0200
Subject: [PATCH v2 2/2] i2c-mv64xxx: Abort the mv64xxx_of_config if
 clock-frequency is not provided
In-Reply-To: <1371570024-11613-3-git-send-email-gregory.clement@free-electrons.com>
References: <1371570024-11613-1-git-send-email-gregory.clement@free-electrons.com>
 <1371570024-11613-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130619101939.GG2950@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 05:40:24PM +0200, Gregory CLEMENT wrote:
> From: Zbigniew Bodek <zbb@semihalf.com>
> 
> This commit adds checking whether clock-frequency property acquisition
> has succeeded. Do not waste time to find baud factors if there is no
> information about the desired bus frequency in dts.
> 
> [gregory.clement at free-electrons.com: Reword the commit log]
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Zbigniew Bodek <zbb@semihalf.com>

What about setting it to 100kHz when not defined (and marking the
property optional in the docs)? That's convenient and common I'd say.

> ---
>  drivers/i2c/busses/i2c-mv64xxx.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
> index 74f8fcb..de384a1 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -591,7 +591,11 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
>  		goto out;
>  	}
>  	tclk = clk_get_rate(drv_data->clk);
> -	of_property_read_u32(np, "clock-frequency", &bus_freq);
> +
> +	rc = of_property_read_u32(np, "clock-frequency", &bus_freq);
> +	if (rc)
> +		goto out;
> +
>  	if (!mv64xxx_find_baud_factors(bus_freq, tclk,
>  				       &drv_data->freq_n, &drv_data->freq_m)) {
>  		rc = -EINVAL;
> -- 
> 1.8.1.2
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130619/c84df02f/attachment.sig>
