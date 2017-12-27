From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Dec 2017 22:24:01 +0000
Subject: [PATCH net-next 5/6] arm64: dts: marvell: mcbin: enable the
 fourth network interface
In-Reply-To: <20171227221446.18459-6-antoine.tenart@free-electrons.com>
References: <20171227221446.18459-1-antoine.tenart@free-electrons.com>
 <20171227221446.18459-6-antoine.tenart@free-electrons.com>
Message-ID: <20171227222401.GT10595@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 27, 2017 at 11:14:45PM +0100, Antoine Tenart wrote:
> This patch enables the fourth network interface on the Marvell
> Macchiatobin. It is configured in the 2500Base-X PHY mode.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> index b3350827ee55..c51efd511324 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> @@ -279,6 +279,14 @@
>  	phys = <&cps_comphy0 1>;
>  };
>  
> +&cps_eth2 {
> +	/* CPS Lane 5 */
> +	status = "okay";
> +	phy-mode = "2500base-x";
> +	/* Generic PHY, providing serdes lanes */
> +	phys = <&cps_comphy5 2>;
> +};
> +

This is wrong.  This lane is connected to a SFP cage which can support
more than just 2500base-X.  Tying it in this way to 2500base-X means
that this port does not support conenctions at 1000base-X, despite
that's one of the most popular and more standardised speeds.

So, I feel I have to NAK this patch in its current form.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
