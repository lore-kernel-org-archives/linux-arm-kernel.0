From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 23 Sep 2015 17:39:16 +0300
Subject: [PATCH 2/4] of: irq: Add support for the new definition of
 "msi-parent"
In-Reply-To: <1442944336-11754-3-git-send-email-marc.zyngier@arm.com>
References: <1442944336-11754-1-git-send-email-marc.zyngier@arm.com>
 <1442944336-11754-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <5602B994.9080409@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 9/22/2015 8:52 PM, Marc Zyngier wrote:

> Since 126b16e2ad98 ("Docs: dt: add generic MSI bindings"),
> the definition of "msi-parent" has evolved, while maintaining
> some degree of compatibility. It can now express multiple MSI
> controllers as parents, as well as some sideband data being
> communicated to the controller.
>
> This patch revamps the parsing of the property, iterating over
> the multiple parents until a suitable irqdomain is found.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   drivers/of/irq.c | 26 +++++++++++++++++---------
>   1 file changed, 17 insertions(+), 9 deletions(-)

    Small stylistic nit below...

> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 55317fa..c9637cf 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -586,15 +586,23 @@ err:
>    */
>   void of_msi_configure(struct device *dev, struct device_node *np)
>   {
> -	struct device_node *msi_np;
> -	struct irq_domain *d;
> +	struct of_phandle_args args;
> +	int index = 0;
>
> -	msi_np = of_parse_phandle(np, "msi-parent", 0);
> -	if (!msi_np)
> -		return;
> +	while (!of_parse_phandle_with_opt_args(np, "msi-parent", "#msi-cells",
> +					       index, &args)) {
> +		struct irq_domain *d;
>
> -	d = irq_find_matching_host(msi_np, DOMAIN_BUS_PLATFORM_MSI);
> -	if (!d)
> -		d = irq_find_host(msi_np);
> -	dev_set_msi_domain(dev, d);
> +		d = irq_find_matching_host(args.np, DOMAIN_BUS_PLATFORM_MSI);
> +		if (!d)

		if (!d) {

> +			d = irq_find_host(args.np);
> +
> +		if (d) {

		} else {

> +			dev_set_msi_domain(dev, d);
> +			return;
> +		}
> +
> +		of_node_put(args.np);
> +		index++;
> +	}
>   }
>

MBR, Sergei
