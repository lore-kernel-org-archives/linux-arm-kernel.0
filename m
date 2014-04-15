From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 15 Apr 2014 18:00:58 +0800
Subject: [PATCH 2/2] ARM: dts: berlin: add GPIO nodes for the BG2Q
In-Reply-To: <534CFA77.9030108@gmail.com>
References: <1397549245-3338-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397549245-3338-3-git-send-email-antoine.tenart@free-electrons.com>
 <534CFA77.9030108@gmail.com>
Message-ID: <20140415180058.2fefca78@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Tue, 15 Apr 2014 02:23:03 -0700
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> On 04/15/2014 10:07 AM, Antoine T?nart wrote:
> > The Marvell Berlin BG2Q has 6 GPIO ports compatible with the
> > snps,dw-apb-gpio driver. This patch add the corresponding device tree
> > nodes.
> >
> > Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> > ---
> >   arch/arm/boot/dts/berlin2q.dtsi | 102
> > ++++++++++++++++++++++++++++++++++++++++ 1 file changed, 102 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/berlin2q.dtsi
> > b/arch/arm/boot/dts/berlin2q.dtsi index e6e556055dfc..b2625f896bc5 100644
> > --- a/arch/arm/boot/dts/berlin2q.dtsi
> > +++ b/arch/arm/boot/dts/berlin2q.dtsi
> > @@ -109,6 +109,78 @@
> >   			ranges = <0 0xe80000 0x10000>;
> >   			interrupt-parent = <&aic>;
> >
> > +			gpio0: gpio at 0400 {
> > +				compatible = "snps,dw-apb-gpio";
> > +				reg = <0x0400 0x400>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				porta: gpio-controller at 0 {
> 
> ePAPR recommended name is even more generic, i.e. "gpio". If
> that clashed in any way with other numbered names, I suggest
> to rename to "gpio-port" as actually the controller is the
> parent node and this represents one port (in the nomenclature
> of DW-APB-GPIO).
> 
> > +					compatible =
> > "snps,dw-apb-gpio-port";
> > +					gpio-controller;
> > +					#gpio-cells = <2>;
> > +					snps,nr-gpios = <32>;
> 
> 32 gpio pins for each of the 6 GPIO controllers? Either BG2Q is a GPIO

Yes, BG2Q support 32 pins every port

> beast or it is a mistake :P
> 
> Can you please double-check?
> 
> I am fine with using nr-gpios property now, but I guess BG2Q also
> has that CONFIG[1,2] registers to actually read out the features
> synthesized in? If I find some time, I'll prepare a patch for
> dw-apb-gpio to exploit that (optional) information instead of
> using nr-gpios.

The problem is CONFIG1/2 registers don't exist on some versions.
For example, the version used in BG2/BG2CD. So nr-gpio is necessary
if we want to support these versions.

Thanks,
Jisheng
