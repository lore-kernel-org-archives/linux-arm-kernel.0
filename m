From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 27 Jun 2012 13:59:21 -0600 (MDT)
Subject: [PATCH 00/11] Prepare for OMAP2+ movement to Common Clk
In-Reply-To: <2606265.VPQJMxIymh@avalon>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1206271033500.27496@utopia.booyaka.com>
 <1854687.1eeiLuW4oH@avalon> <2606265.VPQJMxIymh@avalon>
Message-ID: <alpine.DEB.2.00.1206271344200.27496@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Kevin

On Wed, 27 Jun 2012, Laurent Pinchart wrote:

> OK, I think I've found the information. I'll give this a try.

That sounds great.

> What is still not clear to me is how runtime PM and system PM interact. For 
> instance the OMAP3 ISP driver disables its clocks in the system PM suspend 
> handler, and restarts them in the system PM resume handler. How do I port that 
> to runtime PM, can I just call pm_runtime_put() and pm_runtime_get_sync() in 
> the system PM handlers ?

I've lost track of what the official guidance on this is.  But we have 
plenty of drivers that do this.  A few examples are 
drivers/mmc/host/omap_hsmmc.c, drivers/spi/spi-omap2-mcspi.c, and the DSS 
drivers.

IMHO, if possible, for the driver's system suspend call, the best thing to 
do is to check to see if the driver is currently doing something.  If it 
is, then ask it to stop.  Then wait until it does.  When it stops, that 
other part of the driver is ideally what should do the pm_runtime_put*().  

It's been a long time since I've looked, but I'd be surprised if we had 
many drivers that operated like that...

- Paul
