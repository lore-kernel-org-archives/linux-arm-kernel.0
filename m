From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 10 Jan 2017 20:58:10 +0100
Subject: [PATCH v4 1/2] arm64: dts: rockchip: add "rockchip,
 grf" property for RK3399 PMUCRU/CRU
In-Reply-To: <8683375.pL9J7LxuT0@diego>
References: <1484028930-20305-1-git-send-email-zhengxing@rock-chips.com>
 <CAD=FV=Wwu3q_LqwYUWcJQRvp5neVOS9szgsYFONWTRJ0X8hRTA@mail.gmail.com>
 <8683375.pL9J7LxuT0@diego>
Message-ID: <1523574.hS8CXi1tTP@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

Am Dienstag, 10. Januar 2017, 20:46:12 schrieb Heiko St?bner:
> Am Dienstag, 10. Januar 2017, 10:45:48 schrieb Doug Anderson:
> > Hi,
> > 
> > On Mon, Jan 9, 2017 at 10:15 PM, Xing Zheng <zhengxing@rock-chips.com>
> 
> wrote:
> > > The structure rockchip_clk_provider needs to refer the GRF regmap
> > > in somewhere, if the CRU node has not "rockchip,grf" property,
> > > calling syscon_regmap_lookup_by_phandle will return an invalid GRF
> > > regmap, and the MUXGRF type clock will be not supported.
> > > 
> > > Therefore, we need to add them.
> > > 
> > > Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> > > ---
> > > 
> > > Changes in v4:
> > > - separte the binding patch
> > > 
> > > Changes in v3:
> > > - add optional roperty rockchip,grf in rockchip,rk3399-cru.txt
> > > 
> > > Changes in v2:
> > > - referring pmugrf for PMUGRU
> > > - fix the typo "invaild" in COMMIT message
> > > 
> > >  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 ++
> > >  1 file changed, 2 insertions(+)
> > 
> > This seems fine to me, so:
> > 
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > 
> > ...but I will say that before you actually add any real "MUXGRF"
> > clocks on rk3399 you _might_ need to rework the code to make things
> > truly "optional".  If it turns out that any existing clocks that
> > already exist today already go through one of these muxes in the GRF
> > and we've always been assuming one setting of the mux, we'll need to
> > make sure we keep assuming that setting of the mux even if the "grf"
> > isn't specified.
> 
> I guess I see that a bit more relaxed :-) .
> 
> I.e. the GRF being optional is a remnant of syscons not being available when
> the clocks get set up- so were coming in later or not at all. For the
> rk3288 I converted, there we never really had the case of the GRF missing.
> 
> And the GRF mux for the vcodec now present is not being used by anything yet
> (neither driver nor binding), so no old devicetree can break.
> 
> > As I understand it, your motivation for this patch is to eventually be
> > able to model the EDP reference clock which can either be xin24 or
> > "edp osc".  Presumably the eDP "reference clock" isn't related to any
> > of the pre-existing eDP clocks so that one should be safe.
> 
> Same here, so far we don't even have edp or even any other graphical output
> on the rk3399, so again there is no old devicetree that could break when
> the grf is not specified.

reading all of the above again, it feels like you essentially also said 
similar things already in your original reply and I misread some of it.

But again, I don't see the need for any more code right now, as hopefully the 
simple stuff we currently only support does not have any grf-based muxes in 
it. Xing + Rockchip people, please correct me if I'm wrong here :-)


Heiko
