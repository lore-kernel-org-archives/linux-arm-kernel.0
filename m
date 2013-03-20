From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 20 Mar 2013 18:12:05 +0800
Subject: [PATCH V2 1/3] ARM: dts: tegra: add clock source for PMC
In-Reply-To: <51489586.9090605@wwwdotorg.org>
References: <1363594199-10974-1-git-send-email-josephl@nvidia.com>
 <1363594199-10974-2-git-send-email-josephl@nvidia.com>
 <51489586.9090605@wwwdotorg.org>
Message-ID: <1363774325.5697.19.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-20 at 00:42 +0800, Stephen Warren wrote:
> On 03/18/2013 02:09 AM, Joseph Lo wrote:
> > The clock source of PMC is PCLK. Adding it into DTS for Tegra20 and Tegra30.
> 
> > diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> 
> >  	pmc {
> >  		compatible = "nvidia,tegra20-pmc";
> >  		reg = <0x7000e400 0x400>;
> > +		clocks = <&tegra_car 110>;
> >  	};
> 
> The DT binding documentation needs to list the set of clocks that must
> be present.
> 
> Doesn't the PMC also receive a "clk32k_in" from the PMIC, or is that
> routed into the CAR, and then into the PMC? Either way, the PMC module
> receives that clock somehow. Since there are multiple clocks, that also
> means that a clock-names property is required.

Do you mean the DTS below and add it into binding document?

/ SoC dts including file
pmc {
	compatible = "nvidia,tegra20-pmc";
	reg = <0x7000e400 0x400>;
	clocks = <&tegra_car 110>, <&clk32k_in>;
	clock-names= "pclk", "clk32k_in";
};

/ Tegra board dts file

pmic {
	...
	clocks {
		compatible = "simple-bus";
		#address-cells = <1>;
		#size-cells = <0>;

		clk32k_in: clock at 0 {
			compatible = "fixed-clock";
			reg=<0>;
			#clock-cells = <0>;
			clock-frequency = <32768>;
		};
	};
};
