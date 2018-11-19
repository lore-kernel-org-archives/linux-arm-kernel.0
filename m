From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 19 Nov 2018 10:41:47 +0100
Subject: [PATCH] arm64: dts: rockchip: rk3399: Add xin32k clk
In-Reply-To: <CAD=FV=XVDAjLt+VtxedHEma1FRrG0LuFZ2c7L5-MsdCZkgEcsw@mail.gmail.com>
References: <20181116051719.23376-1-dbasehore@chromium.org>
 <CAGAzgsq7uF=E3dzhyCjK4gq09_UV_aZhQbyaTnz7yDY_ErQYKQ@mail.gmail.com>
 <CAD=FV=XVDAjLt+VtxedHEma1FRrG0LuFZ2c7L5-MsdCZkgEcsw@mail.gmail.com>
Message-ID: <11718017.ngvMPIPJQJ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 16. November 2018, 19:23:59 CET schrieb Doug Anderson:
> Hi,
> 
> On Fri, Nov 16, 2018 at 9:39 AM dbasehore . <dbasehore@chromium.org> wrote:
> > On Fri, Nov 16, 2018 at 8:01 AM Doug Anderson <dianders@chromium.org> 
wrote:
> > > Hi,
> > > 
> > > On Thu, Nov 15, 2018 at 9:17 PM Derek Basehore <dbasehore@chromium.org> 
wrote:
> > > > This adds the xin32k clock to the RK3399 CPU. Even though it's not
> > > > directly used, muxes will end up traversing the entire clk tree on
> > > > calls to determine_rate if it doesn't exist.
> > > > 
> > > > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > > > ---
> > > > 
> > > >  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > 
> > > nit: I would have expected ${SUBJECT} to have v2 in it somewhere.
> > > 
> > > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > > b/arch/arm64/boot/dts/rockchip/rk3399.dtsi index
> > > > 99e7f65c1779..3d09472978f8 100644
> > > > --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > > +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > 
> > > Aww crud.  I was at the airport yesterday and so I didn't notice that
> > > you were touching rk3399, not rk3399-gru.  This belongs in the gru
> > > device tree file, not in the top level rk3399.  As you have written
> > 
> > > this it will break rk3399 boards that have an rk808 on them, AKA:
> > Should this be moved to the rk3399.dtsi file? The RK3399 assumes that
> > this clk exists (same as the 24MHz clk which is in rk3399.dtsi). While
> > it can function without it defined, it really shouldn't. We can just
> > assign the existing labels in the dts files you pointed out.
> 
> No, it should be in the board files.  Each board may produce the 32k
> clock through a different component.  On gru-based devices we produce
> the 32k clock through a silego part.

That would also be a great part of the commit message, like
"...on Gru boards the 32kHz clock gets produced by a Silego oscillator"
or so when you move it over to rk3399-gru.dtsi .


> Technically you could say that we don't _truly_ need to model this
> clock and we could have just inserted a dummy/fixed 32k clock in the
> clk-rk3399.c file.  ...but we did model it so that means we should
> probably model it semi-properly.
>
> If a given board forgets to provide a 32k clock then that's a bug for
> them like it was for us.

Yep and as I said in my other mail, on these pmic generated clocks
the clock generation often even is configurable (rate, on/off), so it
should really be a real clock not some hack ;-) .


Heiko
