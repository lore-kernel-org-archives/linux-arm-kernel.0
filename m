From: julian.calaby@gmail.com (Julian Calaby)
Date: Wed, 31 Oct 2018 20:15:52 +1100
Subject: [linux-sunxi] Re: [PATCH v3 17/25] dt-bindings: panel: Add
 Bananapi S070WV20-CT16 ICN6211 MIPI-DSI to RGB bridge
In-Reply-To: <CAGb2v66ENhmNXPz4PfdRJjNUNdpDNZYX2a3SH8AD6SMe9g2zLA@mail.gmail.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <CGME20181029111305epcas5p2ee0ca644470de4e036762e000afbb71b@epcas5p2.samsung.com>
 <20181026144344.27778-18-jagan@amarulasolutions.com>
 <3c4c8a08-8c1e-1ac6-2b53-81389d69c97b@samsung.com>
 <CAGb2v66ENhmNXPz4PfdRJjNUNdpDNZYX2a3SH8AD6SMe9g2zLA@mail.gmail.com>
Message-ID: <CAGRGNgWUpaG6W92CDBy7XCun10-TnPggTgY=iZ_4dg4E1cM7ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jagan,

On Wed, Oct 31, 2018 at 7:58 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Wed, Oct 31, 2018 at 4:53 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> >
> > On 26.10.2018 16:43, Jagan Teki wrote:
> > > Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB
> > > bridge panel, which is available on same PCB with 24-bit RGB interface.
> > >
> > > So, this patch adds DSI specific binding details on existing
> > > dt-bindings file.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v3:
> > > - Use existing binding doc and update dsi details
> > > Changes for v2:
> > > - none
> > >
> > >  .../display/panel/bananapi,s070wv20-ct16.txt  | 31 +++++++++++++++++--
> > >  1 file changed, 29 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> > > index 35bc0c839f49..b7855dc7c66f 100644
> > > --- a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> > > +++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> > > @@ -1,12 +1,39 @@
> > >  Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
> > >
> > > +S070WV20-CT16 is 7" 800x480 panel connected through a 24-bit RGB interface.
> > > +
> > > +Depending on the variant, the PCB attached to the panel module either
> > > +supports DSI, or DSI + 24-bit RGB. DSI is converted to 24-bit RGB via
> > > +an onboard ICN6211 MIPI DSI - RGB bridge chip, then fed to the panel
> > > +itself
> >
> > As I understand this is display board, which contains 'pure' RGB panel
> > S070WV20-CT16 and optionally ICN6211 DSI->RGB bridge.
> > These are separate devices, just connected by vendor to simplify its
> > assembly. Why don't you create then bridge driver for ICN6211 and RGB
> > panel driver for S070WV20-CT16 - it looks more generic.
> > Then you can describe both in dts and voila.
> > Creating drivers for every combo of devices (panel + bridge), just
> > because some vendor sells them together seems incorrect - we have
> > devicetree for it.
>
> Rob suggested this, and also the opposite: using the same
> "bananapi,s070wv20-ct16"
> compatible string for both types of connections, and have the driver deal with
> detecting the bus type.
>
> The thing about the bridge chip is that there's no available datasheet that
> describes all the parts of the init sequence, in fact none at all. I managed
> to work out some bits, but the others remain a mystery and must be hard-coded
> to match the panel. That would work against having a generic bridge driver.

To me it seems logical that we'd model it as another step in the graph
between the DSI component and the panel. It's conceivable that some
other manufacturer will probably buy these for their panels and having
a somewhat generic driver seems vaguely future proof to me.

As I see it, the weird init process belongs to the bridge chip and the
timings belong to the panel and we shouldn't "confuse" them by giving
them the same compatible.

That said, I'm sure that these chips are already old hat and we'll
have something different and even more incomprehensible next week.

Thanks,

--
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
