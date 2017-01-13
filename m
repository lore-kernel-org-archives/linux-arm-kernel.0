From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri, 13 Jan 2017 10:55:09 +0100
Subject: [PATCH] ARM64: dts: meson-gxbb-odroidc2: fix GbE tx link breakage
In-Reply-To: <m2r3476atl.fsf@baylibre.com>
References: <1482319894-656-1-git-send-email-jbrunet@baylibre.com>
 <m2r3476atl.fsf@baylibre.com>
Message-ID: <1484301309.8168.7.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-01-12 at 16:52 -0800, Kevin Hilman wrote:
> Jerome Brunet <jbrunet@baylibre.com> writes:
> 
> > 
> > OdroidC2 GbE link breaks under heavy tx transfer. This happens even
> > if the
> > MAC does not enable Energy Efficient Ethernet (No Low Power state
> > Idle on
> > the Tx path). The problem seems to come from the phy Rx path,
> > entering the
> > LPI state.
> > 
> > Disabling EEE advertisement on the phy prevent this feature to be
> > negociated with the link partner and solve the issue.
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> > 
> > This patch is based on Linus recent master branch [0]
> > This patch depends on the series [1] which has been merged in this
> > branch.
> > 
> > 0: ba6d973f78eb ("Merge
> > git://git.kernel.org/pub/scm/linux/kernel/git/davem/net")
> > 1: http://lkml.kernel.org/r/1480326409-25419-1-git-send-email-jbrun
> > et at baylibre.com
> > ???Fix integration of eee-broken-modes
> > ???
> > ?arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 12
> > ++++++++++++
> > ?1 file changed, 12 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > index 238fbeacd330..d8933e9e9a5a 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > @@ -147,6 +147,18 @@
> > ?	status = "okay";
> > ?	pinctrl-0 = <&eth_rgmii_pins>;
> > ?	pinctrl-names = "default";
> > +	phy-handle = <&eth_phy0>;
> > +
> > +	mdio {
> > +		compatible = "snps,dwmac-mdio";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		eth_phy0: ethernet-phy at 0 {
> > +			reg = <0>;
> > +			eee-broken-1000t;
> > +		};
> > +	};
> 
> There's already an MDIO node in the meson-gx.dtsi (using the same
> compatible), shouldn't you just override that and add the new
> properties?

Hum, yeah in the changes queued from 4.11, right ?
But not in the latest rc from Linus. Since this is a fix, it was
actually target for this branch.

I guess you'd prefer to avoid merge conflicts when the 4.10 is tagged.
How do you want to handle this ?

> 
> What would make things easier is if the names were like Martin used
> in
> his reset patch, so that when I merge them together it's not a major
> conflict.

Sure, no problem. I'll change it to match what has been done by Martin.

> 
> Thanks,
> 
> Kevin
> 
> [1] https://patchwork.kernel.org/patch/9459409/
