From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Thu, 21 Dec 2017 19:04:40 +0300
Subject: [PATCH 0/2] Fix clock rate in the rockchip_fractional_approximation()
Message-ID: <1513872282-5370-1-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here are two patches fixing issue in the rockchip_fractional_approximation().
rockchip_fractional_approximation() can select clock rate whose
value will violate clock limit settings (i.e. one configured with 
clk_set_max_rate() and clk_set_min_rate()).

rockchip_fractional_approximation() was introduced by commit 5d890c2df900
("clk: rockchip: add special approximation to fix up fractional clk's jitter") 
whose description states that setting denominator 20 times larger than
numerator will generate precise clock frequency. It's strange, because
on my custom rk3188-based board and on radxa rock I've observed strange
hardware issues. I2S, for example, sometimes doesn't setup correct
rate on external SCLK_I2S0. UART0, for example, started to receive '\0' 
characters instead of valid symbols, signals on UART_RX was good.

So, I use clk_set_max_rate() to limit max value of i2s0_pre, uart0_pre,
uart1_pre, uart2_pre, uart3_pre to value of aclk_cpu_pre. That fixes
strange I2S and UART issues for me. If that make sense, than I can
send the patch. But it will logically conflict with commit 5d890c2df900
("clk: rockchip: add special approximation to fix up fractional clk's jitter").

Alexander Kochetkov (2):
  clk: rename clk_core_get_boundaries() to clk_hw_get_boundaries() and
    expose
  clk: rockchip: limit clock rate in the
    rockchip_fractional_approximation()

 drivers/clk/clk.c            |   14 ++++++++------
 drivers/clk/rockchip/clk.c   |    7 +++++++
 include/linux/clk-provider.h |    2 ++
 3 files changed, 17 insertions(+), 6 deletions(-)

-- 
1.7.9.5
