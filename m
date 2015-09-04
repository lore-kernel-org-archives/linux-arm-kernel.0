From: treding@nvidia.com (Thierry Reding)
Date: Fri, 4 Sep 2015 12:01:48 +0200
Subject: [PATCH v4 14/16] drm: bridge: analogix/dp: try force hpd after
 plug in lookup failed
In-Reply-To: <CAL_Jsq+F=eE6vU3f-bHrrSCD9GCoh80Nf-5=Qm73QgGDW1Np=w@mail.gmail.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1441088079-25809-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqJDALnjVaVoEqGGsSLeE31m3MKOfbSoZ3M+g+zPZR2MFg@mail.gmail.com>
 <20150903084735.GB3784@ulmo.nvidia.com>
 <CAL_Jsq+F=eE6vU3f-bHrrSCD9GCoh80Nf-5=Qm73QgGDW1Np=w@mail.gmail.com>
Message-ID: <20150904100147.GE22056@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 03, 2015 at 04:55:59PM -0500, Rob Herring wrote:
> On Thu, Sep 3, 2015 at 3:47 AM, Thierry Reding <treding@nvidia.com> wrote:
> > On Wed, Sep 02, 2015 at 03:17:57PM -0500, Rob Herring wrote:
> > [...]
> >> Are there any eDP panels which don't have EDID and need panel details in DT?
> >
> > Most panels need information other than EDID. They typically have some
> > requirements regarding the power up sequence that aren't to be found
> > anywhere in EDID or detectable by some other mechanism. A decision was
> > therefore made a long time ago to require panels to be listed in DT with
> > a specific compatible string. That way all of these details can be
> > stashed away in drivers that know how to deal with these kinds of
> > details.
> 
> I guess I was being hopeful that eDP was improving that situation.

Unfortunately not. eDP helps with a number of things (DPCD and link
training take care of a lot of the issues), but it doesn't provide a
solution for everything.

To my knowledge in most cases the power up sequence isn't strictly
necessary to get the panel to operate. But there have been instances
where this is absolutely required if you want to avoid visual artifacts
as you set a mode. A lot of panels that I've come across require
receiving a couple of frames before they guarantee that something will
actually be displayed on the screen. So if your code is too quickly
enabling backlight, and your backlight doesn't happen to have just the
right amount of ramp-up time you might end up seeing garbage on the
screen for a couple of frames.

It would be great if somebody came up with, say, an EDID extension to
describe these requirements, but I'm not sure if even that would give
us panels that could be driven with a generic driver. Often the power
supplies or reset/enable signals are very different across panels. So
describing it all generically would become messy rather quickly.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150904/46733cc4/attachment.sig>
