From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 25 Apr 2016 17:33:36 +0200
Subject: [PATCH 2/6] Documentation: DT binding doc for iProc Shared MDIO
 Controller.
In-Reply-To: <1461230323-27891-3-git-send-email-pramod.kumar@broadcom.com>
References: <1461230323-27891-1-git-send-email-pramod.kumar@broadcom.com>
 <1461230323-27891-3-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <20160425153336.GK6575@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +Example:
> +iproc_mdio: iproc_mdio at 663f0000 {
> +	compatible = "brcm,iproc-shared-mdio";
> +	reg = <0x6602023c 0x14>;
> +	reg-names = "mdio";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	sata-master at 6 {
> +		compatible = "brcm,iproc-ns2-sata-phy";
> +		reg = <0x6>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		brcm,phy-internal;
> +
> +		sata_phy0: sata-phy at 1 {
> +			reg = <0x1>;
> +			#phy-cells = <0>;
> +		};
> +
> +		sata_phy1: sata-phy at 2 {
> +			reg = <0x2>;
> +			#phy-cells = <0>;
> +		};
> +	};
> +
> +	eth-master at 0 {
> +		compatible = "brcm,iproc-mdio-master-eth";
> +		reg = <0x0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		gphy0: eth-phy at 10 {
> +			reg = <0x10>;
> +			phy-mode = "mii";
> +		};
> +	};
> +};

So looking at this, you have an MDIO bus, an MDIO mux on top of that,
and then some MDIO devices on the muxed busses. You don't need a whole
new framework for this. You need a new mdio-mux driver, but the
existing MDIO framework should do what you need.

	 Andrew
