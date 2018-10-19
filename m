From: sre@kernel.org (Sebastian Reichel)
Date: Sat, 20 Oct 2018 00:58:27 +0200
Subject: omap4: support for manually updated display
In-Reply-To: <20181019164450.GD43338@atomide.com>
References: <20180830090456.GA17277@amd>
 <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com>
 <3205865.8O8aibZXye@avalon> <20180910174453.GV5662@atomide.com>
 <20181018221549.GB6364@amd> <20181019164450.GD43338@atomide.com>
Message-ID: <20181019225827.s76wapp3cxrmp5af@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 19, 2018 at 09:44:50AM -0700, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [181018 22:15]:
> > Hi!
> > 
> > > > I want to make it clear that I don't want to claim any privilege in getting 
> > > > patches merged first. I am however worried that, without an easy way to test 
> > > > DSI support, and without enough time to focus on it, I would break whatever 
> > > > would be merged now in future reworks. I would thus like to find out how to 
> > > > collaborate on this task, hopefully to move towards usage of drm_bridge and 
> > > > drm_panel for DSI-based pipelines.
> > > 
> > > Real users with mainline kernel with a real product should
> > > always have priority over any ongoing clean-up.
> > > 
> > > And for testing, a bunch of real users is something you can't
> > > beat for proper testing of code on ongoing basis!
> > > 
> > > Naturally the burden of getting the patches ready is on the people
> > > using them for rebase and fixing comments. And Sebastian has
> > > already agreed help with maintaining it.
> > > 
> > > I've been actually using DSI command mode support and testing
> > > Linux next several times a week to prevent regressions from
> > > sneaking into -rc1 in general. So now I can't test omapdrm with
> > > next until Sebastian is done with rebasing.. Back to headless
> > > testing then.
> > > 
> > > Anyways, I'd say let's add the DSI command mode support ASAP after
> > > rebasing, there are at least Sebastian, Pavel and I then testing
> > > and helping with further ongoing panel conversion work.
> > 
> > Are there any news here? Does someone have a patch set that actually
> > works?
> 
> I was wondering about that too.. I only have the v4.19-rc1 based
> patches and can no longer test with Linux next. Sebastian, any
> update?
> 
> > Are there any in-progress patches I could help with?
> 
> I can put in some effort too if needed.

I have some in-progress patches, that are not yet working. The
reversal of display pipeline initialization introduced some
issues with DSI (since the panel cannot be fully initialized
without DSI controller). I got this resolved by registering
the DSI display before the DSI controller is fully intialized.
This is obviously racy and breaks for device with DSI backlight
(since display probe function tries to do DSI queries). I think
properly solving this mess requires full migration to
the common mipi_dsi_host/mipi_dsi_device infrastructure. This
should obviously be done anyways, but for now the hack should
be good enough. There is still some other issue, though. I do
not yet understand the origin of that one.

I uploaded my current status here. It's not based on the newest
-next, but contains the interesting patches from Laurent. Also
the last few patches are not yet cleaned up, sorry for the mess.

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-n900.git/log/?h=droid4-display-omapdrm-4.20-next

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181020/68068820/attachment.sig>
