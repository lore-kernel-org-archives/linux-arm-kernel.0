From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 25 Sep 2012 13:14:26 +0800
Subject: [PATCH] ARM: mx28: Skip OCOTP FEC MAC setup if in DT
In-Reply-To: <1348195214-26633-1-git-send-email-marex@denx.de>
References: <1348195214-26633-1-git-send-email-marex@denx.de>
Message-ID: <20120925051424.GB27291@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 04:40:14AM +0200, Marek Vasut wrote:
> Currently, the kernel unconditionally adds "local-mac-address" and
> "mac-address" properties under both FEC ethernet DT nodes in case
> the update_fec_mac_prop() function is called. These properties are
> loaded with MAC address compiled from vendors OUI and a per-device
> NIC saved in OCOTP storage.
> 
> Some more advanced bootloaders do augment the DT passed to the kernel
> by these properties already. In such case, it is wrong for kernel to
> override these values.
> 
> Adjust the FEC MAC address loading so that in case the DT properties
> are already present in the DT passed from the bootloader, skip the
> loading from OCOTP altogether. If the DT properties are not present,
> load them from OCOTP.
> 
> Note that the later case will lead to zeroed out MAC address if OCOTP
> is not programmed. This will lead to FEC not working at all.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-mxs/mach-mxs.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> index 71d47f5..3f29a52 100644
> --- a/arch/arm/mach-mxs/mach-mxs.c
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -175,6 +175,10 @@ static void __init update_fec_mac_prop(enum mac_oui oui)
>  		np = of_find_compatible_node(from, NULL, "fsl,imx28-fec");
>  		if (!np)
>  			return;
> +
> +		if (of_get_property(np, "local-mac-address", NULL))
> +			continue;
> +

The block should be put after "from" assignment below.

>  		from = np;

Shawn

>  
>  		newmac = kzalloc(sizeof(*newmac) + 6, GFP_KERNEL);
> -- 
> 1.7.10.4
> 
