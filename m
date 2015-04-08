From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 8 Apr 2015 09:14:50 +0100
Subject: [PATCH v6 4/4] clk: dt: Introduce binding for always-on clock
 support
In-Reply-To: <20150407191746.GA26727@lukather>
References: <1428432239-4114-1-git-send-email-lee.jones@linaro.org>
 <1428432239-4114-5-git-send-email-lee.jones@linaro.org>
 <20150407191746.GA26727@lukather>
Message-ID: <20150408081450.GB5162@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 07 Apr 2015, Maxime Ripard wrote:
> On Tue, Apr 07, 2015 at 07:43:59PM +0100, Lee Jones wrote:
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  .../devicetree/bindings/clock/clock-bindings.txt   | 38 ++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> > index 06fc6d5..daf3323 100644
> > --- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> > @@ -44,6 +44,44 @@ For example:
> >    clocks by index. The names should reflect the clock output signal
> >    names for the device.
> >  
> > +clock-always-on:    Some hardware contains bunches of clocks which must never be
> > +		    turned off.  If drivers a) fail to obtain a reference to any
> > +		    of these or b) give up a previously obtained reference
> > +		    during suspend, the common clk framework will attempt to
> > +		    disable them and a platform can fail irrecoverably as a
> > +		    result.  Usually the only way to recover from these failures
> > +		    is to reboot.
> > +
> > +		    To avoid either of these two scenarios from catastrophically
> > +		    disabling an otherwise perfectly healthy running system,
> > +		    clocks can be identified as always-on using this property
> > +		    from inside a clocksource's node.
> 
> Isn't "clocksource" here way too similar to, I don't know, the
> clocksource framework? Wouln't clock provider be better?

Yes, I think you're right.  Stephen also mentioned it.

> > +
> > +		    This property is not to be abused.  It is only to be used to
> > +		    protect platforms from being crippled by gated clocks, not
> > +		    as a convenience function to avoid using the framework
> > +		    correctly inside device drivers.
> 
> Disregarding what's stated here, I'm pretty sure that this will
> actually happen. Where do you place the cursor?

That's up to Mike.

> Should we create a new driver for our RAM controller, or do we want to
> use clock-always-on?

I would say that if all the driver did was to enable clocks, then you
should use this instead.  This binding was designed specifically for
that purpose.

However, if the aforementioned driver clock can be safely gated, then
it should not be an always-on clock.

> Do we really want to enforce this if we ever gain a driver that would
> actually be able to manage its clock (like do we want the CPU clock to
> never *ever* be gated just because we don't have a cpuidle/hotplug
> driver yet?)

As I've just mentioned, if a clock 'can' be turned off, this binding
should never be used.  Situations where using always-on as a stop-gap
due to a lack of current functionality is what the paragraph above is
trying to mitigate.

> Have you seen the numerous NAK on such approach Mike did?

I haven't, but the folks reviewing previous versions have.  Do you
have something specific in mind that you'd like to bring to my
attention?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
