From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 18 Jan 2011 17:44:45 +0900
Subject: [PATCH 1/2] Add a common struct clk
In-Reply-To: <20110111112240.GQ12078@pengutronix.de>
References: <1294199462.347935.472473715866.0.gpush@pororo>
	<1294199462.348449.192344022926.1.gpush@pororo>
	<20110111101636.GF26617@pengutronix.de>
	<201101111827.12291.jeremy.kerr@canonical.com>
	<20110111112240.GQ12078@pengutronix.de>
Message-ID: <20110118084445.GL2122@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 12:22:40PM +0100, Sascha Hauer wrote:
> On Tue, Jan 11, 2011 at 06:27:11PM +0800, Jeremy Kerr wrote:
> > Hi Sascha,
> >  
> > > The i.MX clk implementation disables the old parent if clk is enabled
> > > and enables the new parent if clk is enabled (modulo bugs). Shouldn't
> > > we do this here aswell?
> > 
> > Sounds reasonable, yes.
> > 
> > > I thought about returning -EBUSY if clk_set_parent is called for an
> > > enabled clk, but this way we could never reparent the cpu clock which I
> > > think is done in the Freescale BSP for power saving.
> > 
> > I think that the possibility for changing the parent really depends on the 
> > implementation; in some cases we may want to disallow it, in others it might 
> > be fine.
> > 
> > Related: do we really need globally-accessible clk_{get,set}_parent in the clk 
> > API? For cases where we need to set the parent, we probably need details about 
> > the platform clock configuration (eg, which clocks are possible parents). In 
> > this case, we could just call into the clock driver directly.
> 
> I agree that drivers have no business calling clk_{get,set}_parent, this
> is purely platform specific.
> 
Do you guys even bother to grep the kernel for users of the API before
coming up with arbitrary policy?

There are plenty of cases where clocks are allocated dynamically by
driver code that in turn can be set up as a parent for other dynamically
allocated clocks. This has not a damn thing to do with platform code and
everything to do with the clock circuitry of the device or IP block in
question.

If you actually want this API unification thing to not be completely
stillborn, I recommend focusing on how people are actually using the API
today (especially the parts that are used by the majority of users, not
the one you happened to base your implementation off of), and then trying
to push your interpretation or roadmap for the API at a later stage. This
way the former has a chance of getting upstream without the latter
completely derailing it.
