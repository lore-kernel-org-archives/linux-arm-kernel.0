From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 14 Nov 2018 11:15:06 +0800
Subject: [PATCH 01/15] dt-bindings: net: broadcom-bluetooth: Fix external
 clock names
In-Reply-To: <5bea0ebe.1c69fb81.e15d7.98e1@mx.google.com>
References: <20181107101308.7626-1-wens@csie.org>
 <20181107101308.7626-2-wens@csie.org>
 <5bea0ebe.1c69fb81.e15d7.98e1@mx.google.com>
Message-ID: <CAGb2v65PqwKrRdh2_Y48zYnmJa0=hv3Bd4UdvdWvBBMfT2BfSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 7:37 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Nov 07, 2018 at 06:12:54PM +0800, Chen-Yu Tsai wrote:
> > The Broadcom Bluetooth controllers can take up to two external clocks:
> > an external frequency reference, substituting the main crystal, and a
> > LPO clock at 32.768 kHz substituting the internal LPO clock.
> >
> > In particular, the external LPO clock must be used when the controller
> > does not have NVRAM connected, and the main reference frequency is not
> > the default 20 MHz. This is described in detail in the datasheet.
> >
> > The original "extclk" clock name is ambiguous as to which of these it
> > refers to, and some designs might even require both.
> >
> > This patch deprecates the existing name, and adds "txco" and "lpo".
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > index 4194ff7e6ee6..2535e54219af 100644
> > --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > @@ -18,7 +18,10 @@ Optional properties:
> >   - shutdown-gpios: GPIO specifier, used to enable the BT module
> >   - device-wakeup-gpios: GPIO specifier, used to wakeup the controller
> >   - host-wakeup-gpios: GPIO specifier, used to wakeup the host processor
> > - - clocks: clock specifier if external clock provided to the controller
> > + - clocks and clock-names: clock specifier if external clocks are provided
> > +   - "txco": external reference clock
> > +   - "extclk": deprecated, replaced by "txco"
> > +   - "lpo": external low power 32.768 kHz clock
> >   - clock-names: should be "extclk"
>
> This line should change?

Yes. Missed that.

>
> 'clocks' needs to describe how many clocks and the order of them.
>
> 'clock-names' needs to list the names. Keep them separate.

I was under the impression that when clock-names was used, the
order of clocks shouldn't matter.

Also, both clocks are optional. The controller can use a standalone
crystal instead of an external TXCO, which would not get described in
the device tree, and/or not use an LPO clock. How would one describe
a device that has an LPO clock input but not a TXCO clock input?

Last, IMHO listing them with name + description, one item per line
is more readable then having the items on one line, then having the
next line list all their respective names. If ordering and number of
items is important, I could add the requirements to the description
of "clocks and clock-names"?

Thanks
ChenYu
