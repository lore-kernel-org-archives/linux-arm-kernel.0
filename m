From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 25 Jul 2017 17:48:30 -0700
Subject: [PATCH 3/3] dt-bindings: clock: amlogic,gxbb-aoclkc: Update
 bindings
In-Reply-To: <1500897650.2401.1.camel@baylibre.com>
References: <1499336663-23875-1-git-send-email-narmstrong@baylibre.com>
 <1499336663-23875-4-git-send-email-narmstrong@baylibre.com>
 <20170710035031.rdbi64ookkbq6zeo@rob-hp-laptop>
 <20170721204439.GJ19878@codeaurora.org>
 <1a971e80-1f91-c446-7e28-d193354b2859@baylibre.com>
 <1500897650.2401.1.camel@baylibre.com>
Message-ID: <20170726004830.GI2146@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24, Jerome Brunet wrote:
> On Mon, 2017-07-24 at 13:47 +0200, Neil Armstrong wrote:
> > 
> > Hi Rob, Stephen,
> > 
> > Thanks for your feedback, but on these Amlogic platforms, the AO register bank
> > is
> > filled with interleaved registers used for various purposes.
> > 
> > For instance, the first 1k of registers are :
> > 
> > 0-c RTI_STATUS
> > c-14 RTI_PWR_CNTL
> > 14-1c PIN_MUX
> > 1c RTI_STATUS
> > 24-30 GPIO
> > 30 JTAG_CONFIG
> > 34 WD
> > 38-40 CPU_CTRL
> > 40 RTI_GEN_CTRL
> > 44 CPU_CTRL
> > 4c-58 TIMER
> > 58 OSCIN
> > 60 AHB2DDR
> > ...
> > 
> > 
> > And so on, and the clock related registers are split among this space.
> > 
> > For sure, this could be declared as an system controller node, but this would
> > imply completely
> > re-designing the actual clock driver and drop the actual bindings.
> > (and with re-writting the clock gate code to use regmap registers access)

I'm not suggesting a sycon node or binding usage here. There's an
"always on" hw block here that could be implemented as an MFD
driver that binds and creates a clk subdevice and whatever else
is sitting in here. Those subdevices could be informed of the
register base by knowing their parent driver is an MFD with a
certain driver data structure inside and then get at an __iomem
pointer through the parent's driver data. Or they could use a
regmap approach and rewrite a bunch of code. Or there could be
just a clk driver that binds to this node for now until a later
time that other features are needed.

> 
> Maybe it is time to investigate having the regmap clock from qcom available to
> every other platform ?

I think we have regmap clk duplicated a couple times in the
drivers/clk/ directory now. Not sure how this is related, except
for that there looks to be a desire to use a syscon binding here
and that forces regmap on drivers?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
