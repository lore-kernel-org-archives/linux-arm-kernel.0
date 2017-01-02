From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 2 Jan 2017 14:56:42 +0530
Subject: [PATCH v4 2/4] ARM: da850: don't add the emac clock to the clock
 lookup table twice
In-Reply-To: <1481124138-27337-3-git-send-email-bgolaszewski@baylibre.com>
References: <1481124138-27337-1-git-send-email-bgolaszewski@baylibre.com>
 <1481124138-27337-3-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <c41cecd3-7ede-c220-d849-9df5d3e20409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 December 2016 08:52 PM, Bartosz Golaszewski wrote:
> Similarly to the aemif clock - this screws up the linked list of clock
> children. Create a separate clock for mdio inheriting the rate from
> emac_clk.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Applied with change in headline (see comment on 1/4). Also added a 
comment explaining why mdio clk is needed.

> ---
>  arch/arm/mach-davinci/da850.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index e9d019c..6b1fbac 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -319,6 +319,11 @@ static struct clk emac_clk = {
>  	.gpsc		= 1,
>  };
>  

/*
 * In order to avoid adding the emac_clk to the clock lookup table twice (and
 * screwing up the linked list in the process) create a separate clock for
 * mdio inheriting the rate from emac_clk.
 */

> +static struct clk mdio_clk = {
> +	.name		= "mdio",
> +	.parent		= &emac_clk,
> +};

Thanks,
Sekhar
