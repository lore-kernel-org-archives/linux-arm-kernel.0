From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 29 Jun 2018 10:38:38 +0200
Subject: [PATCH] ARM: dts: imx6: correct anatop regulators range
In-Reply-To: <AM3PR04MB13157A4948E36BAE60A8DC49F54E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1530258861-11666-1-git-send-email-Anson.Huang@nxp.com>
 <1530260109.22468.60.camel@pengutronix.de>
 <AM3PR04MB13157A4948E36BAE60A8DC49F54E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
Message-ID: <1530261518.22468.62.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 29.06.2018, 08:27 +0000 schrieb Anson Huang:
> Hi, Lucas
> 
> Anson Huang
> Best Regards!
> 
> 
> > -----Original Message-----
> > > > From: Lucas Stach [mailto:l.stach at pengutronix.de]
> > Sent: Friday, June 29, 2018 4:15 PM
> > > > > > To: Anson Huang <anson.huang@nxp.com>; shawnguo at kernel.org;
> > > > s.hauer at pengutronix.de; kernel at pengutronix.de; Fabio Estevam
> > > > > > > > <fabio.estevam@nxp.com>; robh+dt at kernel.org; mark.rutland at arm.com;
> > > > linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
> > linux-kernel at vger.kernel.org
> > > > Cc: dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH] ARM: dts: imx6: correct anatop regulators range
> > 
> > Am Freitag, den 29.06.2018, 15:54 +0800 schrieb Anson Huang:
> > > Correct some i.MX6 SoCs anatop regulators range according to reference
> > > manual.
> > > 
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > 
> > NACK.
> > 
> > This is wrong. While the regulator supports this range, the SoC doesn't.?The
> > current settings are derived from the allowed operating ranges of the SoC (at
> > least for the MX6QDL), which is in accordance with how regulator constraints
> > in DT are meant to be used.
> 
> ?
> Understand that normally these regulators' voltage are NOT adjusted, we just use
> the default value, let's just call the operating range of the SoC "SoC range",
> my intention is to make all i.MX6's anatop regulator settings aligned since they are in same series,?
> I saw some i.MX6 SoCs use same SoC range as anatop ldo range, but some are
> NOT, like imx6qdl/imx6sx/imx6sl use different SoC range than anatop ldo range,
> but imx6ul/ull/sll use same regulator range as anatop ldo, and regulator 1p1/2p5/3p0
> also have different settings, some are use SoC range and some are just same as anatop
> ldo range....this looks really confused.
> 
> So, do you think we can adjust the imx6ul/ull/sll's regulator range to be SoC range rather than
> anatop ldo range? And how to define the SoC range? Like the 1p1 ldo range, how do
> we know which range is fine? As I saw it is 1v ~ 1.2v on imx6qdl, but 0.8v ~ 1.375v on imx6sl?

If you want to align those voltages to something then it's definitely
the SoC range you want to use. This is how the constraints are
specified in the DT binding, as being the allowed voltage range that
won't damage any of the attached consumers.

Please align the constraints to the operating ranges, as specified in
the datasheet. For example an excerpt from the i.MX6SL datasheet:

"4.3.2.1 Regulators for Analog Modules
  LDO_1P1
   [...] Typical Programming Operating Range is 1.0 V to 1.2 V with the
nominal default setting as 1.1 V"

So the range for 1p1 LDO on i.MX6SL should be 1.0V to 1.2V, which is
the same as i.MX6QDL.

Regards,
Lucas
