From: dsd@laptop.org (Daniel Drake)
Date: Sat, 29 Jun 2013 14:15:58 -0600
Subject: armada_drm clock selection
In-Reply-To: <20130629192616.GC3353@n2100.arm.linux.org.uk>
References: <20130628201133.1D6D2FAAD5@dev.laptop.org>
 <20130628211848.GJ4283@n2100.arm.linux.org.uk>
 <CAMLZHHQZ+36g9EQhj+LOgQioj8T5VDwvUdNrkVLboT8tYi9gXQ@mail.gmail.com>
 <20130629192616.GC3353@n2100.arm.linux.org.uk>
Message-ID: <CAMLZHHTFF2Ca7vr-gccLxPMW=vjAwApCLgtKJRQpz-bT5KVv=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 29, 2013 at 1:26 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> So, I'd suggest that an initial approach would be something along the
> lines of:
> - if there is an external clock, can it generate the desired rate?
>   if yes, use it.
> - otherwise, get the clock rate from the internal clocks and calculate
>   the appropriate divider.  Use which ever one gives you the best
>   approximation that's better than (eg) 1%.  If not, fail the mode set.

This sounds sane to me.

According to your earlier mail, armada 510 is the only current target
platform that has external clocks. For the fallback on internal
clocks, we would not try to change the rate of any of them, we would
just look at how close they can bring us to what is needed, as you
describe.

If any clocks are broken or useless on a specific platform, then they
can be excluded from the DT or platform data. So this is really not
far off from the ideas from Sebastian and me where we would simply
pass in the information about the "interesting" clocks and be done
with it.

I agree that we need the DT have a way of not only providing the
clock, but also indicating which clock in the SCLK register it refers
to, and I also think the way to do that is by having a fixed,
documented clock naming scheme. So that should not be a problem. I'll
avoid putting register values in the DT.

I think that resolves all the open questions that I had, so I will
work on this early next week.

> This now brings me on to another important subject with DT vs DRM.
> The way DRM is setup, it expects all resources for a particular
> implementation to be known at 'drm_device' creation time.  You can't
> "hot-plug" additional parts of the "drm system" together.  What this
> means is that at driver load time (to use DRM terms) all parts must
> be known.

Its unfortunate that we can't hotplug the DRM bits, but at least that
is no longer an open question.

The super-device approach sounds sane and would seem to reflect on
other parts of the DT that I have worked with. It seems reasonable to
take the viewpoint that the LCD is a child connected to the display
controller parent, which is what the DT layout suggests.

I wonder what other DRM drivers do DT-wise? Maybe I will look into
that after we've progressed with the clocks.

Daniel
