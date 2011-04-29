From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Apr 2011 23:07:46 +0100
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <alpine.LFD.2.02.1104291620170.3005@ionos>
References: <20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421072259.GG31131@pengutronix.de>
	<alpine.LFD.2.02.1104211045220.3323@ionos>
	<20110429103723.GF5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291252080.3005@ionos>
	<20110429110610.GJ5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291344020.3005@ionos>
	<20110429132613.GL5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291620170.3005@ionos>
Message-ID: <20110429220746.GB14871@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 05:31:44PM +0200, Thomas Gleixner wrote:
> Lets look at a simple example (locking omitted)
> 
> clk_enable(clk) {
> 	if (clk->enable_count == 0) {
>   	   res = clk->ops->enable(clk);
> 	   if (res)
> 	      return res;
>         }
> 	enable_count++;
> 	return 0;
> };   
> 
> So in each enable op you have:
> 
> *_enable(clk)
> {
> 	res = clk_enable(clk_get_parent(clk));
> 	if (res)
> 		return res;
> 
> 	res = hw_magic_enable(clk);
> 	if (res)
> 		clk_disable(clk_get_parent(clk));
> 	return res;
> }
> 
> Instead of having at the core level:
> 
> clk_enable(clk)
> {
> 	if (clk->enable_count == 0) {
> 		res = clk_enable(clk_get_parent(clk));
> 		if (res)
> 			return res;
> 
> 		res = clk->ops->enable(clk);
> 		if (res) {
> 			clk_disable(clk_get_parent(clk));
> 			return res;
> 		}
> 	}
> 	clk->enable_count++;
> 	return 0;
> }

I'm going to give up discussing this with you - you have no desire to
even understand what I'm saying.  I don't see any point continuing this
discussion any further.
