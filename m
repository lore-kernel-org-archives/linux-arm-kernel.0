From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 20 Jun 2012 13:36:50 +0800
Subject: [PATCH] ARM: mxs: store mac address read from OTP in device tree
In-Reply-To: <1340119246-17471-1-git-send-email-shawn.guo@linaro.org>
References: <1340119246-17471-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120620053649.GG10387@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2012 at 11:20:46PM +0800, Shawn Guo wrote:
> The non-DT boot reads the mac from OTP and pass it to fec driver via
> platform data.  The patch provides an equivalent support for device
> tree boot, with reading mac from OTP and store it in device tree,
> and fec driver can get the mac from device tree at its probe time.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-mxs/mach-mxs.c |   64 ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 64 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> index 8cac94b..167f649 100644
> --- a/arch/arm/mach-mxs/mach-mxs.c
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -71,6 +71,68 @@ static struct sys_timer imx28_timer = {
>  	.init = imx28_timer_init,
>  };
>  
> +enum mac_oui {
> +	OUI_FSL,
> +	OUI_DENX,
> +};
> +
> +static void __init update_fec_mac_prop(enum mac_oui oui)
So this is a general function, right?
Then i would like it to be really general.

> +{
> +	struct device_node *np, *from = NULL;
> +	struct property *oldmac, *newmac;
> +	const u32 *ocotp = mxs_get_ocotp();
> +	u8 *macaddr;
> +	u32 val;
> +	int i;
> +
> +	for (i = 0; i < 2; i++) {
First, this is board specific.
Not all the boards have two mac, right?

> +		np = of_find_compatible_node(from, NULL, "fsl,imx28-fec");
> +		if (!np)
> +			return;
> +		from = np;
> +
> +		newmac = kzalloc(sizeof(*newmac) + 6, GFP_KERNEL);
> +		if (!newmac)
> +			return;
> +		newmac->value = newmac + 1;
> +		newmac->length = 6;
> +
> +		newmac->name = kstrdup("local-mac-address", GFP_KERNEL);
> +		if (!newmac->name) {
> +			kfree(newmac);
> +			return;
> +		}
> +
> +		/*
> +		 * OCOTP only stores the last 4 octets for each mac address,
> +		 * so hard-code OUI here.
Is it possible that customer boards store a different size of octets in OCOTP
because spec does not define it?
If yes, this possible should not be hard coded in general function.

> +		 */
> +		macaddr = newmac->value;
> +		switch (oui) {
> +		case OUI_FSL:
> +			macaddr[0] = 0x00;
> +			macaddr[1] = 0x04;
> +			macaddr[2] = 0x9f;
> +			break;
> +		case OUI_DENX:
> +			macaddr[0] = 0xc0;
> +			macaddr[1] = 0xe5;
> +			macaddr[2] = 0x4e;
Personally i would like these board specific data out of this function.

> +			break;
> +		}
> +		val = ocotp[i];
> +		macaddr[3] = (val >> 16) & 0xff;
> +		macaddr[4] = (val >> 8) & 0xff;
> +		macaddr[5] = (val >> 0) & 0xff;
....
> +
> +		oldmac = of_find_property(np, newmac->name, NULL);
> +		if (oldmac)
> +			prom_update_property(np, newmac, oldmac);
> +		else
> +			prom_add_property(np, newmac);
Grant gave a suggestion before that we'd better change prom_update_property
behavior to add_or_update from update only.
I did a patch like that, with the patch the code here will become more simple.
I will send it out in this thread for you to see if it helps.

> +	}
> +}
> +
>  static void __init imx28_evk_init(void)
>  {
>  	struct clk *clk;
> @@ -79,6 +141,8 @@ static void __init imx28_evk_init(void)
>  	clk = clk_get_sys("enet_out", NULL);
>  	if (!IS_ERR(clk))
>  		clk_prepare_enable(clk);
> +
> +	update_fec_mac_prop(OUI_FSL);
>  }
>  
>  static void __init mxs_machine_init(void)
> -- 
> 1.7.5.4
> 

Regards
Dong Aisheng
