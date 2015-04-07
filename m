From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 7 Apr 2015 10:42:23 +0100
Subject: [PATCH v5 4/4] clk: dt: Introduce binding for always-on clock
 support
In-Reply-To: <CAMuHMdXbWTuQAP9hg1qVCgaodkD3Wjin9UX=7uT=F0yodqEm+g@mail.gmail.com>
References: <1427891304-20160-1-git-send-email-lee.jones@linaro.org>
 <1427891304-20160-5-git-send-email-lee.jones@linaro.org>
 <CAMuHMdXbWTuQAP9hg1qVCgaodkD3Wjin9UX=7uT=F0yodqEm+g@mail.gmail.com>
Message-ID: <20150407094223.GI3461@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 02 Apr 2015, Geert Uytterhoeven wrote:

> On Wed, Apr 1, 2015 at 2:28 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  .../devicetree/bindings/clock/clock-bindings.txt   | 31 ++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> > index 06fc6d5..94cdda2 100644
> > --- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> > @@ -44,6 +44,37 @@ For example:
> >    clocks by index. The names should reflect the clock output signal
> >    names for the device.
> >
> > +clock-always-on:    Some hardware contains bunches of clocks which must never be
> > +                   turned off.  If drivers a) fail to obtain a reference to any
> > +                   of these or b) give up a previously obtained reference
> > +                   during suspend, the common clk framework will attempt to
> > +                   disable them and a platform can fail irrecoverably as a
> > +                   result.  Usually the only way to recover from these failures
> > +                   is to reboot.
> > +
> > +                   To avoid either of these two scenarios from catastrophically
> > +                   disabling an otherwise perfectly healthy running system,
> > +                   clocks can be identified as always-on using this property
> > +                   from inside a clocksource's node.
> > +
> > +                   This property is not to be abused.  It is only to be used to
> > +                   protect platforms from being crippled by gated clocks, not
> > +                   as a convenience function to avoid using the framework
> > +                   correctly inside device drivers.
> 
> Please document what are the expected value(s) for this property.
> I assume these are clock indices into the array of hardware clocks?
> 
> Do they take into account sparse hardware clocks, cfr. the "clock-indices"
> property below (I didn't check)?

They must match a valid indices.  If the clock-indices property is
present, the value identified as always-on must match one of the
clocks listed.

I'll mention that.

> > +For example:
> > +
> > +    oscillator {
> > +        #clock-cells = <1>;
> > +        clock-output-names = "ckil", "ckih";
> > +        clock-always-on = <0>, <1>;
> > +    };
> > +
> > +- this node defines a device with two clock outputs, just as in the
> > +  example above.  The only difference being that 'ckil' and 'ckih'
> > +  are now identified as an always-on clocks, so the framework will
> > +  know to never attempt to gate them.
> > +
> >  clock-indices:    If the identifying number for the clocks in the node
> >                    is not linear from zero, then this allows the mapping of
> >                    identifiers into the clock-output-names array.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
