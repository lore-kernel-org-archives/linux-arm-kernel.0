From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon, 30 Jun 2014 09:56:32 -0700
Subject: [PATCH 0/4] Introduce clk_find_nearest_rate()
Message-ID: <1404147396-8041-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Zynq I encountered issues due to rounding here and there. Often the
issue would have been resolved by rounding towards the requested
frequency. Unfortunately, the CCF does not specify  the behavior of
clk_round_rate() in terms of rounding, making this proposed API
call useful for certain use-cases.

An RFC of this series has been discussed here:
https://lkml.org/lkml/2014/5/14/694

Mike: IIRC, you wanted to fix the return type of __clk_round_rate(). Do
you have any patches for that already? I couldn't find anything in
clk-next.

Patch 1 adds the new API call.
2 and 3 apply the new API.
And 4 is a minor fixup of the Zynq DT. The frequencies in the Zynq OPPs
had been specified taking this rounding issues into account, which
is no longer required with this patchset.

	Thanks,
	S?ren


Soren Brinkmann (4):
  clk: Introduce 'clk_find_nearest_rate()'
  cpufreq: cpu0: Use clk_find_nearest_rate()
  net: macb: Use clk_find_nearest_rate() API
  ARM: zynq: dt: Use properly rounded frequencies in OPPs

 arch/arm/boot/dts/zynq-7000.dtsi    |  4 +--
 drivers/clk/clk.c                   | 57 +++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-cpu0.c      |  3 +-
 drivers/net/ethernet/cadence/macb.c |  2 +-
 include/linux/clk.h                 |  9 ++++++
 5 files changed, 71 insertions(+), 4 deletions(-)

-- 
2.0.1.1.gfbfc394
