From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 08 Oct 2018 00:40:51 -0700
Subject: [PATCH 2/2] clk: imx: imx7d: remove clks_init_on array
In-Reply-To: <AM6PR0402MB391120110A289BA5FB6B9F0DF50C0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1533703167-26583-1-git-send-email-Anson.Huang@nxp.com>
 <1533703167-26583-2-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4481FC2BAD71B75D7BE84C0788260@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916F8BC381BBA01DB21D1C0F5260@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM0PR04MB44813C7A3E0AF4F3BCFFCF0088390@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <153567894721.93865.4092113232222931488@swboyd.mtv.corp.google.com>
 <a6489bda-703f-207c-0b24-60f4044fe89f@linaro.org>
 <153573827629.93865.6200966443862432044@swboyd.mtv.corp.google.com>
 <AM6PR0402MB391120110A289BA5FB6B9F0DF50C0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
Message-ID: <153898445180.119890.15025812558797341532@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Anson Huang (2018-09-03 00:20:53)
> > > On 08/31/2018 03:29 AM, Stephen Boyd wrote:
> > > > Quoting Peng Fan (2018-08-12 18:15:41)
> > > >> Hi Anson,
> > > >>
> > > >>>>> -----Original Message-----
> > > >>>>> From: Anson Huang
> > > >>>>> Sent: 2018?8?8? 12:39
> > > >>>>> To: shawnguo at kernel.org; s.hauer at pengutronix.de;
> > > >>>>> kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> > > >>>>> mturquette at baylibre.com; sboyd at kernel.org;
> > > >>>>> linux-arm-kernel at lists.infradead.org;
> > > >>>>> linux-clk at vger.kernel.org; linux-kernel at vger.kernel.org
> > > >>>>> Cc: dl-linux-imx <linux-imx@nxp.com>
> > > >>>>> Subject: [PATCH 2/2] clk: imx: imx7d: remove clks_init_on array
> > > >>>>>
> > > >>>>> Clock framework will enable those clocks registered with
> > > >>>>> CLK_IS_CRITICAL flag, so no need to have clks_init_on array
> > > >>>>> during clock
> > > >>>> initialization now.
> > > >>>>
> > > >>>> Will it be more flexible to parse dts saying "critical-clocks = <xxx>"
> > > >>>> or "init-on-arrary=<xxx>"
> > > >>>> and enable those clocks?
> > > >>>
> > > >>> Parsing the clocks arrays from dtb is another way of enabling
> > > >>> critical clocks, but for current i.MX6/7 platforms, we implement
> > > >>> it in same way as most of other SoCs, currently I did NOT see any
> > > >>> necessity of putting them in dtb, just adding flag during clock
> > > >>> registering is more simple, if there is any special requirement
> > > >>> for different clocks set to be enabled, then we can add support to enable
> > the method of parsing critical-clocks from dtb. Just my two cents.
> > > >>
> > > >> Thinking about OP-TEE want to use one device, but it's clocks are
> > > >> registered by Linux, because there is no module in Linux side use
> > > >> it, it will shutdown the clock, which cause OP-TEE could not access the
> > device.
> > > >>
> > > >> Then people have to modify clk code to add CLK_IS_CRITICAL flag to
> > > >> make sure the clocks are not shutdown by Linux.
> > > >>
> > > >> However adding a new property in clk node and let driver code parse
> > > >> the dts, there is no need to modify clk driver code when OP-TEE needs
> > another device clock.
> > > >>
> > > >
> > > > If OP-TEE needs linux to keep things on then why can't the OP-TEE
> > > > driver in Linux probe, acquire clocks, and keep the clks enabled forever?
> > >
> > > Sounds reasonable, but how could this be done without introducing
> > > platform-specific stuff in the OP-TEE driver?
> > >
> > 
> > Why is that a goal?
>  
> I do NOT think we should consider such case in this patch series, whatever OP-TEE needs for its own
> feature, it should do necessary operations either in its driver or somewhere else by adding new patch.
> 

Why can't we add clks to the op-tee node in DT's /firmware container?
Then any clks in there can be turned on forever and left enabled by the
linux driver?
