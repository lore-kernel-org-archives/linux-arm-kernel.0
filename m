From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 23 Apr 2014 13:44:47 +0300
Subject: [PATCH 1/2] omapdss: panel-tpo-td028ec1: Add DT support.
In-Reply-To: <1398201168-25275-2-git-send-email-marek@goldelico.com>
References: <1398201168-25275-1-git-send-email-marek@goldelico.com>
 <1398201168-25275-2-git-send-email-marek@goldelico.com>
Message-ID: <5357999F.6010200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/04/14 00:12, Marek Belisko wrote:

>  static int td028ttec1_panel_probe(struct spi_device *spi)
>  {
>  	struct panel_drv_data *ddata;
> @@ -418,6 +436,10 @@ static int td028ttec1_panel_probe(struct spi_device *spi)
>  		r = td028ttec1_panel_probe_pdata(spi);
>  		if (r)
>  			return r;
> +	} else if (spi->dev.of_node) {
> +		r = td028ttec1_probe_of(spi);
> +		if (r)
> +			return r;
>  	} else {
>  		return -ENODEV;
>  	}
> @@ -463,6 +485,13 @@ static int td028ttec1_panel_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> +static const struct of_device_id td028ttec1_of_match[] = {
> +	{ .compatible = "toppoly,td028ttec1", },

We need to hack a bit here for the time being. You need to have
"omapdss," prefix for the compatible string in the driver, and add the
panel's compatible string to arch/arm/mach-omap2/display.c:
dss_compat_conv_list.

The reason for this is that the drivers are omap specific, but the DT
data is not.

Otherwise looks good to me.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140423/b05ffe8d/attachment.sig>
