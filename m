From: briannorris@chromium.org (Brian Norris)
Date: Wed, 8 Mar 2017 19:10:50 -0800
Subject: [PATCH 3/4] phy: rockchip-typec: support DP phy switch
In-Reply-To: <11032198.PxydffNNDT@diego>
References: <1486712654-15431-1-git-send-email-zyw@rock-chips.com>
 <1486712654-15431-4-git-send-email-zyw@rock-chips.com>
 <20170309003921.GA101174@google.com> <11032198.PxydffNNDT@diego>
Message-ID: <20170309031049.GA122422@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 09, 2017 at 02:02:54AM +0100, Heiko Stuebner wrote:
> Am Mittwoch, 8. M?rz 2017, 16:39:23 CET schrieb Brian Norris:
> > On Fri, Feb 10, 2017 at 03:44:13PM +0800, Chris Zhong wrote:
> > > There are 2 Type-c PHYs in RK3399, but only one DP controller. Hence
> > > only one PHY can connect to DP controller at one time, the other should
> > > be disconnected. The GRF_SOC_CON26 register has a switch bit to do it,
> > > set this bit means enable PHY 1, clear this bit means enable PHY 0.
> > > 
> > > Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> > > ---
> > > 
> > >  drivers/phy/phy-rockchip-typec.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/phy/phy-rockchip-typec.c
> > > b/drivers/phy/phy-rockchip-typec.c index 7cfb0f8..1604aaa 100644
> > > --- a/drivers/phy/phy-rockchip-typec.c
> > > +++ b/drivers/phy/phy-rockchip-typec.c

...

> > > @@ -869,6 +873,11 @@ static int tcphy_parse_dt(struct rockchip_typec_phy
> > > *tcphy,> 
> > >  	if (ret)
> > >  	
> > >  		return ret;
> > > 
> > > +	ret = tcphy_get_param(dev, &cfg->uphy_dp_sel,
> > > +			      "rockchip,uphy-dp-sel");
> > > +	if (ret)
> > > +		return ret;
> > 
> > What about existing device trees? You're essentially adding this
> > new property and requiring it at the same time.
> > 
> > Or are we considering no RK3399 DP stable at the moment? I guess we
> > haven't actually merged any device trees that support this yet, no?
> 
> An interesting situation we're in here. On the one hand, you're right this 
> breaks "backwards compatiblity".
> 
> But on the other hand, the type-c phy is currently very much unused. The only 
> current board rk3399-evb.dts does not enable them (so they're disabled 
> everywhere) and we have neither dwc3 nor dp nodes in any rk3399 devicetrees so 
> far. Also Rob was ok with the binding change :-) .
> 
> So from my pov, I'd say it _should_ be ok, as nothing is using the phys at all 
> yet and thus there is nothing that could get broken.

Yeah, I guess it's OK... but BTW out-of-tree DTs are perfectly
legit, once the bindings are accepted.

Another random point of contention (not worth too much, as the pattern
is already set), but why do these deserve DT properties at all? The
device already has a "rk3399" compatible property, so can't we derive
GRF offsets from that?

Brian
