From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 08 Jul 2013 16:19:28 +0200
Subject: [PATCH v3 12/13] ARM: dts: Add S5K5BA sensor regulator
 definitions for Trats board
In-Reply-To: <51DAC8E8.2070405@samsung.com>
References: <1372692155-17653-1-git-send-email-s.nawrocki@samsung.com>
 <11736061.3CXfgF4Q9h@flatron> <51DAC8E8.2070405@samsung.com>
Message-ID: <5262209.9MjIZ8EmKh@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 of July 2013 16:12:56 Sylwester Nawrocki wrote:
> Hi,
> 
> On 07/06/2013 01:26 AM, Tomasz Figa wrote:
> > On Monday 01 of July 2013 17:22:34 Sylwester Nawrocki wrote:
> >> From: Andrzej Hajda <a.hajda@samsung.com>
> >> 
> >> Add MAX8998 LDO12 and fixed voltage regulator nodes. While at it,
> >> all fixed voltage regulator nodes are grouped in a 'regulators' node.
> >> 
> >> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> >> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> >> ---
> >> 
> >>  arch/arm/boot/dts/exynos4210-trats.dts |   80
> >> 
> >> +++++++++++++++++++++++++------- 1 file changed, 64 insertions(+), 16
> >> deletions(-)
> >> 
> >> diff --git a/arch/arm/boot/dts/exynos4210-trats.dts
> >> b/arch/arm/boot/dts/exynos4210-trats.dts index 6b1568e..f62e299 100644
> >> --- a/arch/arm/boot/dts/exynos4210-trats.dts
> >> +++ b/arch/arm/boot/dts/exynos4210-trats.dts
> >> @@ -30,13 +30,64 @@
> >> 
> >>  		bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5
> > 
> > rootwait
> > 
> >> earlyprintk panic=5"; };
> >> 
> >> -	vemmc_reg: voltage-regulator at 0 {
> >> -	        compatible = "regulator-fixed";
> >> -		regulator-name = "VMEM_VDD_2.8V";
> >> -		regulator-min-microvolt = <2800000>;
> >> -		regulator-max-microvolt = <2800000>;
> >> -		gpio = <&gpk0 2 0>;
> >> -		enable-active-high;
> >> +	regulators {
> >> +		compatible = "simple-bus";
> >> +		#address-cells = <1>;
> >> +		#size-cells = <0>;
> > 
> > I don't think any addressing is needed for these regulators, so I'd
> > suggest removing those #properties and replacing @N with -N suffix.
> 
> Originally there were also 'reg' properties in the individual regulator
> nodes, but these were unused and I've removed them before posting. Just
> missed to get rid of #size/address-cells as well. Please note you
> similarly use such properties in patch [1].

Oh, you got me here. I must have forgotten to remove them as well.

As we already noticed some time ago, mistakes propagate much faster than 
correct solutions. ;)

> I suppose it is correct to have something like:
> 
> regulators {
> 	compatible = "simple-bus";
> 	regulator-0 {
> 		...
> 	};
> 
> 	regulator-1 {
> 		...
> 	};
> 	...
> };
> 
> rather than:
> 
> regulators {
> 	compatible = "simple-bus";
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 
> 	regulator at 0 {
> 		reg = <...>;
> 		...
> 	};
> 
> 	regulator at 1 {
> 		reg = <...>;
> 		...
> 	};
> };
> 
> Both patterns seem to be used in existing *.dts files.

Both patterns are correct, I guess. I'm not sure if it makes sense to specify 
address of something that is not addressable and so approach 1 makes more 
sense to me.

> I'm going to use the first option in the next iteration, unless
> someone suggest otherwise.

OK.

Best regards,
Tomasz
