From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 10 Nov 2018 01:14:06 +0900
Subject: [PATCH 3/4] dt-bindings: reset: uniphier: Add AHCI core reset
 description
In-Reply-To: <1541775663.4112.48.camel@pengutronix.de>
References: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1541727727-10821-4-git-send-email-hayashi.kunihiko@socionext.com>
 <1541775663.4112.48.camel@pengutronix.de>
Message-ID: <CAK7LNAQGftPMLkQk-tU4R6Jtw9W6npka+Br+2wyyZicAgwDvRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2018 at 12:02 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> Hi Kunihiko,
>
> On Fri, 2018-11-09 at 10:42 +0900, Kunihiko Hayashi wrote:
> > Add compatible strings for reset control of AHCI core implemented in
> > UniPhier SoCs. The reset control belongs to AHCI glue layer.
> >
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  Documentation/devicetree/bindings/reset/uniphier-reset.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> > index f63c511..ea00517 100644
> > --- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> > +++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> > @@ -133,6 +133,9 @@ Required properties:
> >      "socionext,uniphier-pxs2-usb3-reset" - for PXs2 SoC USB3
> >      "socionext,uniphier-ld20-usb3-reset" - for LD20 SoC USB3
> >      "socionext,uniphier-pxs3-usb3-reset" - for PXs3 SoC USB3
> > +    "socionext,uniphier-pro4-ahci-reset" - for Pro4 SoC AHCI
> > +    "socionext,uniphier-pxs2-ahci-reset" - for PXs2 SoC AHCI
> > +    "socionext,uniphier-pxs3-ahci-reset" - for PXs3 SoC AHCI
>
> Since the driver behaves identically for "socionext,uniphier-pro4-usb3-
> reset" and "socionext,uniphier-pro4-ahci-reset", would it make sense to
> add a common compatible?


As far as I could guess, he just happened to find the same driver code
could be reused for other hardware.

Theoretically, this can happen anywhere since
a reset controller is just a set of registers
each bit of which is connected to a reset line.

If you added a super-generic compatible like "simple-reset",
I would agree with
"socionext,uniphier-pro4-usb3-reset", "simple-reset"
since this is a pattern.


However,
"socionext,uniphier-pro4-glue-reset" is kind of a halfway house
where it is SoC-specific, but still ambiguous.


> Something like:
> "socionext,uniphier-pro4-usb3-reset", "socionext,uniphier-pro4-glue-reset" - for USB3 SoC AHCI
> "socionext,uniphier-pro4-ahci-reset", "socionext,uniphier-pro4-glue-reset" - for Pro4 SoC AHCI
>
> That way if more places turn up where the glue layer reset is used,
> you can add them without patching the driver every time.


This is a trade-off between "patch the driver"
and "potential change of the binding".

There is no real hardware like pro4-glue-reset.



I am guessing this is a part of syscon or something,
but I cannot find any explanation in a bigger picture.

So, I cannot judge this further more.




> regards
> Philipp



--
Best Regards
Masahiro Yamada
