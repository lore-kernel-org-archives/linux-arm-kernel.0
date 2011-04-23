From: linuxzsc@gmail.com (Richard Zhao)
Date: Sat, 23 Apr 2011 22:08:39 +0800
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <alpine.LFD.2.02.1104221122410.3323@ionos>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
	<alpine.LFD.2.02.1104212146400.3323@ionos>
	<20110422002805.GA2268@richard-laptop>
	<alpine.LFD.2.02.1104221122410.3323@ionos>
Message-ID: <20110423140839.GA3229@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2011 at 11:23:49AM +0200, Thomas Gleixner wrote:
> On Fri, 22 Apr 2011, Richard Zhao wrote:
> > Hi Thomas,
> > 
> > On Thu, Apr 21, 2011 at 09:48:28PM +0200, Thomas Gleixner wrote:
> > > On Fri, 15 Apr 2011, Sascha Hauer wrote:
> > > > From: Jeremy Kerr <jeremy.kerr@canonical.com>
> > > > + * @get:	Called by the core clock code when a device driver acquires a
> > > > + *		clock via clk_get(). Optional.
> > > > + *
> > > > + * @put:	Called by the core clock code when a devices driver releases a
> > > > + *		clock via clk_put(). Optional.
> > > 
> > > These callbacks are completely pointless. There are only two non empty
> > > implementations in tree:
> > > 
> > > One does a try_module_get(clk->owner), which should be done in generic
> > > code. The other does special clock enabling magic which wants to go to
> > > clk->prepare().
> > You forget mach-u300 __clk_get. It updates some registers.
> > The ops get/put let arch clock driver have a chance to do special things at the
> > time when a user begins to use the clock.
> 
> No I did not forget. It's exactly the code which wants to go into
> clk->prepare. Which you have to call _before_ doing anything with the
> clock, so there is no need for an extra callback.
No. clk_prepare only have to be called before clk_enable, but not have to for
other operations, set_rate/set_parent etc.

Thanks
Richard
> 
> Thanks,
> 
> 	tglx
