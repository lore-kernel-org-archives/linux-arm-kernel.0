From: b20788@freescale.com (Anson Huang)
Date: Thu, 11 Sep 2014 11:29:39 +0800
Subject: [PATCH V3 0/3] move gpt per clk parent from ipg_per to OSC
Message-ID: <1410406182-21113-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, gpt timer's clock is from ipg_per, and ipg_per clock is
from ipg on most of i.MX6 series SOCs, but ipg's rate may be scaled
when system enters low bus mode for saving power, then gpt timer's
clock rate will be scaled as well, as system timer should be kept
stable and NOT drift, better to keep gpt timer's clk at fixed rate,
on i.MX6Q TO > 1.0, i.MX6DL and i.MX6SX, there is OSC clk available
for gpt timer, we should enable this feature, the hardware design is
as below:

i.MX6Q TO > 1.0: GPT_CR_CLKSRC, b'101 selects fix clock
    of OSC / 8 for gpt per clk;
i.MX6DL and i.MX6SX: GPT_CR_CLKSRC, b'101 selects OSC
    for gpt per clk, and we must enable GPT_CR_24MEM to
    enable OSC clk source for gpt per, GPT_PR_PRESCALER24M
    is for pre-scaling of this OSC clk, here set it to 8
    to make gpt per clk is 3MHz;
i.MX6SL: ipg_per can be from OSC directly, so no need to
    implement this new clk source for gpt per.

As we still need to make it work on i.MX6Q TO1.0 which has no OSC
clock source for gpt per, so we add a soc_per clock for i.MX6Q,
other SoCs all have OSC clock source available for gpt per, so we
can just replace the original gpt per clk with gpt_3m clock.

Anson Huang (3):
  ARM: imx: add gpt_3m clk for i.mx6qdl
  ARM: dts: imx6: make gpt per clock can be from OSC
  ARM: imx: source gpt per clk from OSC for system timer

 arch/arm/boot/dts/imx6qdl.dtsi            |    5 +++--
 arch/arm/boot/dts/imx6sx.dtsi             |    2 +-
 arch/arm/mach-imx/clk-imx6q.c             |    4 ++++
 arch/arm/mach-imx/time.c                  |   31 ++++++++++++++++++++++++-----
 include/dt-bindings/clock/imx6qdl-clock.h |    3 ++-
 5 files changed, 36 insertions(+), 9 deletions(-)

-- 
1.7.9.5
