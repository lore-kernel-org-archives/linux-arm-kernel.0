From: yangbo.lu@nxp.com (Y.b. Lu)
Date: Wed, 1 Aug 2018 04:36:40 +0000
Subject: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
 initialization
In-Reply-To: <20180730143043.qu66ttzwyjbw6si7@localhost>
References: <20180730100154.27906-1-yangbo.lu@nxp.com>
 <20180730100154.27906-3-yangbo.lu@nxp.com>
 <20180730143043.qu66ttzwyjbw6si7@localhost>
Message-ID: <DB6PR0401MB253643010802739AD55820F3F82D0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

> -----Original Message-----
> From: Richard Cochran [mailto:richardcochran at gmail.com]
> Sent: Monday, July 30, 2018 10:31 PM
> To: Y.b. Lu <yangbo.lu@nxp.com>
> Cc: netdev at vger.kernel.org; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>; Rob Herring <robh+dt@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; David S . Miller <davem@davemloft.net>;
> devicetree at vger.kernel.org; linuxppc-dev at lists.ozlabs.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
> initialization
> 
> On Mon, Jul 30, 2018 at 06:01:54PM +0800, Yangbo Lu wrote:
> > The ptp_qoriq driver initialized the 1588 timer with the
> > configurations provided by the properties of device tree node. For
> > example,
> >
> >   fsl,tclk-period = <5>;
> >   fsl,tmr-prsc    = <2>;
> >   fsl,tmr-add     = <0xaaaaaaab>;
> >   fsl,tmr-fiper1  = <999999995>;
> >   fsl,tmr-fiper2  = <99990>;
> >   fsl,max-adj     = <499999999>;
> >
> > These things actually were runtime configurations which were not
> > proper to be put into dts.
> 
> That is debatable.  While I agree that the dts isn't ideal for these, still it is the
> lesser of two or more evils.

[Y.b. Lu] Ok. You're right indeed :)

> 
> > This patch is to convert
> > to use module parameters for 1588 timer initialization, and to support
> > initial register values calculation.
> 
> It is hard for me to understand how using module parameters improves the
> situation.

[Y.b. Lu] Actually I'm not sure whether module_param will be accepted to replace dts.
I thought the most possibility would be rejection before sending them out.
Just want suggestion and confirmation whether there is better idea than dts from your comments.

Since we should keep the dts, I will drop the module_param.
Could I add a function to calculate a set of default register values to initialize ptp timer when dts method failed to get required properties in driver?
I think this will be useful. The ptp timer on new platforms (you may see two dts patches in this patchset. Many platforms will be affected.) will work without these dts properties. If user want specific setting, they can set dts properties.


> 
> > If the parameters are not provided, the driver will calculate register
> > values with a set of default parameters. With this patch, those dts
> > properties are no longer needed for new platform to support 1588
> > timer, and many QorIQ DPAA platforms (some P series and T series
> > platforms of PowerPC, and some LS series platforms of ARM64) could use
> > this driver for their fman ptp timer with default module parameters.
> > However, this patch didn't remove the dts method. Because there were
> > still many old platforms using the dts method. We need to clean up
> > their dts files, verify module parameters on them, and convert them to
> > the new method gradually in case of breaking any function.
> 
> In addition, like it or not, because the dts is an ABI, you must continue support
> of the dts values as a legacy option.

[Y.b. Lu] I get your point now. The dts should be kept :)

> 
> Thanks,
> Richard
