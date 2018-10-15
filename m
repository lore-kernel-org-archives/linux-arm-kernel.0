From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 15 Oct 2018 09:45:57 -0700
Subject: [PATCH 2/2] clk: imx: imx7d: remove clks_init_on array
In-Reply-To: <DB3PR0402MB39169A3BA844F7833B62FF55F5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1533703167-26583-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB44813C7A3E0AF4F3BCFFCF0088390@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <153567894721.93865.4092113232222931488@swboyd.mtv.corp.google.com>
 <a6489bda-703f-207c-0b24-60f4044fe89f@linaro.org>
 <153573827629.93865.6200966443862432044@swboyd.mtv.corp.google.com>
 <AM6PR0402MB391120110A289BA5FB6B9F0DF50C0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
 <153898445180.119890.15025812558797341532@swboyd.mtv.corp.google.com>
 <DB3PR0402MB391664354775DF42E90E67C9F5E60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <153937368201.5275.2313781259297807972@swboyd.mtv.corp.google.com>
 <DB3PR0402MB39169A3BA844F7833B62FF55F5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Message-ID: <153962195779.5275.17500455384946496344@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Anson Huang (2018-10-15 02:33:35)
> > > > >
> > > >
> > > > Why can't we add clks to the op-tee node in DT's /firmware container?
> > > > Then any clks in there can be turned on forever and left enabled by
> > > > the linux driver?
> > >
> > > I did NOT run op-tee with Linux-next kernel before, can you advise more?
> > 
> > Neither have I, so I can't advise more.
> > 
> > > And I think if op-tee has such requirement, can we have another patch
> > > to cover it?
> > 
> > Yes.
> > 
> > 
> > > I believe all other i.MX platforms also have same requirements if
> > > considering op-tee support, so I think it should be another topic, what do you
> > think?
> > >
> > 
> > I'm going to drop these patches from my review queue. Please resend them
> > and please include the op-tee patches too.
> 
> 
> I do NOT know how to include the op-tee patch to meet special requirement, should
> the op-tee related patch be added later when someone actually add the op-tee support for i.MX7?
> It should NOT block this patch set, do you think we can add this patch set first?
> 

Please resend the two patches. In the commit text for the second patch,
describe the plan to remove CLK_IS_CRITICAL from these clks by adding an
OP-TEE device/driver to the kernel to keep these clks enabled. My
understanding is that there isn't an OP-TEE driver right now, but these
clks are used by the firmware and can't be turned off in Linux. If in
the future we want to be able to turn them on and off, we'll need to add
them to an OP-TEE device node and have that driver manage the clks.

How that will work when a system doesn't enable the OP-TEE driver I'm
not sure. We may need to develop some system whereby clks like this are
handed from the clk controller to the consumer driver when it's enabled
for further power managment, but if they're never handed off, they're
kept on forever like is done here. Anyway, please resend with a note
about why these are marked CLK_IS_CRITICAL.
