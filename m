From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 13 Sep 2016 23:29:12 -0700
Subject: [PATCH v4 22/22] phy: Add support for Qualcomm's USB HS phy
In-Reply-To: <20160914021133.GB30760@b29397-desktop>
References: <20160907213519.27340-1-stephen.boyd@linaro.org>
 <20160907213519.27340-23-stephen.boyd@linaro.org>
 <20160913070358.GB30425@b29397-desktop>
 <147379930484.27460.3849356366746983941@sboyd-linaro>
 <20160914021133.GB30760@b29397-desktop>
Message-ID: <147383455256.1541.16582625295760921275@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Chen (2016-09-13 19:11:33)
> On Tue, Sep 13, 2016 at 01:41:44PM -0700, Stephen Boyd wrote:
> > Quoting Peter Chen (2016-09-13 00:03:58)
> > > On Wed, Sep 07, 2016 at 02:35:19PM -0700, Stephen Boyd wrote:
> > > > The high-speed phy on qcom SoCs is controlled via the ULPI
> > > > viewport.
> > > > 
> > > 
> > > Hi Stephen, I am a little puzzled how this driver co-work with chipidea
> > > driver. According to nxp IC guys, the ULPI PHY's clock needs to be enabled
> > > before access portsc.pts (calling hw_phymode_configure), otherwise,
> > > the system will hang. But I find you call hw_phymode_configure before
> > > phy->power_on, doesn't your design have this requirement?
> > 
> > Which clk needs to be enabled? The xcvr_clk? I believe that clk
> > corresponds to the "core" clk that we enable in the msm glue driver
> > layer. When that clk is enabled, the ULPI phy is able to respond to
> > register read/writes via the ULPI viewport.
> > 
> 
> The input clock for ULPI PHY, maybe it is ref_clk at this PHY driver, 
> so in your platform, even PHY clock is gated, you can still access
> portsc.pts to configure PHY mode at controller register?

There are a couple input clocks for this phy. I'm not sure which one the
nxp IC guys think needs to be enabled. Typically, the ref_clk is always
on so it's hard for me to test a scenario where it isn't enabled. But
I'm not sure that the ref_clk is what we're talking about anyway. Would
you know the frequency perhaps? The ref_clk is usually 19.2MHz on these
SoCs. That would match up with the "crystal input" pin in the ULPI
spec[1].

Do you know if this is documented anywhere in the chipidea manual?
I'll have to look again and see if there's something in there, but I
didn't see anything like this.

I would guess that we're talking about the xcvr clock though, because
from what I see in the manual, this is used to clock the interface
between the ULPI phy and the controller. In the ULPI spec, this matches
up with the "clock" signal for the ULPI phy and that usually runs at
something >= 60MHz. 

> 
> > >        
> > > Besides, you read ulpi id before phy->power_on, how can read work before
> > > phy power on?
> > > 
> > 
> > I've found that even having the link clk enabled before phy->power_on
> > doesn't mean it's possible to read the id registers though. That's
> > because there can be other power supplies, like regulators, which need
> > to be on for the phy to operate properly.
> > 
> 
> Then I am puzzled the current initialization for your case, in my mind,
> it should like below:
> 
> qcom_usb_hs_phy_probe->qcom_usb_hs_phy_power_on->ci_ulpi_init
> 
> Like other PHYs, it should get PHY first, then power on it, after that,
> you can access its register.
> 

Hmm.. maybe the confusion is in which registers we should be able to
access? Are we talking about the ULPI viewport MMIO register space or
the ULPI registers that we access through the viewport? I have a
hw_phymode_configure() inside of of ci_ulpi_init() so that the
identification registers through the ULPI viewport read properly
(assuming there aren't other power requirements like regulators). If we
don't set the portsc.pts before using the viewport, the viewport doesn't
work and reads timeout. So we really don't touch the ULPI registers
except for the scratch space and the id registers until after the phy is
properly powered on with clks and regulators, because the only place we
touch them after doing the id checking is in this phy driver in
qcom_usb_hs_phy_power_on(). We've "solved" the chicken-egg problem where
we don't know which device driver to probe because the phy needs to be
powered on to read the id registers to know which device driver to use
by using DT to match up device drivers instead.

[1] https://www.sparkfun.com/datasheets/Components/SMD/ULPI_v1_1.pdf
