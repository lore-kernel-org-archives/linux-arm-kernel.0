From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 27 Mar 2017 14:27:21 +0800
Subject: [PATCH v2 1/2] dts: arm64: add LS1043A DPAA support
In-Reply-To: <HE1PR04MB11297D944241012F44C0ADF8EC3C0@HE1PR04MB1129.eurprd04.prod.outlook.com>
References: <1488382505-17554-1-git-send-email-madalin.bucur@nxp.com>
 <1488382505-17554-2-git-send-email-madalin.bucur@nxp.com>
 <20170314070732.GH3618@dragon>
 <HE1PR04MB11297D944241012F44C0ADF8EC3C0@HE1PR04MB1129.eurprd04.prod.outlook.com>
Message-ID: <20170327062719.GQ30608@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 10:58:12AM +0000, Madalin-Cristian Bucur wrote:
> > > +&soc {
> > > +
> > > +/include/ "qoriq-fman3-0.dtsi"
> > > +/include/ "qoriq-fman3-0-1g-0.dtsi"
> > > +/include/ "qoriq-fman3-0-1g-1.dtsi"
> > > +/include/ "qoriq-fman3-0-1g-2.dtsi"
> > > +/include/ "qoriq-fman3-0-1g-3.dtsi"
> > > +/include/ "qoriq-fman3-0-1g-4.dtsi"
> > > +/include/ "qoriq-fman3-0-1g-5.dtsi"
> > > +/include/ "qoriq-fman3-0-10g-0.dtsi"
> > 
> > We usually put the includes at the beginning of the file, and #include
> > is more recommended than /include/.
> 
> I'm not making use of the header file inclusion feature #include provides
> (nor plan to) in these files thus I've selected /include/ here.

Let's be simple and consistent.  Use #include please.

> > > +	fman at 1a00000 {
> > > +		enet0: ethernet at e0000 {
> > > +		};
> > > +
> > > +		enet1: ethernet at e2000 {
> > > +		};
> > > +
> > > +		enet2: ethernet at e4000 {
> > > +		};
> > > +
> > > +		enet3: ethernet at e6000 {
> > > +		};
> > > +
> > > +		enet4: ethernet at e8000 {
> > > +		};
> > > +
> > > +		enet5: ethernet at ea000 {
> > > +		};
> > > +
> > > +		enet6: ethernet at f0000 {
> > > +		};
> > > +	};
> > 
> > I do not quite understand why these nodes are empty.
> 
> These nodes provide the aliases (and custom SoC mapping) for the
> FMan ports that are used on this particular SoC. The particular
> node details are found in the port dtsi file thus no information
> is required here. Given the fact that the numbering and actual
> ports that are in use can vary between SoCs, the aliases cannot
> be included in the port dtsi nor in the FMan dtsi.

Do not completely follow.  What do you mean by 'port dtsi file'?  Maybe
I should wait for you new patches with better commit log and comments to
understand these odd empty nodes.

> 
> > > +};
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> > b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> > > index 0989d63..ee66bb2 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
> > > @@ -181,3 +181,5 @@
> > >  		reg = <0>;
> > >  	};
> > >  };
> > > +
> > > +/include/ "fsl-ls1043-post.dtsi"
> > 
> > Move it to header of the file.
> 
> This is to be included at the end, to make sure the references are
> met and to allow overrides if needed.

What is broken if you move the include to header?

> 
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> > b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> > > index c37110b..d94f003 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
> > > @@ -139,3 +139,78 @@
> > >  &duart1 {
> > >  	status = "okay";
> > >  };
> > > +
> > > +/include/ "fsl-ls1043-post.dtsi"
> > > +
> > 
> > Ditto
> > 
> > > +&soc {
> > > +	fman at 1a00000 {
> > > +		ethernet at e0000 {
> > 
> > You defined enet0 label.  Why don't you use it?
> >
> 
> The enet0 label is used by u-boot for fix-ups, providing the
> actual offset here makes it easier to follow.

You will not need to construct the node hierarchy with label.  And
alias/label name is more easier to follow than offset.

Shawn
