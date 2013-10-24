From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 24 Oct 2013 13:05:25 +0200
Subject: [PATCHv4] video: backlight: gpio-backlight: Add DT support.
In-Reply-To: <2730370.0UKsY9Ox0H@avalon>
References: <20131019104555.GI18477@ns203013.ovh.net>
 <5267FE81.3070201@wwwdotorg.org> <20131023202011.GD8828@mithrandir>
 <2730370.0UKsY9Ox0H@avalon>
Message-ID: <20131024110524.GB11296@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 12:38:59AM +0200, Laurent Pinchart wrote:
> Hi Thierry,
> 
> On Wednesday 23 October 2013 22:20:12 Thierry Reding wrote:
> > On Wed, Oct 23, 2013 at 05:51:13PM +0100, Stephen Warren wrote:
> > > On 10/22/2013 09:01 PM, Thierry Reding wrote:
> > > > On Tue, Oct 22, 2013 at 05:34:45PM +0200, Jean-Christophe
> > > 
> > > > PLAGNIOL-VILLARD wrote:
> > > ...
> > > 
> > > >> I'm sorry but the blacklight descibe in DT have nothing to do
> > > >> with the common pratice that the current driver have today
> > > > 
> > > > That's not at all what I said. What I said was that the majority
> > > > of backlight drivers currently default to turning the backlight on
> > > > when probed. Therefore I think it would be consistent if this
> > > > driver did the same.
> > > > 
> > > > I also said that I don't think it's a very good default, but at the
> > > > same time we can't just go and change the default behaviour at will
> > > > because people may rely on it.
> > > 
> > > It may well be reasonable to change the default behaviour for devices
> > > instantiated from DT. If it's not possible to instantiate the device
> > > from DT yet, then it's not possible for anyone to be relying on the
> > > default behaviour yet, since there is none. So, perhaps the default
> > > could be:
> > > 
> > > * If device instantiated from a board file, default to on, for
> > > backwards-compatibility.
> > > 
> > > * If device instantiated from DT, there is no backwards compatibility
> > > to be concerned with, since this is a new feature, hence default to
> > > off, since we think that's the correct thing to do.
> > 
> > I actually had a patch to do precisely that. However I then realized
> > that people have actually been using pwm-backlight in DT for a while
> > already and therefore may be relying on that behaviour as well.
> > 
> > It also isn't really an issue of DT vs. non-DT. The simple fact is that
> > besides the backlight driver there's usually no other code that enables
> > a backlight on boot. The only way to do so that I know of is using the
> > DRM panel patches that I've been working on.
> 
> I would very much welcome a refactoring of the backlight code that would 
> remove the fbdev dependency and hook backlights to panel drivers. That's 
> something I wanted to work on myself, but that I pushed back after CDF :-)

Yeah, that would certainly be very welcome. But it's also a pretty
daunting job since there are a whole lot of devices out there that
aren't easy to test because, well, they're pretty old and chances
are that nobody that actually has one is around.

But I guess that we can always try to solve it on a best effort basis,
though. Perhaps things can even be done in a backwards-compatible way.
I'm thinking for instance that we could introduce a new property, say
.enable, but keep any of the others suhc as state, power, fb_blank for
backwards-compatibility. Perhaps even emulate them for a while until
we've gone and cleaned up all users.

Or is there still a reason to have more than a single bit for backlight
state? I don't know any hardware that actually makes a difference
between FB_BLANK_NORMAL, FB_BLANK_VSYNC_SUSPEND, FB_BLANK_HSYNC_SUSPEND
or FB_BLANK_POWERDOWN. Many drivers in drivers/video seem to be using
those, but for backlights I can see no use other than FB_BLANK_UNBLANK
meaning enabled and anything else meaning disabled.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131024/1814f327/attachment.sig>
