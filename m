From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 13 Apr 2017 10:13:51 +0800
Subject: [PATCH 0/3] clk: sunxi-ng: gate/ungate PLL CPU clk after rate change
Message-ID: <20170413021354.3258-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds a clk notifier for use on the PLL CPU clks found in
Allwinner SoCs. Some people have observed issues with the design and
implementation of the CPU PLL clock, starting from the A31. Changes
to the PLL clock need a few cycles to stabilize. If the changes are
too drastic, the dividers in particular, there is a good chance that
the system will hang.

Previously we thought that reparenting the CPU clock away from the PLL
while changes were made, and then reparenting it back once it was stable,
should have been enough to mitigate the issue. Unfortunately it was
not. With cpufreq support for A33 recently introduced in commit
03749eb88e63 ("ARM: dts: sun8i: add opp-v2 table for A33"), system hangs
were observed one out of two to three boots, right after userspace
configured cpufreq to switch to the ondemand governor. Other experiments
done by Ondrej Jirman [1] show that it is not enough to just reparent
the CPU clock, but the PLL clock's dividers must not be used.

We suspect the divider changes make the PLL unstable to the point that
it can not recover, possibly not providing any output afterwards. We
lack any hard evidence (oscilloscope readings or hardware implementation
details) to fully explain the behavior. However, if the hardware is
stuck in some undesired state, it is possible to "reset" it, by gating
the PLL, then ungating it.

This series adds a new clk notifier that does exactly that. The clk
notifier is registered on the PLL clock. Whenever its rate is changed,
the notifier comes in and toggles the gate. The notifier should always
be the first one registered. And all consumers of the clock must also
have notifiers on it to temporarily reparent away during the change.

Patches 2 and 3 register this new notifier for the CPU PLL clocks on
the A33 and H3, respectively. With the first 2 patches applied, the
cpufreq related system hangs on the A33 go away.

Given that commit 03749eb88e63 ("ARM: dts: sun8i: add opp-v2 table for
A33") is already in v4.11-rc, I suggest we either try to merge the
first 2 patches for a very late -rc fix, or drop A33 cpufreq support
from v4.11, and add it later once this series is merged.

Regards
ChenYu


[1] http://www.spinics.net/lists/arm-kernel/msg552501.html

Chen-Yu Tsai (3):
  clk: sunxi-ng: Add clk notifier to gate then ungate PLL clocks
  clk: sunxi-ng: a33: gate then ungate PLL CPU clk after rate change
  clk: sunxi-ng: h3: gate then ungate PLL CPU clk after rate change

 drivers/clk/sunxi-ng/ccu-sun8i-a33.c | 11 ++++++++
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c  | 11 ++++++++
 drivers/clk/sunxi-ng/ccu_common.c    | 49 ++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_common.h    | 12 +++++++++
 4 files changed, 83 insertions(+)

-- 
2.11.0
