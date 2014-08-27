From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 27 Aug 2014 11:52:48 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140827084526.GR15297@lukather>
References: <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <20140826210248.GO15297@lukather> <20140827065440.GG15640@ulmo>
 <20140827084526.GR15297@lukather>
Message-ID: <20140827095241.GC23186@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 10:45:26AM +0200, Maxime Ripard wrote:
> On Wed, Aug 27, 2014 at 08:54:41AM +0200, Thierry Reding wrote:
> > On Tue, Aug 26, 2014 at 11:02:48PM +0200, Maxime Ripard wrote:
> > > On Tue, Aug 26, 2014 at 04:35:51PM +0200, Thierry Reding wrote:
[...]
> > > > > Mike Turquette repeatedly said that he was against such a DT property:
> > > > > https://lkml.org/lkml/2014/5/12/693
> > > > 
> > > > Mike says in that email that he's opposing the addition of a property
> > > > for clocks that is the equivalent of regulator-always-on. That's not
> > > > what this is about. If at all it'd be a property to mark a clock that
> > > > should not be disabled by default because it's essential.
> > > 
> > > It's just semantic. How is "a clock that should not be disabled by
> > > default because it's essential" not a clock that stays always on?
> > 
> > Because a clock that should not be disabled by default can be turned off
> > when appropriate. A clock that is always on can't be turned off.
> 
> If a clock is essential, then it should never be disabled. Or we don't
> share the same meaning of essential.

Essential for the particular use-case.

> > > > But you can work around that for now by making the relevant clocks
> > > > always on and remove that workaround once a real driver is loaded
> > > > that knows how to handle them properly.
> > > 
> > > So, let me get this straight. The clock provider driver should behave
> > > as a clock consumer because it knows that in some cases, it might not
> > > have any willingful enough consumer? Doesn't that even ring your
> > > this-is-a-clear-abstraction-violation-bell just a tiny bit?
> > 
> > No. The clock driver should simply not allow the clocks to be disabled
> > if it isn't safe to do so.
> 
> Again, we do seem to differ on our interpretation of an essential
> clock. To me, it is perfectly safe to disable the clocks. The system
> will still be responding, the memory will be there, the CPU will keep
> running, and we do have a way to recover from that disabled to clock
> (for example to enable it back).
> 
> Plus, again, in Mike's mail, it's clearly said that adding hacks like
> this to the clock driver should only be considered in the case where
> we don't have a consuming driver, which is not our case here.

Well, that depends on what you mean by the consuming driver. simplefb
isn't a traditional driver in that sense. There will eventually, in a
more fully-featured system, be a driver that properly consumes the
clocks. Now, since this is only a temporary measure I think it's one of
the cases where having this encoded in the clock driver would be
appropriate.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140827/4d523abb/attachment-0001.sig>
