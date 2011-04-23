From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 23 Apr 2011 17:30:37 +0200 (CEST)
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <20110423140839.GA3229@richard-laptop>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
	<alpine.LFD.2.02.1104212146400.3323@ionos>
	<20110422002805.GA2268@richard-laptop>
	<alpine.LFD.2.02.1104221122410.3323@ionos>
	<20110423140839.GA3229@richard-laptop>
Message-ID: <alpine.LFD.2.02.1104231701320.3323@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 23 Apr 2011, Richard Zhao wrote:
> On Fri, Apr 22, 2011 at 11:23:49AM +0200, Thomas Gleixner wrote:
> > On Fri, 22 Apr 2011, Richard Zhao wrote:
> > > Hi Thomas,
> > > 
> > > On Thu, Apr 21, 2011 at 09:48:28PM +0200, Thomas Gleixner wrote:
> > > > On Fri, 15 Apr 2011, Sascha Hauer wrote:
> > > > > From: Jeremy Kerr <jeremy.kerr@canonical.com>
> > > > > + * @get:	Called by the core clock code when a device driver acquires a
> > > > > + *		clock via clk_get(). Optional.
> > > > > + *
> > > > > + * @put:	Called by the core clock code when a devices driver releases a
> > > > > + *		clock via clk_put(). Optional.
> > > > 
> > > > These callbacks are completely pointless. There are only two non empty
> > > > implementations in tree:
> > > > 
> > > > One does a try_module_get(clk->owner), which should be done in generic
> > > > code. The other does special clock enabling magic which wants to go to
> > > > clk->prepare().
> > > You forget mach-u300 __clk_get. It updates some registers.
> > > The ops get/put let arch clock driver have a chance to do special things at the
> > > time when a user begins to use the clock.
> > 
> > No I did not forget. It's exactly the code which wants to go into
> > clk->prepare. Which you have to call _before_ doing anything with the
> > clock, so there is no need for an extra callback.
> No. clk_prepare only have to be called before clk_enable, but not have to for
> other operations, set_rate/set_parent etc.

And why do you need those registers set before you actually
prepare/enable the clock? Just to set the rate register? You can store
that information and set it on prepare. Before prepare/enable the
value of the rate register is totally irrelevant.

The point of anything whats named get and put in the kernel is to
obtain or drop a reference to an object.

Putting arbitrary initialization into such functions is a really bad
hack.

And looking at that u300 code, it's borken:

    user1: clk_get("MCLK");
    	   clk_set_rate(.....);

    user2: clk_get("MCLK");

The second clk_get() call will overwrite what ?

The fact that you decided to put that into the absolutely wrong
function is not an argument for keeping those callbacks.

The only real usecase for __clk_get() is the
try_module_get()/module_put() code which will become part of the
generic code. It does exaclty what get and put are meant for: dealing
with refcounts.

Thanks,

	tglx
