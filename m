From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 16 Jun 2013 00:47:09 +0400
Subject: [PATCH v3] ARM: shmobile: BOCK-W: add Ether support
In-Reply-To: <201306020240.55702.sergei.shtylyov@cogentembedded.com>
References: <201306020240.55702.sergei.shtylyov@cogentembedded.com>
Message-ID: <51BCD2CD.4020407@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2013 02:40 AM, Sergei Shtylyov wrote:

> Register Ether device from bockw_init(), passing the platform data to it, adding
> only the RMII pin group to bockw_pinctrl_map[].  Although the LINK signal exists
> on the board, it's connected to the link/activity LED  output of the PHY, thus
> the link disappears and reappears after each packet. We'd be better off ignoring
> such signal and getting the link state from the PHY indirectly.

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
> The patch is atop of Simon's 'renesas.git' repo, 'renesas-next-20130528' tag
> and the USB patches just reposted. I decided to move it ahead of the VIN patches
> as it can be merged right now since all dependecies have been already met.

> Changes from version 2:
> - resolved rejects due to patch move;
> - removed the code dealing with the pin conflict with VIN1 and the note related
>    to it from the changelog.

> Changes from the original posting:
> - refreshed the patch.

>   arch/arm/mach-shmobile/board-bockw.c |   18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)

> Index: renesas/arch/arm/mach-shmobile/board-bockw.c
> ===================================================================
> --- renesas.orig/arch/arm/mach-shmobile/board-bockw.c
> +++ renesas/arch/arm/mach-shmobile/board-bockw.c
> @@ -65,7 +65,24 @@ static struct sh_mobile_sdhi_info sdhi0_
>
>   static struct rcar_phy_platform_data usb_phy_platform_data __initdata;
>
> +static struct sh_eth_plat_data ether_platform_data __initdata = {
> +	.phy		= 0x01,
> +	.edmac_endian	= EDMAC_LITTLE_ENDIAN,
> +	.register_type	= SH_ETH_REG_FAST_RCAR,
> +	.phy_interface	= PHY_INTERFACE_MODE_RMII,
> +	/*
> +	 * Although the LINK signal is available on the board, it's connected to
> +	 * the link/activity LED output of the PHY, thus the link disappears and
> +	 * reappears after each packet.  We'd be better off ignoring such signal
> +	 * and getting the link state from the PHY indirectly.
> +	 */
> +	.no_ether_link	= 1,
> +};
> +
>   static const struct pinctrl_map bockw_pinctrl_map[] = {
> +	/* Ether */
> +	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7778",

    Darn, I should have changed that to "r8a777x-ether" in view of the 
changes queued in the 'net-next.git' repo and the v2 of the "fix Ether 
device name" patch. I've completely overlooked that...

WBR, Sergei
