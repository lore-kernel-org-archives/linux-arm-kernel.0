From: ramesh.shanmugasundaram@bp.renesas.com (Ramesh Shanmugasundaram)
Date: Fri, 26 Feb 2016 15:00:35 +0000
Subject: [PATCH] arm64: dts: r8a7795: Add CAN external clock support
In-Reply-To: <CAMuHMdXJRN2kF2r=bqcY8v87aYHj_OKr2=5vzcfoHwvr02Y2CA@mail.gmail.com>
References: <1456496023-16240-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <CAMuHMdXJRN2kF2r=bqcY8v87aYHj_OKr2=5vzcfoHwvr02Y2CA@mail.gmail.com>
Message-ID: <SG2PR06MB1038B995B4C12A01C280DFC4C3A70@SG2PR06MB1038.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

> On Fri, Feb 26, 2016 at 3:13 PM, Ramesh Shanmugasundaram
> <ramesh.shanmugasundaram@bp.renesas.com> wrote:
> > Adds external CAN clock node for r8a7795. This clock can be used as
> > fCAN clock of CAN and CAN FD controller.
> >
> > Signed-off-by: Ramesh Shanmugasundaram
> > <ramesh.shanmugasundaram@bp.renesas.com>
> > ---
> >  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > index a7315eb..5167a6c 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > @@ -115,6 +115,13 @@
> >                 clock-frequency = <0>;
> >         };
> >
> > +       /* External CAN clock - to be overridden by boards that provide
> it */
> > +       can_clk: can {
> > +               compatible = "fixed-clock";
> > +               #clock-cells = <0>;
> > +               clock-frequency = <0>;
> 
> As this is an optional clock, it should have
> 
>         status = "disabled";

Yes, I too thought the same but the status property is not obeyed. The "disabled" clock still shows up in clk_tree and clk_xxx apis works just fine (Is this a DT bug?). Hence left the ambiguous "status". In code I use clk_get_rate(can_clk) != 0 to see if it's enabled, which seems logical.

If you add this as a child of soc node, status property is obeyed. But all external clocks are defined outside soc (correctly) and I followed the same.

Thanks,
Ramesh

Note: tests based on next-20160127
