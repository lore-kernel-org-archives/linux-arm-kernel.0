From: anson.huang@nxp.com (Yongcai Huang)
Date: Mon, 29 Aug 2016 14:54:44 +0000
Subject: [PATCH] ARM: imx6: add opp table when cpufreq is enabled
In-Reply-To: <20160829144700.GX30790@tiger>
References: <1471964171-27480-1-git-send-email-Anson.Huang@nxp.com>
 <20160829061910.GG30790@tiger> <20160829062720.GI30790@tiger>
 <AM3PR04MB13156D30B684387793054569F5E10@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <20160829144700.GX30790@tiger>
Message-ID: <AM3PR04MB1315D051AABB3F9D472CCB11F5E10@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Best Regards!
Anson Huang



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: 2016-08-29 10:47 PM
> To: Yongcai Huang <anson.huang@nxp.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>; Peter Chen
> <peter.chen@nxp.com>; linux at armlinux.org.uk; linux-arm-
> kernel at lists.infradead.org; kernel at pengutronix.de
> Subject: Re: [PATCH] ARM: imx6: add opp table when cpufreq is enabled
> 
> On Mon, Aug 29, 2016 at 08:49:04AM +0000, Yongcai Huang wrote:
> >
> > > -----Original Message-----
> > > From: Shawn Guo [mailto:shawnguo at kernel.org]
> > > Sent: 2016-08-29 2:27 PM
> > > To: Yongcai Huang <anson.huang@nxp.com>
> > > Cc: Fabio Estevam <fabio.estevam@nxp.com>; Peter Chen
> > > <peter.chen@nxp.com>; linux at armlinux.org.uk; linux-arm-
> > > kernel at lists.infradead.org; kernel at pengutronix.de
> > > Subject: Re: [PATCH] ARM: imx6: add opp table when cpufreq is
> > > enabled
> > >
> > > On Mon, Aug 29, 2016 at 02:19:10PM +0800, Shawn Guo wrote:
> > > > On Tue, Aug 23, 2016 at 10:56:11PM +0800, Anson Huang wrote:
> > > > > On those i.MX6 platforms which have no speed grading check, opp
> > > > > table will NOT be created in platform code, so cpufreq driver
> > > > > will have below error message:
> > > > >
> > > > > cpu cpu0: dev_pm_opp_get_opp_count: OPP table not found (-19)
> > > >
> > > > The cpufreq driver calls dev_pm_opp_get_opp_count() to test if
> > > > platform supplies an OPP table.  If not, the driver will call into
> > > > dev_pm_opp_of_add_table() on its own.  So this is not an error
> > > > message, and cpufreq driver should just work fine on i.MX6SX and
> i.MX6SL.
> > >
> > > If you think the message might confuse people, we can add an info
> > > message in cpufreq driver in case it adds OPP table by its own, which can
> explain the 'error'
> > > message a bit from dev_pm_opp_get_opp_count().
> > >
> > > Shawn
> >
> > After rethink this, if we can avoid this "error" message printed out
> > from common OPP framework, why NOT do it? Although the code change is
> > kind of big, but the logic is quite simple. Adding info message in
> > cpufreq driver is a bit better, but the "error" message is still there
> > which may concern some people who really care about it, adding this patch
> would make it easier for our future kernel upgrade.
> >
> > Actually, if we do NOT have speed grading fuse check need for some
> > platforms, the opp table init can be put in cpufreq for all platforms,
> > so I think the best way is to put all opp table init in either
> > platform code or cpufreq driver, some platforms put it in platform code and
> some in cpufreq driver is NOT the best.
> 
> It will be the best if we can have cpufreq driver handle OPP table for all i.MX6
> cases.
> 
> My problem with the platform approach is that every time we have a new
> platform support, we need to patch platform code to add OPP table.
> That's not good.
> 
> Shawn

Understood, then I think I can move the speed grading fuse check into cpufreq driver, then 
put the opp table init in cpufreq too, that will make the platform code much
more easy for adding new platform support. Will send out a new patch set
later for this change.

Regards!
Anson.
