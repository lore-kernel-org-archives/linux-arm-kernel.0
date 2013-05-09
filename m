From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 May 2013 16:43:52 +0100
Subject: [PATCH 1/3] driver core: Add API to wait for deferred probe to
 complete during init
In-Reply-To: <20130509150750.GW18614@n2100.arm.linux.org.uk>
References: <1368076726-11492-1-git-send-email-skannan@codeaurora.org>
 <1368076726-11492-2-git-send-email-skannan@codeaurora.org>
 <CACVXFVMd_iRtEM8ZLK6Ps66gZO6SCp1mXSgY6JbWtRJjJUh+ag@mail.gmail.com>
 <CACxGe6uHBNUcbD9SeRP5c3E8NN-Z2yjVV+9VAhuoJnXoBtTu2w@mail.gmail.com>
 <20130509135017.GD3200@sirena.org.uk>
 <20130509141444.GV18614@n2100.arm.linux.org.uk>
 <20130509143702.GE3200@sirena.org.uk>
 <20130509150750.GW18614@n2100.arm.linux.org.uk>
Message-ID: <20130509154352.GG3200@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 09, 2013 at 04:07:50PM +0100, Russell King - ARM Linux wrote:
> On Thu, May 09, 2013 at 03:37:02PM +0100, Mark Brown wrote:

> > That's clearly a "don't do that then" sort of thing; while we don't want
> > to be unhelpful there's no guarantees with this approach.

> That's not a "don't do that then" thing, because in this case it's
> unreasonable to say that.  The display subsystems like fbdev and
> DRM represent quite a sizable chunk:

> - Base DRM is around 200k.
> - DRM drivers typically around 100k each.
> - Base FBdev is around 100k.

> It won't take long before you're into the territory of having a
> significant portion of your kernel being display drivers of one
> type or other, much of which won't be usable on any one specific
> platform.  So to say "don't build your display drivers as modules"
> is an unreasonable position to take.

Sure, it's unhelpful for distro style kernels.  Like I say, 90%.

> > Another option here which is more in tune with deferred probing and
> > hotplugging would be to switch the delay over to be time based rather
> > than initcall based; do the shutdown at some point based on the time the
> > last resource was registered.  That still won't cover everything
> > though we could make the delay tunable.

> Yuck.  That's crap design.  Really, time based stuff is crap.  I've seen
> this too many times with the gnome crap in Ubuntu 12.04 - where if you
> boot this off SD card it will complain that some applets fail to start
> (and sure enough, half your panel is missing.)  Boot it off eSATA and
> it works 100% reliably.

No argument here, there's a reason I immediately went to the "make it
tunable" fudge factor.

> A better solution may be to avoid the problem in kernel space altogether.
> That's already done in the past with the scsi_wait_scan module.  Make the
> the shutdown of stuff a separate loadable module which userspace can load
> at the appropriate time to trigger the shutdown of unused resources.  Or
> provide a different method for userspace to trigger that action.

> With that kind of solution, it is possible to know that the system has
> finished booting (many userspace implementations already do this with
> stuff like not permitting login via network until after the system has
> finished booting despite sshd et.al. already being started.)

This works fine for boot but if we're going to solve this properly and
asking userspace to make changes we probably ought to be trying to
handle the actual hotplug case (which the current bodge doesn't cope
with at all) as well.  A similar tactic with asking for handshaking from
userspace for hotplug notifications should work though it'd be a bit
more hassle to deploy.

Or perhaps given that it should be simple for userspace and there's
probably other uses for the information we just put the hook in there
anyway even if this particular problem gets a better solution later on.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130509/10ea8e4c/attachment-0001.sig>
