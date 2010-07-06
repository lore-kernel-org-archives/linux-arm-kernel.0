From: r.herring@freescale.com (Rob Herring)
Date: Tue, 06 Jul 2010 09:06:55 -0500
Subject: [PATCH] mx25: set GPT clock source to PER
In-Reply-To: <20100706073314.GJ26079@pengutronix.de>
References: <20100704084343.GB19559@jasper.tkos.co.il>
	<40bc9462f125233cc9c63631a9b987ed684b6d97.1278233166.git.baruch@tkos.co.il>
	<20100705082123.GD26079@pengutronix.de>
	<20100706063511.GB28547@jasper.tkos.co.il>
	<20100706073314.GJ26079@pengutronix.de>
Message-ID: <1278425215.4396.45.camel@ra7055-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-07-06 at 09:33 +0200, Sascha Hauer wrote:
> On Tue, Jul 06, 2010 at 09:35:11AM +0300, Baruch Siach wrote:
> > > In any case, we can't apply your patch because it would break other v2
> > > based architectures like i.MX35.
> > 
> > What do you suggest then?
> 
> Tell the timer code which clock to use with an argument to
> mxc_timer_init() and add the missing clocks to the clock.c file. You
> also have to pass this argument through from the board to
> mx25_clocks_init(). That's a lot of work and in the end we still do not
> know why some i.MX25 variants need the peripheral clock and others need
> the ipg clock. So what I really suggest is that you invest some
> research to find the source of this strangeness. Some things that could
> help you are:
> 
> - the clko pin
> - Do both boards have identical i.MX25 tapeout versions?
> - Are the clocks initialized identically?
> 
> I bricked my i.MX25 PDK so unfortunately I do not have any hardware to
> do some tests myself.

There are no Si issues with MX25 that would cause per_clk to not work. 

There are 2 possible clocking configurations and it is not tied to v1
vs. v2 timer hardware:
ipg_clk and per_clk are same clock source - MX1, MX21, MX31
per_clk is independent clock - every other i.MX chip

The correct setup is to use per_clk as ipg_clk can change frequencies
for bus scaling in the latter case. 

Rob
