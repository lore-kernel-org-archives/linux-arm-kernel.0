From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 16 Nov 2018 19:23:53 +0100
Subject: [PATCH] arm64: dts: rockchip: rk3399: Add xin32k clk
In-Reply-To: <CAGAzgsq7uF=E3dzhyCjK4gq09_UV_aZhQbyaTnz7yDY_ErQYKQ@mail.gmail.com>
References: <20181116051719.23376-1-dbasehore@chromium.org>
 <CAD=FV=W7sYY5n609erPpTxux+0Efad_0YpPkoVZB14Kqm=baXA@mail.gmail.com>
 <CAGAzgsq7uF=E3dzhyCjK4gq09_UV_aZhQbyaTnz7yDY_ErQYKQ@mail.gmail.com>
Message-ID: <1698950.cgYuLubFel@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Derek,

Am Freitag, 16. November 2018, 18:39:09 CET schrieb dbasehore .:
> On Fri, Nov 16, 2018 at 8:01 AM Doug Anderson <dianders@chromium.org> wrote:
> > Hi,
> > 
> > On Thu, Nov 15, 2018 at 9:17 PM Derek Basehore <dbasehore@chromium.org> wrote:
> > > This adds the xin32k clock to the RK3399 CPU. Even though it's not
> > > directly used, muxes will end up traversing the entire clk tree on
> > > calls to determine_rate if it doesn't exist.
> > > 
> > > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > > ---
> > > 
> > >  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > 
> > nit: I would have expected ${SUBJECT} to have v2 in it somewhere.
> > 
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > b/arch/arm64/boot/dts/rockchip/rk3399.dtsi index
> > > 99e7f65c1779..3d09472978f8 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > 
> > Aww crud.  I was at the airport yesterday and so I didn't notice that
> > you were touching rk3399, not rk3399-gru.  This belongs in the gru
> > device tree file, not in the top level rk3399.  As you have written
> 
> > this it will break rk3399 boards that have an rk808 on them, AKA:
> Should this be moved to the rk3399.dtsi file? The RK3399 assumes that
> this clk exists (same as the 24MHz clk which is in rk3399.dtsi). While
> it can function without it defined, it really shouldn't. We can just
> assign the existing labels in the dts files you pointed out.

Right now this patch puts your clock into the rk3399.dtsi, which is the
wrong place. On most Rockchip systems, the xin32k clock is created
by the pmic (rk808 in a lot of cases) and the clock-tree gets amended
once the pmic has probed. See for example [0].

While I don't know where your xin32k really comes from (cros-ec maybe)
it is definitly a board-specific source for the clock and should thus
live in the rk3399-gru.dtsi.

And we really expect each board to actually make sure its xin32k is
properly defined as for example on the rk808 and act8846 pmics it could
also very well be turned off at boot and also does support multiple rates,
thus needing proper clock handling.


Heiko

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi#n159
