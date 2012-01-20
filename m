From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 Jan 2012 11:56:04 +0800
Subject: [PATCH] ARM: mx28: Clear CLKGATE bit prior to changing DIV field
In-Reply-To: <20120119145313.GZ1068@n2100.arm.linux.org.uk>
References: <1326820526-26498-1-git-send-email-fabio.estevam@freescale.com>
 <20246.30805.391940.766120@ipc1.ka-ro>
 <CAOMZO5B3qRowaQ9c_=pyykvp5x5f2nTgticV0tCcHGAYD007MQ@mail.gmail.com>
 <20120119031726.GA2247@S2101-09.ap.freescale.net>
 <20120119145313.GZ1068@n2100.arm.linux.org.uk>
Message-ID: <20120120035600.GA26277@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 02:53:13PM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 19, 2012 at 11:17:34AM +0800, Shawn Guo wrote:
> > >From power saving point of view, I'm not sure you want to keep saif
> > clock on all the time.  So if the clock is off when you try to call
> > clk_set_rate(), you may want to turn it back to off after clk_set_rate()
> > is done.
> 
> You really shouldn't expose these kinds of SoC specific oddities outside
> of the API - it makes a mockery of having an API in the first place.
> 
> Can you not do:
> 
Yes, we can do this for now, but I'm not sure how it will live when we
migrate to common clock framework.  I actually had a brief talk with
Mike Turquette on that.  He does not think this case is common enough
and deserve being handled in clock framework.  He is trying to avoid
cross calling of clock API.  I kinda agree with him that for some cases
the client drivers may need to know the details of clock hardware at
some level.

Regards,
Shawn

> clk_set_rate(clk, rate)
> {
> 	clk_prepare(clk);
> 
> 	reprogram_clock(clk);
> 
> 	clk_unprepare(clk);
> }
> 
> A clk_prepare() call on an already prepared clock should have no impact
> other than incrementing the counter, which will be balanced on the other
> side by the clk_unprepare().
> 
