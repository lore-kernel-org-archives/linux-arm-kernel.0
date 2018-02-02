From: ping.bai@nxp.com (Jacky Bai)
Date: Fri, 2 Feb 2018 05:30:56 +0000
Subject: [PATCH] ARM: imx: Improve the soc revision calculation flow
In-Reply-To: <20180202052734.GH20833@dragon>
References: <1515486632-18488-1-git-send-email-ping.bai@nxp.com>
 <AM3PR04MB306176538988C3363E4EE5380E00@AM3PR04MB306.eurprd04.prod.outlook.com>
 <20180202052734.GH20833@dragon>
Message-ID: <HE1PR04MB3113A3884BB28C84D282A4DB87F90@HE1PR04MB3113.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks shawn and Aisheng for review. Will fix in V2.

BR
Jacky Bai
> Subject: Re: [PATCH] ARM: imx: Improve the soc revision calculation flow
> 
> On Fri, Jan 26, 2018 at 07:59:46AM +0000, A.s. Dong wrote:
> > > @@ -127,45 +130,26 @@ void __init imx_init_revision_from_anatop(void)
> > >  	digprog = readl_relaxed(anatop_base + offset);
> > >  	iounmap(anatop_base);
> > >
> > > -	switch (digprog & 0xff) {
> > > -	case 0:
> > > -		/*
> > > -		 * For i.MX6QP, most of the code for i.MX6Q can be resued,
> > > -		 * so internally, we identify it as i.MX6Q Rev 2.0
> > > -		 */
> > > -		if (digprog >> 8 & 0x01)
> > > -			revision = IMX_CHIP_REVISION_2_0;
> > > -		else
> > > -			revision = IMX_CHIP_REVISION_1_0;
> > > -		break;
> > > -	case 1:
> > > -		revision = IMX_CHIP_REVISION_1_1;
> > > -		break;
> > > -	case 2:
> > > -		revision = IMX_CHIP_REVISION_1_2;
> > > -		break;
> > > -	case 3:
> > > -		revision = IMX_CHIP_REVISION_1_3;
> > > -		break;
> > > -	case 4:
> > > -		revision = IMX_CHIP_REVISION_1_4;
> > > -		break;
> > > -	case 5:
> > > -		/*
> > > -		 * i.MX6DQ TO1.5 is defined as Rev 1.3 in Data Sheet, marked
> > > -		 * as 'D' in Part Number last character.
> > > -		 */
> > > -		revision = IMX_CHIP_REVISION_1_5;
> > > -		break;
> > > -	default:
> > > -		/*
> > > -		 * Fail back to return raw register value instead of 0xff.
> > > -		 * It will be easy to know version information in SOC if it
> > > -		 * can't be recognized by known version. And some chip's
> > > (i.MX7D)
> > > -		 * digprog value match linux version format, so it needn't map
> > > -		 * again and we can use register value directly.
> > > +	/*
> > > +	 * On i.MX7D digprog value match linux version format, so
> > > +	 * it needn't map again and we can use register value directly.
> > > +	 */
> > > +	if (of_device_is_compatible(np, "fsl,imx7d-anatop")) {
> > > +		revision = digprog & 0xff;
> > > +	} else {
> > > +
> > > +		/* MAJOR: [15:8], the major silicon revison;
> > > +		 * MINOR: [7: 0], the minor silicon revison;
> > > +		 *
> > > +		 * please refer to the i.MX RM for the detailed
> > > +		 * silicon revison bit define.
> > > +		 * format the major part and minor part to match the
> > > +		 * linux kernel soc version format.
> > >  		 */
> > >  		revision = digprog & 0xff;
> >
> > Unneeded line?
> 
> +1
> 
> Shawn
