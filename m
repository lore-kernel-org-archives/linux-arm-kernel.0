From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 20 Apr 2016 17:34:32 +0800
Subject: [RESEND PATCH 0/8] clk: core: support clocks which requires parents on
Message-ID: <1461144880-8724-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a RESEND patch series.
The original one can be found at here:
http://www.spinics.net/lists/arm-kernel/msg435136.html
It has no functional changes but improve the commit message and
comments a bit.

This patch series adds support in clock framework for clocks which all the
operations like gate/ungate, set_rate, set_parent must require its parent
clock on.

This special HW requirement can be found on Freescale i.MX7D platform.
Besides i.MX7D, it seems lpc18xx clock has a similar requirement.
(see: http://www.spinics.net/lists/arm-kernel/msg439307.html)
And there may be other SoCs in the same situation.

Current clock core can not support such type of clock well.

This patch introduce a new flag CLK_SET_PARENT_ON to handle this special
case in clock core that enable its parent clock firstly for each operation
and disable it later after operation complete.

There're two special cases for handling this issue:

One is fixing the possible disabling clocks while its parent is already off
during kernel booting phase in clk_disable_unused_subtree()
Since this state misalign only happens during booting time,
so we simply enable the parent clocks before disable it if flag is set.
For normal clk_disable after kernel booting, there's no such issue
since the clock tree is already created which makes sure no such issue exist.

Another special case is for set_parent() operation.
It requires both parent, old one and new one, to be enabled at the same
time during the operation.

Patch 1~4 does this work.

After clk core supports mx7d type clocks, we don't have to enable all clock
by default anymore, then we remove the enable of all clocks code and instead
only enable set of minimum required clocks.

Patch 5~8 does this work.

The whole patch series is based on for-next branch of clock tree:
git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git

Dong Aisheng (8):
  clk: introduce clk_core_enable_lock and clk_core_disable_lock
    functions
  clk: move clk_disable_unused after clk_core_disable_unprepare function
  clk: core: support clocks which requires parents on (part 1)
  clk: core: support clocks which requires parents on (part 2)
  clk: imx: re-order and concentrate the same type of clk api
  clk: imx: add clk api for supporting clk_OPS_PARENT_ON clocks
  clk: imx7d: using api with flag CLK_OPS_PARENT_ON
  clk: imx7d: only enable minimum required clocks

 drivers/clk/clk.c            | 329 +++++++++++--------
 drivers/clk/imx/clk-imx7d.c  | 732 ++++++++++++++++++++++---------------------
 drivers/clk/imx/clk.h        |  90 ++++--
 include/linux/clk-provider.h |   2 +
 4 files changed, 623 insertions(+), 530 deletions(-)

-- 
1.9.1
