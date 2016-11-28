From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 28 Nov 2016 13:40:33 +0100
Subject: [PATCH net-next v3 4/4] ARM64: dts: meson: odroidc2: disable
 advertisement EEE for GbE.
In-Reply-To: <9709dd57-e536-9281-6b56-5ff5f9e8035c@suse.de>
References: <1480326409-25419-1-git-send-email-jbrunet@baylibre.com>
 <1480326409-25419-5-git-send-email-jbrunet@baylibre.com>
 <9709dd57-e536-9281-6b56-5ff5f9e8035c@suse.de>
Message-ID: <1480336833.17538.164.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-11-28 at 13:31 +0100, Andreas F?rber wrote:
> Am 28.11.2016 um 10:46 schrieb Jerome Brunet:
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> > ?arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 16
> > ++++++++++++++++
> > ?1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > index e6e3491d48a5..5624714d2b16 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> > @@ -46,6 +46,7 @@
> > ?
> > ?#include "meson-gxbb.dtsi"
> > ?#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/net/mdio.h>
> > ?
> > ?/ {
> > ?	compatible = "hardkernel,odroid-c2", "amlogic,meson-gxbb";
> > @@ -98,3 +99,18 @@
> > ?	pinctrl-0 = <&i2c_a_pins>;
> > ?	pinctrl-names = "default";
> > ?};
> > +
> > +&ethmac {
> > +	phy-handle = <&eth_phy0>;
> > +
> > +	mdio {
> > +		compatible = "snps,dwmac-mdio";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		eth_phy0: ethernet-phy at 0 {
> > +			reg = <0>;
> > +			eee-broken-modes = <MDIO_EEE_1000T>;
> > +		};
> > +	};
> > +};
> 
6I've tested this hand-applied because it applies to neither amlogic
> v4.10/integ nor linux-next.git and will conflict if applied through
> the
> net-next tree.

I've rebased on net-next this morning. I just checked again and now
there is a conflict indeed. Something got applied between in the last 6
ours which conflict with patch 4.

> 
> Note that there already is an &ethmac node that you should be
> extending
> rather than duplicating:
> 
> &ethmac {
> 	status = "okay";
> 	pinctrl-0 = <&eth_rgmii_pins>;
> 	pinctrl-names = "default";
> };
> 
> If you or your colleagues could please fix the sort order of the
> nodes
> to be alphabetical again (ethmac after i2c_A here; between uart_A and
> ir
> in-tree) this wouldn't happen so easily again.

OK

> 
> I therefore suggest to not apply this patch 4/4 through net-next but
> through the amlogic tree instead.

Agreed. The change is provided here so people can test.
If the other patches get accepted, I'll submit the dts change through
the amlogic tree.

> 
> Thanks,
> Andreas
> 
