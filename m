From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Wed, 07 Jun 2017 20:15:12 +0200
Subject: [PATCH v2 03/11] drm: sun4i: ignore swapped mixer<->tcon
 connection for DE2
In-Reply-To: <20170607143827.4ng5gedvzn3f5pyx@flea.lan>
References: <20170604160149.30230-1-icenowy@aosc.io>
 <01A7F22E-C4FF-4B4B-A9BC-FF0C96B996B9@aosc.io>
 <20170607143827.4ng5gedvzn3f5pyx@flea.lan>
Message-ID: <74846068.xK7nHVXuC6@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Dne sreda, 07. junij 2017 ob 16:38:27 CEST je Maxime Ripard napisal(a):
> On Wed, Jun 07, 2017 at 06:01:02PM +0800, Icenowy Zheng wrote:
> > >I have no idea what this is supposed to be doing either.
> > >
> > >I might be wrong, but I really feel like there's a big mismatch
> > >between your commit log, and what you actually implement.
> > >
> > >In your commit log, you should state:
> > >
> > >A) What is the current behaviour
> > >B) Why that is a problem
> > >C) How do you address it
> > >
> > >And you don't.
> > >
> > >However, after discussing it with Chen-Yu, it seems like you're trying
> > >to have all the mixers probed before the TCONs. If that is so, there's
> > >nothing specific to the H3 here, and we also have the same issue on
> > >dual-pipeline DE1 (A10, A20, A31). Chen-Yu worked on that a bit, but
> > >the easiest solution would be to move from a DFS algorithm to walk
> > >down the graph to a BFS one.
> > >
> > >That way, we would add all mixers first, then the TCONs, then the
> > >encoders, and the component framework will probe them in order.
> > 
> > No. I said that they're swappable, however, I don't want to
> > implement the swap now, but hardcode 0-0 1-1 connection.
> 
> We're on the same page, it's definitely not what I was mentionning
> here. This would require a significant rework, and the usecase is
> still unclear for now.
> 
> > However, as you and Chen-Yu said, device tree should reflect the
> > real hardware, there will be bonus endpoints for the swapped
> > connection.
> 
> If by bonus you mean connections from mixer 0 to tcon 1 and mixer 1 to
> tcon 0, then yes, we're going to need it.
> 
> > What I want to do is to ignore the bonus connection, in order to
> > prevent them from confusing the code.
> > 
> > If you just change the bind sequence, I think it cannot be
> > prevented that wrong connections will be bound.
> 
> This is where I don't follow you anymore. The component framework
> doesn't list connections but devices. The swapped connections do not
> matter here, we have the same set of devices: mixer0, mixer1, tcon0
> and tcon1.
> 
> The thing that does change with your patch is that before, the binding
> sequence would have been mixer0, tcon0, tcon1, mixer1. With your
> patch, it's mixer0, tcon0, mixer1, tcon1.
> 
> So, again, stating what issue you were seeing before making this patch
> would be very helpful to see what you're trying to do / fix.

If I understand correctly, she wants to make sure that DT has mixer0 - tcon0 
and mixer1 - tcon1 relationship and discard mixed relationship. I also believe 
that this is just temporary measure until mixed relationship is supported by 
the driver.

Maybe we could just leave this out for now and define only one endpoint in DT 
for TVE instead of two? Vast majority of users will have 0-0 and 1-1 
relationship, since there is not much point connecting HDMI with less capable 
mixer than TVE.

Best regards,
Jernej
