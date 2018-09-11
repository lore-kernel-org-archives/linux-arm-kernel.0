From: lkundrak@v3.sk (Lubomir Rintel)
Date: Tue, 11 Sep 2018 15:19:30 +0200
Subject: [PATCH 1/4] dt-bindings: mrvl,mmp-timer: add clock
In-Reply-To: <CAL_JsqKgJFZnpuv7rW6ovxMKi4Q2AngWxKa=CMR_Y+xD5Oh3GA@mail.gmail.com>
References: <20180910113031.42634-1-lkundrak@v3.sk>
 <20180910113031.42634-2-lkundrak@v3.sk>
 <CAL_JsqKgJFZnpuv7rW6ovxMKi4Q2AngWxKa=CMR_Y+xD5Oh3GA@mail.gmail.com>
Message-ID: <3ab50e5f4c647229b575bc5de5e80f9ed80ac938.camel@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-09-10 at 10:21 -0500, Rob Herring wrote:
> On Mon, Sep 10, 2018 at 6:30 AM Lubomir Rintel <lkundrak@v3.sk>
> wrote:
> > 
> > The timer needs the timer clock to be enabled, otherwise it stops
> > ticking.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/timer/mrvl,mmp-
> > timer.txt b/Documentation/devicetree/bindings/timer/mrvl,mmp-
> > timer.txt
> > index 9a6e251462e7..a2ede0bd12ca 100644
> > --- a/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
> > +++ b/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
> > @@ -4,10 +4,12 @@ Required properties:
> >  - compatible : Should be "mrvl,mmp-timer".
> >  - reg : Address and length of the register set of timer
> > controller.
> >  - interrupts : Should be the interrupt number.
> > +- clocks : Should contain a single entry describing the clock
> > input.
> 
> So now pxa910 and pxa168 dts files have errors because they are
> missing a required clock.

Ah, right. Sorry. Will make it optional then.

A brief look at 16x datasheet suggests that the "fast clock" source
circuitry needs to be enabled in the PMU, whereas the internal "32.768"
might not be. Perhaps the timer clk is always enabled in PMU, or the
slow clock is used on those platforms? No idea.

> Plus somehow other MMP2 platforms either
> worked without a clock or have been broken.

I don't have a MMP2 datasheet, but if things work the same as on a 16x,
then mach-mmp/time.c indeed chooses the fast timer.

The DT MMP2 platform certainly is certainly broken*. Not sure about the
BSP-based platforms.

* in other ways too: even when the missing clock is worked around with
  "clk_ignore_unused" the wrong rate gets chosen and the timer runs too
  slow. (Fix posted recently.)

> You can't add new required properties to a binding. That breaks
> backward compatibility.

Should I make an effort to make the driver look up and enable the clock
on MMP2 even if it doesn't find the clock property in DT?

It won't work otherwise, which is why I thought I can't break it
further (I didn't notice that the same binding and driver are used on
PXA168 and PXA910).

> Rob

Thank you,
Lubo

> > 
> >  Example:
> >         timer0: timer at d4014000 {
> >                 compatible = "mrvl,mmp-timer";
> >                 reg = <0xd4014000 0x100>;
> >                 interrupts = <13>;
> > +               clocks = <&coreclk 2>;
> >         };
> > --
> > 2.17.1
> > 
