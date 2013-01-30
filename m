From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 30 Jan 2013 10:24:27 +0100
Subject: [BUG] i.MX25: soft lockups/freezes while getnstimeofday
In-Reply-To: <CAOMZO5DLDikzF5LMWQLw_65ADSy2-aydvhTbpFhbBV_DwS9sCQ@mail.gmail.com>
References: <20130129161230.GA3128@pengutronix.de>
 <CAOMZO5DLDikzF5LMWQLw_65ADSy2-aydvhTbpFhbBV_DwS9sCQ@mail.gmail.com>
Message-ID: <20130130092427.GA6316@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 02:38:59PM -0200, Fabio Estevam wrote:
> Hi Steffen,
> 
> On Tue, Jan 29, 2013 at 2:12 PM, Steffen Trumtrar
> <s.trumtrar@pengutronix.de> wrote:
> 
> > The board itself supposedly worked up until v3.4.
> >
> > The mxc-timer is set up to use ipg_clk_highfreq with a per5_div set to 2,
> > therefore it is clocked with 120MHz. I tried to set the per5_div to 4 to have
> > a 60MHz clock, but this didn't change anything.
> > On the other hand, I tried parenting the ipg_clk to the per5_clk to get a
> > 66MHz clock. This seems to be working fine, but I only have it running for 4h now.
> 
> Can you dump the clock tree in 3.4 and 3.7.2, so that we can compare them?
> 
> Just looked at the FSL BSP and they have the following:
> 
> 	/* GPT clock must be derived from AHB clock */
> 	clk_set_rate(&per_clk[5], ahb_clk.rate / 10);
> 

Well, v3.4 has 2012d9ca2a1381ae3e733330a7f0d1d2f1988bba

	/* Clock source for gpt is ahb_div */
	__raw_writel(__raw_readl(CRM_BASE+0x64) & ~(1 << 5), CRM_BASE + 0x64);

Seems, that it got lost somewhere. Therefore the clocktree in v3.4 and v3.7.2
is different.
I will send a patch, that will clk_set_parent per5 to ahb.

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
