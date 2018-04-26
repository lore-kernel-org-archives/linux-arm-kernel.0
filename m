From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 26 Apr 2018 09:19:17 +0200
Subject: [PATCH 1/2] can: flexcan: fix endianess detection
In-Reply-To: <20180425145040.22031-2-u.kleine-koenig@pengutronix.de>
References: <20180425145040.22031-1-u.kleine-koenig@pengutronix.de>
 <20180425145040.22031-2-u.kleine-koenig@pengutronix.de>
Message-ID: <6ab7ce71-ee02-c959-49b4-c1cc569e46ba@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2018 04:50 PM, Uwe Kleine-K?nig wrote:
> In commit 88462d2a7830 ("can: flexcan: Remodel FlexCAN register r/w APIs
> for big endian FlexCAN controllers.") the following logic was
> implemented:
> 
> 	if the dt property "big-endian" is given or
> 	   the device is compatible to "fsl,p1010-flexcan":
> 		use big-endian mode;
> 	else
> 		use little-endian mode;
> 
> This relies on commit d50f4630c2e1 ("arm: dts: Remove p1010-flexcan
> compatible from imx series dts") which was applied a few commits later.
> Without this commit (or an old device tree used for booting a new
> kernel) the flexcan devices on i.MX25, i.MX28, i.MX35 and i.MX53 match
> the 'the device is compatible to "fsl,p1010-flexcan"' test and so are
> switched erroneously to big endian mode.
> 
> Instead of the check above put a flag into devtype data and rely on
> of_match_device yielding the most compatible match
> 
> Fixes: 88462d2a7830 ("can: flexcan: Remodel FlexCAN register r/w APIs for big endian FlexCAN controllers.")
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/net/can/flexcan.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 634c51e6b8ae..a6cbbe689eab 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -262,6 +262,7 @@ struct flexcan_regs {
>  
>  struct flexcan_devtype_data {
>  	u32 quirks;		/* quirks needed for different IP cores */
> +	bool default_be;
>  };

What about adding this to quirks?

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180426/9d9169f4/attachment.sig>
