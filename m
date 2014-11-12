From: jbe@pengutronix.de (Juergen Borleis)
Date: Wed, 12 Nov 2014 13:00:27 +0100
Subject: Samsung/S3C6410/Mini6410: how to handle NAND's "clock off"
In-Reply-To: <20141112091458.GM27002@pengutronix.de>
References: <201411111910.34231.juergen@kreuzholzen.de>
 <20141111184226.GH27002@pengutronix.de>
 <20141112091458.GM27002@pengutronix.de>
Message-ID: <201411121300.30286.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wednesday 12 November 2014 10:14:58 Uwe Kleine-K?nig wrote:
> Hello again,
>
> [extending audience a bit]
>
> On Tue, Nov 11, 2014 at 07:42:26PM +0100, Uwe Kleine-K?nig wrote:
> > On Tue, Nov 11, 2014 at 07:10:33PM +0100, Juergen Borleis wrote:
> > > Hi,
> > >
> > > the S3C2410 NAND driver [1] can still be used for NANDs attached to an
> > > S3C6410 SoC. But this driver has a "nice" feature called "clock off" to
> > > save some power while not in use. I tried it here on my Mini6410
> > > platform and it freezes the system.
> > >
> > > The clock tree is somehow:
> > >
> > > [...]
> > >   hclk                      4            4   133000000          0 0
> > >      hclk_mfc               0            0   133000000          0 0
> > >      hclk_mem0              2            2   133000000          0 0
> > >         mem0_srom           0            0   133000000          0 0
> > >         mem0_nfcon          1            1   133000000          0 0
> > >         mem0_onenand0       0            0   133000000          0 0
> > >         mem0_onenand1       0            0   133000000          0 0
> > >         mem0_cfcon          0            0   133000000          0 0
> > > [...]
> > >
> > > On the Mini6410 the "mem0_nfcon" clock is the only single user of the
> > > "hclk_mem0". And this clock is required to keep the access to the
> > > external network device enabled. When the NAND driver disables its
> > > clock "mem0_nfcon", the "hclk_mem0" gets also disabled because there is
> > > no consumer anymore. The next time the network driver tries to access
> > > its device, the SoC freezes.
> >
> > Sounds like the network driver should hold a reference to hclk_mem0.
>
> After talking to J?rgen by phone, the solution that the dm9000 driver
> should handle the clock sounds wrong. The clk in question is needed by
> the SoC to operate the bus the dm9000 is connected to. So I think the
> right approach would include

I think we need the same here for the S3C6410 SoC, like the imx-weim driver is 
for i.MX SoCs.

jbe

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Borleis ? ? ? ? ? ? |
Industrial Linux Solutions               ? ? ?| Phone: +49-5121-206917-5128 |
Peiner Str. 6-8, 31137 Hildesheim, Germany ? ?| Fax: ? +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? ? ?| http://www.pengutronix.de/ ?|
