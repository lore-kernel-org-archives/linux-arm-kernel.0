From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 13 Sep 2016 13:41:44 -0700
Subject: [PATCH v4 22/22] phy: Add support for Qualcomm's USB HS phy
In-Reply-To: <20160913070358.GB30425@b29397-desktop>
References: <20160907213519.27340-1-stephen.boyd@linaro.org>
 <20160907213519.27340-23-stephen.boyd@linaro.org>
 <20160913070358.GB30425@b29397-desktop>
Message-ID: <147379930484.27460.3849356366746983941@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Chen (2016-09-13 00:03:58)
> On Wed, Sep 07, 2016 at 02:35:19PM -0700, Stephen Boyd wrote:
> > The high-speed phy on qcom SoCs is controlled via the ULPI
> > viewport.
> > 
> 
> Hi Stephen, I am a little puzzled how this driver co-work with chipidea
> driver. According to nxp IC guys, the ULPI PHY's clock needs to be enabled
> before access portsc.pts (calling hw_phymode_configure), otherwise,
> the system will hang. But I find you call hw_phymode_configure before
> phy->power_on, doesn't your design have this requirement?

Which clk needs to be enabled? The xcvr_clk? I believe that clk
corresponds to the "core" clk that we enable in the msm glue driver
layer. When that clk is enabled, the ULPI phy is able to respond to
register read/writes via the ULPI viewport.

>        
> Besides, you read ulpi id before phy->power_on, how can read work before
> phy power on?
> 

I've found that even having the link clk enabled before phy->power_on
doesn't mean it's possible to read the id registers though. That's
because there can be other power supplies, like regulators, which need
to be on for the phy to operate properly.

Either way, the system does not hang.
