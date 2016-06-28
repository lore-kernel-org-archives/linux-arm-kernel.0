From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 28 Jun 2016 14:58:16 -0700
Subject: [PATCH 20/21] phy: Add support for Qualcomm's USB HSIC phy
In-Reply-To: <57723A21.3060602@baylibre.com>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-21-stephen.boyd@linaro.org>
 <57723A21.3060602@baylibre.com>
Message-ID: <146715109651.31418.4819151138932336863@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Neil Armstrong (2016-06-28 01:49:37)
> On 06/26/2016 09:28 AM, Stephen Boyd wrote:
> > +     uphy->cal_sleep_clk = clk = devm_clk_get(&ulpi->dev, "cal_sleep");
> > +     if (IS_ERR(clk))
> > +             return PTR_ERR(clk);
> 
> Hi Stephen,
> 
> In the bindings the cal_sleep is marked optional, and I think should be since AFAIK
> it's not present on MDM9615 for example.

The cal_sleep clk is just the sleep clk then (should be a board clk in
DT). Sometimes there's a gate in GCC to allow us to turn it off, other
times there isn't. Either way, it's always wired there so I'll update
the binding to say it isn't optional.

> 
> Also MDM9615 HSIC requires "core", "alt-core", "phy", "cal" and "iface" clocks.
> I assume "core" can be attributed to the main chipidea node, but I think "alt-core" and "iface" should be also optionnal.

Looking at the downstream sources I see this:

        "core_clk"     -> usb_hsic_sys_clk
        "iface_clk"    -> usb_hsic_p_clk
        "alt_core_clk" -> usb_hsic_xcvr_clk

        "cal_clk"      -> usb_hsic_hsio_cal_clk
        "phy_clk"      -> usb_hsic_clk

"core_clk" would be the core clk in ci_hdrc_msm. "iface_clk" would be
the iface clk in ci_hdrc_msm. "cal_clk" would be the cal clk in the hsic
phy and "phy_clk" would be the phy clk in the hsic phy.

That leaves alt_core_clk which seems to be a clock that needs to be on
during the reset assert/deassert and possibly for LPM and USB1.1 FS
modes. Sometimes it's referred to as the "housekeeping" clk. Due to the
way resets are done on msm8974 and later SoCs it looks like this clk was
removed. I can make this an optional clk in the ci_hdrc_msm driver, or
we can have two versions of the ci_hdrc_msm compatible string, one for a
device that has the housekeeping clk and one for the device that
doesn't.

> 
> Finally, it misses an optional reset line AFAIK mandatory on MDM9615.
> 

>From what I can tell downstream, all those clks point to the same bit 0
of HSIC_RESET register? So there isn't any phy reset, just the chipidea
controller wrapper reset bit, which should go into the wrapper node?
