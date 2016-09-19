From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 19 Sep 2016 05:42:17 +0300
Subject: [PATCH 0/2] ARM: imx31/of: clk: init clock controller with
 CLK_OF_DECLARE
Message-ID: <1474252939-12579-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change is based on v4.8.0-rc1 and plus it depends on this fixup:

  ARM: dts: imx31: fix clock control module interrupts description

The change is tested on qemu kzm target and mx31lite board, while both
targets don't have DTS in upstream, I had to write simple DTS files for
them, because the proposed change is for i.MX31 targets with OF support.

The second change in the series compilation time dependent on the first
one, while the first change apparently should break runtime execution
of i.MX31 boards with OF support, if both changes are applied everything
should be fine, regression testing on the same legacy targets does not
show any problems. Moreover i.MX31/OF/clock initialization seems to be
broken currently, if the change is not applied I can not get a working
clock source during early boot stage, jiffies are not incremented, but
because I didn't check the problem thoroughly (can it be caused by
missing CLK_OF_DECLARE? Or caused by something fixed by the change
http://www.spinics.net/lists/linux-clk/msg12235.html ?) and because
the change was tested against code which is not found in upstream,
I won't call this change as a fix, however its application is apparently
wanted to get better OF support for i.MX31 targets.

Vladimir Zapolskiy (2):
  ARM: imx31: remove mx31_clocks_init_dt() function calls
  clk: imx31: properly init clocks for machines with DT

 arch/arm/mach-imx/common.h   |  1 -
 arch/arm/mach-imx/imx31-dt.c |  6 ------
 drivers/clk/imx/clk-imx31.c  | 49 ++++++++++++++++++++++----------------------
 3 files changed, 25 insertions(+), 31 deletions(-)

-- 
2.8.1
