From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 21 Oct 2016 11:23:27 +0200
Subject: [PATCH v3 0/3] STM32F4 Add RTC & QSPI clocks
Message-ID: <1477041810-12313-1-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

v3:
 - remove arm & DT patches from this patch-set
 - solve issue of dependency with DT
 - remove clk_hw from struct stm32_rgate (use hw of clk_gate)
 - suppress CLK_IS_BASIC flags of clk_register_rgate()
 - cosmetic changes

v2:
 - rename compatible property "st,stm32f46xx-rcc" into "st,stm32f469-rcc"
 - cosmetic: remove bad copy/paste

This patch-set introduce RTC and QSPI clocks for STM32F4 socs
RTC clock has 3 parents clock oscillators (lsi/lse/hse_rtc)

example to use rtc clock:

		rtc: rtc at 40002800 {
			compatible = "st,stm32-rtc";
			reg = <0x40002800 0x400>;
			...
			clocks = <&rcc 1 CLK_RTC>;

			assigned-clocks =  <&rcc 1 CLK_RTC>;
			assigned-clock-parents = <&rcc 1 CLK_LSE>;
			...
		};

Gabriel Fernandez (3):
  clk: stm32f4: Add LSI & LSE clocks
  clk: stm32f4: Add RTC clock
  clk: stm32f469: Add QSPI clock

 .../devicetree/bindings/clock/st,stm32-rcc.txt     |   4 +-
 drivers/clk/clk-stm32f4.c                          | 435 ++++++++++++++++++++-
 2 files changed, 417 insertions(+), 22 deletions(-)

-- 
1.9.1
