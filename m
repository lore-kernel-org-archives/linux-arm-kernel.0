From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  3 Jan 2018 13:18:34 +0100
Subject: [PATCH v4 0/6] clk: renesas: r8a779[56]: Add Z and Z2 clock support
Message-ID: <20180103121840.29316-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

this patch-set adds Z and Z2 clock support.

These are dependencies for supporting CPUFreq. The remainder of that
work is being posted separately and can be found at:

https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/rcar-gen3-cpufreq-v4

Based on v4.15-rc1

Changes since v3:
* Rebase
* Divide parent clock by 2 to give correct rate (again)                         * Take care not to overflow multiplication on 32 but platforms
* Use __ffs as FIELD_{GET,PREP} don't not work with non-constant masks
* Use correct mask in cpg_z_clk_recalc_rate()

Changes since v2:
* Rebase
* Address review of v2 as noted in patch changelogs

Takeshi Kihara (6):
  clk: renesas: rcar-gen3: Add Z clock divider support
  clk: renesas: rcar-gen3: Add Z2 clock divider support
  clk: renesas: r8a7795: Add Z clock
  clk: renesas: r8a7795: Add Z2 clock
  clk: renesas: r8a7796: Add Z clock
  clk: renesas: r8a7796: Add Z2 clock

 drivers/clk/renesas/r8a7795-cpg-mssr.c |   2 +
 drivers/clk/renesas/r8a7796-cpg-mssr.c |   2 +
 drivers/clk/renesas/rcar-gen3-cpg.c    | 143 +++++++++++++++++++++++++++++++++
 drivers/clk/renesas/rcar-gen3-cpg.h    |   2 +
 4 files changed, 149 insertions(+)

Results of testing this on the Salvator-X r8a7796 are as follows:

On Boot
-------

Z clock is half of pll0 and corresponds to CPU frequency.
Z2 clock is half pll2. This is as expected.

root at Debian:~# cd /sys/devices/system/cpu/cpu0/cpufreq
root at Debian:/sys/devices/system/cpu/cpu0/cpufreq# grep -E -w "pll0|z" /sys/kernel/debug/clk/clk_summary; grep -E -w "pll2|z2" /sys/kernel/debug/clk/clk_summary; grep . *cur*
       .pll0                              0            0  2999999880          0 0
          z                               0            0  1499999940          0 0
       .pll2                              0            0  2399999904          0 0
          z2                              0            0  1199999952          0 0
cpuinfo_cur_freq:1499999
scaling_cur_freq:1500000

CPU Freq scaled to 1000000 and then 500000
------------------------------------------

Z clock corresponds to new CPU frequency.
Z2 clock, PLL0 and PLL2 are unchanged.
This is also as expected.

root at Debian:/sys/devices/system/cpu/cpu0/cpufreq# echo 1000000 > scaling_max_freq
root at Debian:/sys/devices/system/cpu/cpu0/cpufreq# grep -E -w "pll0|z" /sys/kernel/debug/clk/clk_summary; grep -E -w "pll2|z2" /sys/kernel/debug/clk/clk_summary; grep . *cur*
 grep . *cur*lk_summary; grep -E -w "pll2|z2" /sys/kernel/debug/clk/clk_summary; 
       .pll0                              0            0  2999999880          0 0  
          z                               0            0  1031249959          0 0  
       .pll2                              0            0  2399999904          0 0  
          z2                              0            0  1199999952          0 0  
cpuinfo_cur_freq:1031249
scaling_cur_freq:1000000

root at Debian:/sys/devices/system/cpu/cpu0/cpufreq# echo 500000 > scaling_max_freq
root at Debian:/sys/devices/system/cpu/cpu0/cpufreq# grep -E -w "pll0|z" /sys/kernel/debug/clk/clk_summary; grep -E -w "pll2|z2" /sys/kernel/debug/clk/clk_summary; grep . *cur*
       .pll0                              0            0  2999999880          0 0  
          z                               0            0   468749981          0 0  
       .pll2                              0            0  2399999904          0 0  
          z2                              0            0  1199999952          0 0  
cpuinfo_cur_freq:468749
scaling_cur_freq:500000
