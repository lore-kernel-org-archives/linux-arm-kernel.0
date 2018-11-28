From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 28 Nov 2018 14:45:59 +0100
Subject: [PATCH] arm64: dts: rockchip: Add 32k clk on rk3399-gru
In-Reply-To: <CAD=FV=WJCvt-Ez_F+gTJaLWnOOY2J0fXxgq8vy0ojKoHv+AQ7w@mail.gmail.com>
References: <20181127232331.49628-1-dbasehore@chromium.org>
 <CAD=FV=WJCvt-Ez_F+gTJaLWnOOY2J0fXxgq8vy0ojKoHv+AQ7w@mail.gmail.com>
Message-ID: <6602824.AOVt5XvbUN@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 28. November 2018, 01:42:36 CET schrieb Doug Anderson:
> Hi,
> 
> On Tue, Nov 27, 2018 at 3:23 PM Derek Basehore <dbasehore@chromium.org> 
wrote:
> > This adds the 32k clock to the RK3399 Gru board file. Even though it's
> > not directly used, muxes will end up traversing the entire clk tree on
> > calls to determine_rate if it doesn't exist. This is because the 32k
> > clk is listed as a possible parent on some clks. Since the clk doesn't
> > know about the 32k clk (it was never registered), it triggers a global
> > search for it. This can happen about 40 times per second, which isn't
> > great for power.
> 
> I seem to remember Heiko requesting something be added to the commit
> 
> message.  Ah yes, he said:
> > That would also be a great part of the commit message, like
> > "...on Gru boards the 32kHz clock gets produced by a Silego oscillator"
> > or so when you move it over to rk3399-gru.dtsi .
> 
> Presumably Heiko could add that to the commit message when he applies
> the patch, so maybe wait to see if he wants you to respin it?
> 
> > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > ---
> > 
> >  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi index
> > ca07f6032200..a07aa4c570c0 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> > @@ -14,6 +14,13 @@
> > 
> >                 stdout-path = "serial2:115200n8";
> >         
> >         };
> > 
> > +       ap_rtc_clk: ap-rtc-clk {
> > +               compatible = "fixed-clock";
> > +               clock-frequency = <32768>;
> > +               clock-output-names = "xin32k";
> > +               #clock-cells = <0>;
> > +       };
> > +
> > 
> >         /*
> >         
> >          * Power Tree
> 
> Really this should be below the power tree, AKA right above
> "gpio-keys".  Convention has typically been that only "special" nodes
> like "chosen" go all the way at the top here.  Then the power tree
> (parents first), then other nodes.
> 
> In the Chrome OS tree we had an "/* END REGULATORS */ comment to try
> to separate out the power tree from the rest of the nodes, but I guess
> Heiko didn't like that when this went upstream so now you just have to
> know the convention.  :-P
> 
> Possibly Heiko would re-sort this for you himself when applying the
> change if he agrees with my understanding of the conventions.

We hashed out the dt-conventions somewhat together during veyron
times, so I'd be surprised if we didn't agree on them :-D .

In any case, I've adapted the commit message to add the Silego part,
moved the clock to the correct position and applied the result with
your Reviewed-by for 4.21.


Heiko
