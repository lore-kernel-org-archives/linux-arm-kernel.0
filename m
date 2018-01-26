From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 26 Jan 2018 11:30:38 +0300
Subject: [RFC 10/37] soc: renesas: rcar-rst: Enable watchdog as reset
 trigger for Gen2
In-Reply-To: <1516903391-30467-11-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1516903391-30467-11-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <e1670c79-2fef-b45b-4688-a6ba8ebd8c24@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 1/25/2018 9:02 PM, Fabrizio Castro wrote:

> This patch allows for platform specific quirks as some of the SoC need
> further customization for the watchdog to work properly, like for R-Car
> Gen2 and for RZ/G.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> ---
>   drivers/soc/renesas/rcar-rst.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/renesas/rcar-rst.c b/drivers/soc/renesas/rcar-rst.c
> index f7a0d54..5f52aea 100644
> --- a/drivers/soc/renesas/rcar-rst.c
> +++ b/drivers/soc/renesas/rcar-rst.c
> @@ -13,8 +13,18 @@
>   #include <linux/of_address.h>
>   #include <linux/soc/renesas/rcar-rst.h>
>   
> +#define WDTRSTCR_RESET		0xA55A0002
> +#define WDTRSTCR		0x0054
> +
> +static int gen2_configuration(void __iomem *base)
> +{
> +	iowrite32(WDTRSTCR_RESET, base + WDTRSTCR);
> +	return 0;
> +}
> +
>   struct rst_config {
> -	unsigned int modemr;	/* Mode Monitoring Register Offset */
> +	unsigned int modemr;		/* Mode Monitoring Register Offset */
> +	int (*configure)(void *base);	/* Platform specific configuration */
>   };
>   
>   static const struct rst_config rcar_rst_gen1 __initconst = {
> @@ -23,6 +33,7 @@ static const struct rst_config rcar_rst_gen1 __initconst = {
>   
>   static const struct rst_config rcar_rst_gen2 __initconst = {
>   	.modemr = 0x60,
> +	.configure = gen2_configuration,

    Why not call the method gen2_configure() then?

[...]

MBR, Sergei
