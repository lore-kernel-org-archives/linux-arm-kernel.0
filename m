From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Mon, 2 Oct 2017 09:16:56 +0000
Subject: [PATCH 20/22] arm64: dts: renesas: r8a77995: draak: enable
 EthernetAVB
In-Reply-To: <20171002071433.GA10579@verge.net.au>
References: <cover.1506678250.git.horms+renesas@verge.net.au>
 <4503b50eac08f472e8690ec61f4d144e62cbdc55.1506678250.git.horms+renesas@verge.net.au>
 <29d4573f-4127-225c-1abc-7f341734d7d7@cogentembedded.com>
 <TY1PR06MB09924F9B2BE2CA1C5F1CF318D87D0@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <20171002071433.GA10579@verge.net.au>
Message-ID: <TY1PR06MB099289399914401B22232C67D87D0@TY1PR06MB0992.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon-san,

> -----Original Message-----
> From: Simon Horman
> Sent: Monday, October 2, 2017 4:15 PM
> 
> On Mon, Oct 02, 2017 at 01:18:49AM +0000, Yoshihiro Shimoda wrote:
> > Hello,
> >
> > > -----Original Message-----
> > > From: Sergei Shtylyov
> > > Sent: Saturday, September 30, 2017 7:24 PM
> > >
> > > Hello!
> > >
> > > On 9/29/2017 2:52 PM, Simon Horman wrote:
> > >
> > > > From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > >
> > > > This patch enables EthernetAVB for R-Car D3 draak board.
> > > >
> > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > > ---
> > > >   arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 25 +++++++++++++++++++++++++
> > > >   1 file changed, 25 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > > > index 7b776cb7e928..96b7ff5cc321 100644
> > > > --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > > > +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > > [...]
> > > > @@ -37,6 +39,14 @@
> > > >   };
> > > >
> > > >   &pfc {
> > > > +	avb0_pins: avb {
> > > > +		mux {
> > > > +			groups = "avb0_link", "avb0_phy_int", "avb0_mdc",
> > >                                                ^^^^^^^^^^^^^^
> > >     Hum, I don't think it's compatible with routing the PHY interrupt via
> > > GPIO5_19 below. The driver doesn't support signalling via AVB_PHY_INT anyway.
> >
> > Oops! You're correct. I should drop "avb0_phy_int".
> >
> > Simon-san, may I send a follow-up patch to fix this?
> 
> Thanks Sergei, thanks Shimoda-san,
> 
> yes, please provide a follow-up patch.
> 
> At this stage I don't think we need to re-spin this pull-request
> to fix this, rather a follow-up patch can be included
> in a follow-up pull request.

I got it. I will send it. Also, should I send salvator-common and ulcb patches
about Geert-san's comment (These dtsi files also enable "avb_phy_int" for now)?

Best regards,
Yoshihiro Shimoda

> >
> > Best regards,
> > Yoshihiro Shimoda
> >
> > > > +				 "avb0_mii";
> > > > +			function = "avb0";
> > > > +		};
> > > > +	};
> > > > +
> > > >   	scif2_pins: scif2 {
> > > >   		groups = "scif2_data";
> > > >   		function = "scif2";
> > > > @@ -56,6 +66,21 @@
> > > >   	status = "okay";
> > > >   };
> > > >
> > > > +&avb {
> > > > +	pinctrl-0 = <&avb0_pins>;
> > > > +	pinctrl-names = "default";
> > > > +	renesas,no-ether-link;
> > > > +	phy-handle = <&phy0>;
> > > > +	status = "okay";
> > > > +
> > > > +	phy0: ethernet-phy at 0 {
> > > > +		rxc-skew-ps = <1500>;
> > > > +		reg = <0>;
> > > > +		interrupt-parent = <&gpio5>;
> > > > +		interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
> > > > +	};
> > > > +};
> > > > +
> > > >   &scif2 {
> > > >   	pinctrl-0 = <&scif2_pins>;
> > > >   	pinctrl-names = "default";
> > >
> > > MBR, Sergei
