From: hzpeterchen@gmail.com (Peter Chen)
Date: Thu, 15 Sep 2016 13:29:06 +0800
Subject: [PATCH v4 22/22] phy: Add support for Qualcomm's USB HS phy
In-Reply-To: <147387497029.16543.5921198225528254345@sboyd-linaro>
References: <20160907213519.27340-1-stephen.boyd@linaro.org>
 <20160907213519.27340-23-stephen.boyd@linaro.org>
 <20160913070358.GB30425@b29397-desktop>
 <147379930484.27460.3849356366746983941@sboyd-linaro>
 <20160914021133.GB30760@b29397-desktop>
 <147383455256.1541.16582625295760921275@sboyd-linaro>
 <20160914093307.GC21674@b29397-desktop>
 <147387497029.16543.5921198225528254345@sboyd-linaro>
Message-ID: <20160915052905.GA23958@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 10:42:50AM -0700, Stephen Boyd wrote:
> > > 
> > > Hmm.. maybe the confusion is in which registers we should be able to
> > > access? Are we talking about the ULPI viewport MMIO register space or
> > > the ULPI registers that we access through the viewport? I have a
> > > hw_phymode_configure() inside of of ci_ulpi_init() so that the
> > > identification registers through the ULPI viewport read properly
> > > (assuming there aren't other power requirements like regulators). If we
> > > don't set the portsc.pts before using the viewport, the viewport doesn't
> > > work and reads timeout. So we really don't touch the ULPI registers
> > > except for the scratch space and the id registers until after the phy is
> > > properly powered on with clks and regulators, because the only place we
> > > touch them after doing the id checking is in this phy driver in
> > > qcom_usb_hs_phy_power_on(). We've "solved" the chicken-egg problem where
> > > we don't know which device driver to probe because the phy needs to be
> > > powered on to read the id registers to know which device driver to use
> > > by using DT to match up device drivers instead.
> > > 
> > > [1] https://www.sparkfun.com/datasheets/Components/SMD/ULPI_v1_1.pdf
> > 
> > Ok, ulpi phy works like USB device on USB bus which create device at
> > runtime. So, like some hard-wired USB devices, it may needs power
> > sequence too, otherwise, how it knows which driver can loads.
> > 
> 
> Yes. We use the DT compatible string to ignore any issues with reading
> the device ids when the device is powered off. Unlike USB though, we
> have device drivers for the ULPI PHYs that do the power sequencing along
> with other initializations, so using a common pwrseq layer seems like
> overkill just so we can read the id registers.

If the attempt to read id registers will not hang the system, it can
work. Like the case [1], without PHY ref_clk, it will hang when
configure PHY mode (visit portsc.pts), it has no chance to read id
registers. So, I still think the ULPI bus driver needs to do power
sequence for its children, unless you have some place to open the
ref_clk.

> 
> Are there any concerns with this patch? Or can they be reapplied?

For this patch, it is ok for me.


[1] http://www.spinics.net/lists/linux-usb/msg146336.html
-- 

Best Regards,
Peter Chen
