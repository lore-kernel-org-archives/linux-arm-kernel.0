From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 12 Jan 2017 02:28:02 +0100
Subject: [PATCH v4 1/2] arm64: dts: rockchip: add "rockchip,
 grf" property for RK3399 PMUCRU/CRU
In-Reply-To: <CAD=FV=WMQ22G67YoQx2t7J6_ZuB3sUjVjXh-0KhPEO_6zbiyUQ@mail.gmail.com>
References: <1484028930-20305-1-git-send-email-zhengxing@rock-chips.com>
 <1523574.hS8CXi1tTP@diego>
 <CAD=FV=WMQ22G67YoQx2t7J6_ZuB3sUjVjXh-0KhPEO_6zbiyUQ@mail.gmail.com>
Message-ID: <1637274.yXLKltLVD2@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 11. Januar 2017, 16:50:10 CET schrieb Doug Anderson:
> Hi,
> 
> On Tue, Jan 10, 2017 at 11:58 AM, Heiko St?bner <heiko@sntech.de> wrote:
> > Hi Doug,
> > 
> > Am Dienstag, 10. Januar 2017, 20:46:12 schrieb Heiko St?bner:
> >> Am Dienstag, 10. Januar 2017, 10:45:48 schrieb Doug Anderson:
> >> > Hi,
> >> > 
> >> > On Mon, Jan 9, 2017 at 10:15 PM, Xing Zheng <zhengxing@rock-chips.com>
> >> 
> >> wrote:
> >> > > The structure rockchip_clk_provider needs to refer the GRF regmap
> >> > > in somewhere, if the CRU node has not "rockchip,grf" property,
> >> > > calling syscon_regmap_lookup_by_phandle will return an invalid GRF
> >> > > regmap, and the MUXGRF type clock will be not supported.
> >> > > 
> >> > > Therefore, we need to add them.
> >> > > 
> >> > > Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> >> > > ---
> >> > > 
> >> > > Changes in v4:
> >> > > - separte the binding patch
> >> > > 
> >> > > Changes in v3:
> >> > > - add optional roperty rockchip,grf in rockchip,rk3399-cru.txt
> >> > > 
> >> > > Changes in v2:
> >> > > - referring pmugrf for PMUGRU
> >> > > - fix the typo "invaild" in COMMIT message
> >> > > 
> >> > >  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 ++
> >> > >  1 file changed, 2 insertions(+)
> >> > 
> >> > This seems fine to me, so:
> >> > 
> >> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >> > 
> >> > ...but I will say that before you actually add any real "MUXGRF"
> >> > clocks on rk3399 you _might_ need to rework the code to make things
> >> > truly "optional".  If it turns out that any existing clocks that
> >> > already exist today already go through one of these muxes in the GRF
> >> > and we've always been assuming one setting of the mux, we'll need to
> >> > make sure we keep assuming that setting of the mux even if the "grf"
> >> > isn't specified.
> >> 
> >> I guess I see that a bit more relaxed :-) .
> >> 
> >> I.e. the GRF being optional is a remnant of syscons not being available
> >> when the clocks get set up- so were coming in later or not at all. For
> >> the rk3288 I converted, there we never really had the case of the GRF
> >> missing.
> >> 
> >> And the GRF mux for the vcodec now present is not being used by anything
> >> yet (neither driver nor binding), so no old devicetree can break.
> >> 
> >> > As I understand it, your motivation for this patch is to eventually be
> >> > able to model the EDP reference clock which can either be xin24 or
> >> > "edp osc".  Presumably the eDP "reference clock" isn't related to any
> >> > of the pre-existing eDP clocks so that one should be safe.
> >> 
> >> Same here, so far we don't even have edp or even any other graphical
> >> output
> >> on the rk3399, so again there is no old devicetree that could break when
> >> the grf is not specified.
> > 
> > reading all of the above again, it feels like you essentially also said
> > similar things already in your original reply and I misread some of it.
> > 
> > But again, I don't see the need for any more code right now, as hopefully
> > the simple stuff we currently only support does not have any grf-based
> > muxes in it. Xing + Rockchip people, please correct me if I'm wrong here
> > :-)
> Right.  I have no objection to Xing's patch.  I just want to make sure
> that if it's listed as "Optional" that it's really optional.
> 
> I was worried that we would introduce some GRF-based mux in the
> _middle_ of some existing clock tree because we simply didn't model
> the mux before and assumed one particular setting.  If nothing like
> that ever happens then we're fine.

Thankfully the clock diagrams on the old socs were pretty verbose, listing all
grf-based clocks as well. For example the rk3288 seems to have two and it
seems I've been carrying dummy definitions for those from the time I did the
initial clock tree [0].

And thankfully grf-based clocks somehow always only get used for more
"esotheric" components like vcodec and iep on the rk3288 :-) .


Heiko

[0] https://github.com/mmind/linux-rockchip/blob/devel/workbench/drivers/clk/rockchip/clk-rk3288.c
lines 371 and 799 .. looks like I'll need to add the iep clock as well
at some point.
