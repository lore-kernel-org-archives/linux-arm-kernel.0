From: seanpaul@chromium.org (Sean Paul)
Date: Thu, 3 Nov 2016 15:11:26 -0600
Subject: [PATCH 0/5] drm/sun4i: Handle TV overscan
In-Reply-To: <20161103090106.dq2bn4z7m2hzhi53@lukather>
References: <cover.bb9be34c7fd7767e31823f78a15ae1c127293c34.1476779323.git-series.maxime.ripard@free-electrons.com>
 <20161018092422.GJ1041@n2100.armlinux.org.uk>
 <20161018100349.qm2f554oiwyjwrsi@lukather>
 <20161031084233.GS1041@n2100.armlinux.org.uk>
 <20161103090106.dq2bn4z7m2hzhi53@lukather>
Message-ID: <CAEqLBRknDAKQu1641BEd_MKe42hYx+Jz8FcASZvC1dn6+yazxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 3, 2016 at 3:01 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Russell,
>
> On Mon, Oct 31, 2016 at 08:42:34AM +0000, Russell King - ARM Linux wrote:
>> On Tue, Oct 18, 2016 at 12:03:49PM +0200, Maxime Ripard wrote:
>> > The first one is that this overscanning should be reported by the
>> > connector I guess? but this is really TV specific, so we need one way
>> > to let the user tell how the image is displayed on its side, and we
>> > cannot really autodetect it, and this needs to be done at runtime so
>> > that we can present some shiny interface to let it select which
>> > overscan ratio works for him/her.
>>
>> See xbmc... they go through a nice shiny setup which includes adjusting
>> the visible area.  From what I remember, it has pointers on each corner
>> which you can adjust to be just visible on the screen, so xbmc knows
>> how much overscan there is, and xbmc itself reduces down to the user
>> set size.
>
> Yes. And that is an XBMC only solution, that doesn't work with the
> fbdev emulation and is probably doing an additional composition to
> scale down and center their frames through OpenGL.
>
> We might not have a GPU in the system, and we might not even have an
> entire graphic stack on top either, so I don't think fixing at the
> user-space level is a good option (especially since we already have an
> overscan property in DRM).
>

Hi Maxime,
I took a quick look at the first 2 patches in the series and they look
good at first glance. I have them in my queue to review more
carefully.

Can you explain why you can't fix this by specifying a new mode with
big porches (as Russell suggested)?

Sean


>> > The second one is that we still need to expose the reduced modes to
>> > userspace, and not only the displayed size, so that the applications
>> > know what they must draw on. But I guess this could be adjusted by the
>> > core too.
>> >
>> > In order to work consistently, I think all planes should be adjusted
>> > that way, so that relative coordinates are from the primary plane
>> > origin, and not the display origin. But that could be adjusted too by
>> > the core I guess.
>>
>> I'm not sure about that - we want the graphics to be visible, but that
>> may not be appropriate for an video overlay frame.  It's quite common
>> for (eg) broadcast video to contain dead pixels or other artifacts on
>> the right hand side, and the broadcast video expects overscan to be
>> present.
>>
>> I know this because I have run my TV with overscan disabled, even for
>> broadcast TV.
>
> I know, but on this particular hardware, composite really is just
> another video output. There's not even a TV receiver in it, so I don't
> think we have to worry about it.
>
>> > The fourth one being the major one. Every time I raised the issue on
>> > IRC, the answer basically was "we don't care about analog", so I'm a
>> > bit pessimistic about whether dealing with this in the core would be
>> > accepted, hence why I chose to deal with this at the driver level.
>>
>> Yea, that's quite sad, "analog" has become a dirty word, but really
>> this has nothing to do with "analog" at all - there are LCD TVs (and
>> some monitors) out there which take HDMI signals but refuse to
>> disable overscan no matter what you do to them if you provide them
>> with a "broadcast"  mode - so the analog excuse is very poor.
>
> I'd agree with you, but I was also told to not turn that into a
> generic code and deal with that in my driver.
>
> Do you have any suggestions?
>
> Thanks,
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
