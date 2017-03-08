From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 8 Mar 2017 14:18:06 +0100
Subject: [PATCH 07/11] arm64: tegra: Enable SDHCI controllers on P3110
In-Reply-To: <38bcdf00-d85a-07fc-d557-bdca581eb333@nvidia.com>
References: <20170223173053.19701-1-thierry.reding@gmail.com>
 <20170223173053.19701-7-thierry.reding@gmail.com>
 <38bcdf00-d85a-07fc-d557-bdca581eb333@nvidia.com>
Message-ID: <20170308131806.GF29118@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 11:46:10AM +0000, Jon Hunter wrote:
> 
> On 23/02/17 17:30, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > The P3110 processor module wires one of the SDHCI controllers to an on-
> > board eMMC and exposes another set of SD/MMC signals on the connector to
> > support an external SD/MMC card. A third controller is connected to the
> > SDIO pins of an M.2 KEY E connector.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi | 42 ++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> > index 1a9ac73b4ecb..b18e166527d8 100644
> > --- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> > +++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> > @@ -7,6 +7,8 @@
> >  	compatible = "nvidia,p3310", "nvidia,tegra186";
> >  
> >  	aliases {
> > +		sdhci0 = "/sdhci at 3460000";
> > +		sdhci1 = "/sdhci at 3400000";
> 
> Any reason why you don't include all 3 sdhci controllers here?

It turns out this is completely useless. The intention had been to make
sdhci at 3460000 appear as mmc0 and sdhci at 3400000 as mmc1 in order to give
a more natural ordering (built-in eMMC first, then external SD/MMC) but
there's no code in the kernel that will enforce this.

This is also the reason why sdhci at 3440000 is not included in this list
because it connects to a WIFI/Bluetooth module.

I'm slightly leaning towards leaving this in and possibly write a patch
to enforce ordering as given by the aliases. Of course nobody in their
right mind should be depending on the device names remaining the same
and use partition UUIDs or labels instead. But having enforcing the
order would still provide the least surprise.

> 
> >  		serial0 = &uarta;
> >  		i2c0 = "/bpmp/i2c";
> >  		i2c1 = "/i2c at 3160000";
> > @@ -72,6 +74,32 @@
> >  		status = "okay";
> >  	};
> >  
> > +	/* SDMMC1 (SD/MMC) */
> > +	sdhci at 3400000 {
> > +		status = "okay";
> > +
> > +		cd-gpios = <&gpio TEGRA_MAIN_GPIO(P, 6) GPIO_ACTIVE_LOW>;
> 
> I see the CD as P-5 and not P-6 on the schematic.

Urgh... I probably mixed these up by looking at the Parker datasheet
(not sure if that's publicly available yet) and that says PP.05 actually
has the SDMMC3_CD special function. But since these are used as plain
GPIOs that's not where the function is defined. And indeed I see that
the schematics has PP.05 as the CD for SDMMC1.

Strangely I remember card-detect working with the above...

> > +		wp-gpios = <&gpio TEGRA_MAIN_GPIO(P, 4) GPIO_ACTIVE_LOW>;
> > +
> > +		vqmmc-supply = <&vddio_sdmmc1>;
> > +		vmmc-supply = <&vdd_sd>;
> 
> The card slot is on the carrier board and although the cd and wp pins
> are allocated on the cvm, I did not see a reference to the vmmc-supply
> on the cvm. So should the 'vmmc-supply' be in the carrier board file?

Yes, I think it's best to move vmmc-supply to the P2771 board file...

> 
> > +	};
> > +
> > +	/* SDMMC3 (SDIO) */
> > +	sdhci at 3440000 {
> > +		status = "okay";
> > +	};
> > +
> > +	/* SDMMC4 (eMMC) */
> > +	sdhci at 3460000 {
> > +		status = "okay";
> > +		bus-width = <8>;
> > +		non-removable;
> > +
> > +		vqmmc-supply = <&vdd_1v8_ap>;
> > +		vmmc-supply = <&vdd_3v3_sys>;
> > +	};
> > +
> >  	hsp at 3c00000 {
> >  		status = "okay";
> >  	};
> > @@ -333,5 +361,19 @@
> >  
> >  			vin-supply = <&vdd_1v8>;
> >  		};
> > +
> > +		vdd_sd: regulator at 2 {
> > +			compatible = "regulator-fixed";
> > +			reg = <2>;
> > +
> > +			regulator-name = "SD_CARD_SW_PWR";
> > +			regulator-min-microvolt = <3300000>;
> > +			regulator-max-microvolt = <3300000>;
> > +
> > +			gpio = <&gpio TEGRA_MAIN_GPIO(P, 5) GPIO_ACTIVE_HIGH>;
> 
> Here I see the gpio as P-6 and not P-5.

Yes, that also matches the schematics that I have. Strange how this
would still all work given the mixup...

> > +			enable-active-high;
> > +
> > +			vin-supply = <&vdd_3v3_sys>;
> > +		};
> >  	};
> >  };
> 
> I also see the above regulator on the carrier board and not on the cvm.

... and move this to the P2771 board file as well.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170308/66e5b002/attachment.sig>
