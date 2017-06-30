From: horms@verge.net.au (Simon Horman)
Date: Fri, 30 Jun 2017 13:53:45 +0200
Subject: [PATCH] arm64: dts: r8a7796: Add DRIF support
In-Reply-To: <KL1PR0601MB2038A605A7A2825225EB49DBC3D30@KL1PR0601MB2038.apcprd06.prod.outlook.com>
References: <20170627125438.44491-1-ramesh.shanmugasundaram@bp.renesas.com>
 <20170630101720.GH26710@verge.net.au>
 <KL1PR0601MB2038A605A7A2825225EB49DBC3D30@KL1PR0601MB2038.apcprd06.prod.outlook.com>
Message-ID: <20170630115345.GK26710@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 10:28:09AM +0000, Ramesh Shanmugasundaram wrote:
> Hi Simon,
> 
> > Subject: Re: [PATCH] arm64: dts: r8a7796: Add DRIF support
> > 
> > On Tue, Jun 27, 2017 at 01:54:38PM +0100, Ramesh Shanmugasundaram wrote:
> > > Adds the DRIF controller nodes for r8a7796.
> > >
> > > Signed-off-by: Ramesh Shanmugasundaram
> > > <ramesh.shanmugasundaram@bp.renesas.com>
> > > ---
> > > Hi Simon,
> > >
> > >    This patch is based on renesas-devel-20170626-v4.12-rc7 tag.
> > >    It is verified on M3 ES1.0. I also verified there are no regression
> > issues
> > >    with this addition.
> > >
> > >    The driver[1] is pushed into the media_tree. The bindings[2] are
> > ACK'ed
> > >    by Geert & Rob and in the media_tree queue.
> > >
> > >    [1]
> > https://git.linuxtv.org/media_tree.git/commit/?id=7625ee981af166ddb569e2e6
> > c0006e2af471326f
> > >    [2]
> > > https://www.mail-archive.com/linux-renesas-soc at vger.kernel.org/msg1560
> > > 2.html
> > >
> > > Thanks,
> > > Ramesh.
> > >
> > >  arch/arm64/boot/dts/renesas/r8a7796.dtsi | 120
> > > +++++++++++++++++++++++++++++++
> > >  1 file changed, 120 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> > > b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> > > index 1f6710912045..df04d132a127 100644
> > > --- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> > > +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> > > @@ -639,6 +639,126 @@
> > >  			};
> > >  		};
> > >
> > > +		drif00: rif at e6f40000 {
> > > +			compatible = "renesas,r8a7796-drif",
> > > +				     "renesas,rcar-gen3-drif";
> > > +			reg = <0 0xe6f40000 0 0x64>;
> > > +			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> > > +			clocks = <&cpg CPG_MOD 515>;
> > > +			clock-names = "fck";
> > > +			dmas = <&dmac1 0x20>, <&dmac2 0x20>;
> > 
> > The dmas property seems a little strange. I would have expected to allow
> > ether dmac1 or dmac2 to be used for both tx and rx:
> > 
> > 			dmas = <&dmac1 0x20>, <&dmac1 0x20>,
> > 			       <&dmac2 0x20>, <&dmac2 0x20>;
> > 
> 
> It is an rx-only interface that can use either dmac1 or 2.

Thanks, I see that clearly now.
I have applied this for v4.14.

> 
> > 
> > > +			dma-names = "rx", "rx";
> > > +			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
> > > +			resets = <&cpg 515>;
> > > +			renesas,bonding = <&drif01>;
> > > +			status = "disabled";
> > > +		};
> > 
> 
> Thanks,
> Ramesh
> 
