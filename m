From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 15 Sep 2016 12:17:41 +0200
Subject: [GIT PULL] Greybus driver subsystem for 4.9-rc1
In-Reply-To: <CAL_JsqJtDs-DrPDN4=9ET=EdEDTKxP-gRDkMziimQAz4LG457A@mail.gmail.com>
References: <20160914100949.GA6179@kroah.com>
 <20160914173625.GB15356@leverpostej>
 <20160914180754.GA16053@kroah.com>
 <CAL_JsqJtDs-DrPDN4=9ET=EdEDTKxP-gRDkMziimQAz4LG457A@mail.gmail.com>
Message-ID: <20160915101741.GA21567@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 03:07:22PM -0500, Rob Herring wrote:
> On Wed, Sep 14, 2016 at 1:07 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Wed, Sep 14, 2016 at 06:36:26PM +0100, Mark Rutland wrote:
> >> Hi Greg,
> >>
> >> On Wed, Sep 14, 2016 at 12:09:49PM +0200, Greg KH wrote:
> >> > Given that it's never a good idea to keep subsystems out of the mainline
> >> > kernel, I've put together this pull request that adds the greybus driver
> >> > layer to drivers/greybus/.  Because this was 2 1/2 years of work, with
> >> > many many developers contributing, I didn't want to flatten all of their
> >> > effort into a few small patches, as that wouldn't be very fair.  So I've
> >> > built a git tree with all of the changes going back to the first commit,
> >> > and merged it into the kernel tree, just like btrfs was merged into the
> >> > kernel.
> >>
> >> > Unless people point out some major problems with this, I'd like to get
> >> > it merged into 4.9-rc1.
> >>
> >> I'm extremely concerned that these patches have *never* seen upstream
> >> review, and this pull request gives no real opportunity for people to
> >> make a judgement regarding the code, as many relevant parties have not
> >> been Cc'd.
> >
> > As I said, I will send a set of simple patches, I wanted to get this out
> > as soon as possible and other things came up today.  Will do it in the
> > morning, sorry.
> >
> >> From a quick scan of the git tree, I can see code (that isn't even
> >> placed under staging/) for which I have fundamental objections to as a
> >> maintainer, and has not been Cc'd to a relevant list.
> >>
> >> For example, I see commit 5a450477311fbfe2 ("greybus: timesync: Add
> >> timesync core driver"). This states that it directly accesses the ARMv7
> >> architected timer, though it's unclear as to precisely what it's doing
> >> since it introduces an (undocumented) compatible string, and what should
> >> be an unnecessary devicetree property.
> >>
> >> That's never gone to the linux-arm-kernel mainline list, myself or Marc
> >> (as maintainers of the arch timer driver), nor has the binding seen any
> >> review on the devicetree mailing list.
> >
> > Hm, odd, I thought we had Rob review all of the device tree bindings,
> > but maybe the timesync stuff missed him.  And timesync is "odd" to say
> > the least, wait until you see the firmware side of it :)
> 
> I have not. There weren't any when I was involved (other than SOC
> related bindings). Some like USB devices were discussed at least, but
> at the time there was no common definition of how to deal with
> soldered, on-board USB devices. And that was also what's good enough
> to move forward with development, not ready for mainline. There's a
> binding now for USB, but what's there for arche predates it IIRC. This
> is the first I've heard of timesync having a binding. I can't imagine
> why it needs one.

Ah, I'll let Bryan answer that one :)

> I was going to stay out of this, but now that I'm here...
> 
> I'm not all that worried about the quality of the code, but do
> question whether this really makes sense to merge at this time. While
> I worked on Ara and would like to see all this code be used, I'm
> pretty doubtful it will be. Yes, Motorola is using a version of it,
> but they forked it some time back and changed who knows what. So what
> is upstream won't likely even work with any publicly available device.
> And how long that Motorola phone lasts is unknown. Sure it is self
> contained, but maintenance to keep it in tree is not 0.

We have people who are willing to maintain it (me and Johan) and others
on the cc: have expressed interest in doing things with it (Rui has
great ideas about extending gbsim in ways to make it easier to test and
use).

And there is never a restriction on accepting kernel code for "publicly
availble devices only", remember, we have ripped CPU code out of the
kernel for chips that never shipped.  It just has to not affect others
in ways that would affect them.

I merge new driver subsystems to the kernel every release that are much
larger than this, and have almost no users out there, so this shouldn't
be a surprise to anyone (who here has a most-bus device?  A unisys
visorbus device?  MCB device?  I can go on :)

And with gbsim, you can run this code today on your laptop, or directly
on a target system like a beagle bone black or minnowboard.  There's a
talk about how to use greybus over IP at ELC in a few weeks, and someone
is working on porting the firmware side to an arduino to make it simper
to control the devices on such a target from a host computer using the
greybus protocol.

And getting Motorola to merge back in with this upstream code is a good
goal, having it upstream is a neutral place where everyone can work
together on it.  Keeping it in a random github project makes forks
almost inevitable, as we all know.

> There's also things that never got solved. Like how do you describe
> devices on I2C, SPI, UART, etc. behind a greybus device? The plan was
> to use DT overlays, but that was never solved and brings a whole set
> of problems to solve upstream.

That is only an issue if you want to bind a kernel driver for an
existing i2c/spi chip to an i2c/spi greybus device.  With the code we
have today, we do it for a specific SPI chip (for firmware download),
but rely on everything to be userspace-only accesses to make it simpler
at this point in time.

When DT overlays get more settled down, yes, I want to revisit this idea
of how to do it for greybus devices, but that's a long-term goal and is
not required at all right now to have a working system and devices.

thanks,

greg k-h
