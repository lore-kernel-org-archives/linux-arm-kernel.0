From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Jul 2014 12:53:19 -0400
Subject: [PATCH 4/4] ARM: mvebu: add armada drm init to Dove board setup
In-Reply-To: <20140701131026.GO32514@n2100.arm.linux.org.uk>
References: <1404219871-18419-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1404219871-18419-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140701131026.GO32514@n2100.arm.linux.org.uk>
Message-ID: <20140701165319.GH23978@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Tue, Jul 01, 2014 at 02:10:26PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jul 01, 2014 at 03:04:31PM +0200, Sebastian Hesselbarth wrote:
> > +	pdev = platform_device_register_full(&armada_drm_dev_info);
> > +	/* assign last found lcd node to drm device for clk lookup */
> > +	pdev->dev.of_node = clknp;
> 
> NAK.  This really isn't a good way to deal with this, even in a
> temporary basis.  While assigning a DT node to a manually created
> platform device does solve that problem, it also introduces the
> problem that this platform device will now match any platform driver
> which recognises the "marvell,dove-lcd" compatible type, which may
> occur _before_ we find the driver to match using the legacy strings.
> 
> There really isn't an easy solution to this other than doing the thing
> properly.

And this creates our current deadlock.

> The other problem in this series is that while you introduce some
> bindings which may work today, they're not going to work tomorrow, and
> that's a problem.  Don't do DT piecemeal like this and end up having to
> break the bindings (which we will have to do to add the endpoints.)

Seriously, we've got to do something to get off of the X.  Why not just
declare the binding Sebastian just sent as unstable?  Then we change it
as needed until we get all the pieces in place.

At KS2013, we discussed, and agreed upon the fact that we _can_ have
unstable bindings to keep the bus moving.  Perfection being the enemy of
getting it done and all.

Once we reach the goal of how we want the bindings to look, then we
declare it stable.  I know it's not ideal, but "plan it out perfectly
before pushing anything" isn't realistic either.

thx,

Jason.
