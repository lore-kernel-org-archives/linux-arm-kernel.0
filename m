From: jhogan@kernel.org (James Hogan)
Date: Fri, 9 Mar 2018 14:44:21 +0000
Subject: [PATCH v4 7/8] MIPS: BMIPS: Add PCI bindings for 7425, 7435
In-Reply-To: <1516058925-46522-8-git-send-email-jim2101024@gmail.com>
References: <1516058925-46522-1-git-send-email-jim2101024@gmail.com>
 <1516058925-46522-8-git-send-email-jim2101024@gmail.com>
Message-ID: <20180309144420.GG24558@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 06:28:44PM -0500, Jim Quinlan wrote:
> diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
> index e4fb9b6..02168d0 100644
> --- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
> +++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
> @@ -495,4 +495,30 @@
>  			status = "disabled";
>  		};
>  	};
> +
> +	pcie: pcie at 10410000 {
> +		reg = <0x10410000 0x830c>;
> +		compatible = "brcm,bcm7425-pcie";
> +		interrupts = <37>, <37>;
> +		interrupt-names = "pcie", "msi";
> +		interrupt-parent = <&periph_intc>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		linux,pci-domain = <0>;
> +		brcm,enable-ssc;
> +		bus-range = <0x00 0xff>;
> +		msi-controller;
> +		#interrupt-cells = <1>;
> +		/* 4x128mb windows */
> +		ranges = <0x2000000 0x0 0xd0000000 0xd0000000 0 0x08000000>,
> +			 <0x2000000 0x0 0xd8000000 0xd8000000 0 0x08000000>,
> +			 <0x2000000 0x0 0xe0000000 0xe0000000 0 0x08000000>,
> +			 <0x2000000 0x0 0xe8000000 0xe8000000 0 0x08000000>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &periph_intc 33
> +				 0 0 0 2 &periph_intc 34
> +				 0 0 0 3 &periph_intc 35
> +				 0 0 0 4 &periph_intc 36>;

no status = "disabled" like the other dtsi?

> +	};
> +
>  };
> diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
> index 1484e89..84881224 100644
> --- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
> +++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
> @@ -510,4 +510,31 @@
>  			status = "disabled";
>  		};
>  	};
> +
> +	pcie: pcie at 10410000 {
> +		reg = <0x10410000 0x930c>;
> +		interrupts = <0x27>, <0x27>;
> +		interrupt-names = "pcie", "msi";
> +		interrupt-parent = <&periph_intc>;
> +		compatible = "brcm,bcm7435-pcie";

Might be nice to be consistent in your property ordering between these
two dtsi files. I for one would prefer compatible to be near the top
too, if only for consistency with most other nodes in these files.

> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		linux,pci-domain = <0>;
> +		brcm,enable-ssc;
> +		bus-range = <0x00 0xff>;
> +		msi-controller;
> +		#interrupt-cells = <1>;
> +		/* 4x128mb windows */
> +		ranges = <0x2000000 0x0 0xd0000000 0xd0000000 0 0x08000000>,
> +			 <0x2000000 0x0 0xd8000000 0xd8000000 0 0x08000000>,
> +			 <0x2000000 0x0 0xe0000000 0xe0000000 0 0x08000000>,
> +			 <0x2000000 0x0 0xe8000000 0xe8000000 0 0x08000000>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &periph_intc 35
> +				 0 0 0 2 &periph_intc 36
> +				 0 0 0 3 &periph_intc 37
> +				 0 0 0 4 &periph_intc 38>;
> +		status = "disabled";
> +	};
> +
>  };

Cheers
James
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180309/edb1389d/attachment.sig>
