From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 2 Feb 2018 15:03:38 +0100
Subject: [PATCH 10/14] clk: stm32mp1: add Peripheral clocks
In-Reply-To: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
References: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1517580222-23301-11-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Each peripheral requires a bus interface clock.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 114 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 13d74f3..ea78a6a 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1222,6 +1222,10 @@ static struct clk_hw *_clk_register_cktim(struct device *dev,
 		  MP1_GATE(_id, _name, _parent, CLK_SET_RATE_PARENT,\
 			   _offset_set, _bit_idx, 0)
 
+#define PCLK(_reg, _id, _name, _parent, _gate_idx, _flags)\
+	     MP1_GATE(_id, _name, _parent, _flags,\
+		      RCC_##_reg##ENSETR, _gate_idx, 0)
+
 static const struct clock_config stm32mp1_clock_cfg[] = {
 	/* Oscillator divider */
 	DIV(NO_ID, "clk-hsi-div", "clk-hsi", 0, RCC_HSICFGR, 0, 2,
@@ -1337,6 +1341,116 @@ static struct clk_hw *_clk_register_cktim(struct device *dev,
 	STM32_TIM(TIM15_K, "tim15_k", "ck2_tim", RCC_APB2ENSETR, 2),
 	STM32_TIM(TIM16_K, "tim16_k", "ck2_tim", RCC_APB2ENSETR, 3),
 	STM32_TIM(TIM17_K, "tim17_k", "ck2_tim", RCC_APB2ENSETR, 4),
+
+	/* Peripheral clocks */
+	PCLK(APB1, TIM2, "tim2", "pclk1", 0, CLK_IGNORE_UNUSED),
+	PCLK(APB1, TIM3, "tim3", "pclk1", 1, CLK_IGNORE_UNUSED),
+	PCLK(APB1, TIM4, "tim4", "pclk1", 2, CLK_IGNORE_UNUSED),
+	PCLK(APB1, TIM5, "tim5", "pclk1", 3, CLK_IGNORE_UNUSED),
+	PCLK(APB1, TIM6, "tim6", "pclk1", 4, CLK_IGNORE_UNUSED),
+	PCLK(APB1, TIM7, "tim7", "pclk1", 5, CLK_IGNORE_UNUSED),
+	PCLK(APB1, TIM12, "tim12", "pclk1", 6, CLK_IGNORE_UNUSED),
+	PCLK(APB1, TIM13, "tim13", "pclk1", 7, CLK_IGNORE_UNUSED),
+	PCLK(APB1, TIM14, "tim14", "pclk1", 8, CLK_IGNORE_UNUSED),
+	PCLK(APB1, LPTIM1, "lptim1", "pclk1", 9, CLK_IGNORE_UNUSED),
+	PCLK(APB1, SPI2, "spi2", "pclk1", 11, CLK_IGNORE_UNUSED),
+	PCLK(APB1, SPI3, "spi3", "pclk1", 12, CLK_IGNORE_UNUSED),
+	PCLK(APB1, USART2, "usart2", "pclk1", 14, CLK_IGNORE_UNUSED),
+	PCLK(APB1, USART3, "usart3", "pclk1", 15, CLK_IGNORE_UNUSED),
+	PCLK(APB1, UART4, "uart4", "pclk1", 16, CLK_IGNORE_UNUSED),
+	PCLK(APB1, UART5, "uart5", "pclk1", 17, CLK_IGNORE_UNUSED),
+	PCLK(APB1, UART7, "uart7", "pclk1", 18, CLK_IGNORE_UNUSED),
+	PCLK(APB1, UART8, "uart8", "pclk1", 19, CLK_IGNORE_UNUSED),
+	PCLK(APB1, I2C1, "i2c1", "pclk1", 21, CLK_IGNORE_UNUSED),
+	PCLK(APB1, I2C2, "i2c2", "pclk1", 22, CLK_IGNORE_UNUSED),
+	PCLK(APB1, I2C3, "i2c3", "pclk1", 23, CLK_IGNORE_UNUSED),
+	PCLK(APB1, I2C5, "i2c5", "pclk1", 24, CLK_IGNORE_UNUSED),
+	PCLK(APB1, SPDIF, "spdif", "pclk1", 26, CLK_IGNORE_UNUSED),
+	PCLK(APB1, CEC, "cec", "pclk1", 27, CLK_IGNORE_UNUSED),
+	PCLK(APB1, DAC12, "dac12", "pclk1", 29, 0),
+	PCLK(APB1, MDIO, "mdio", "pclk1", 31, 0),
+	PCLK(APB2, TIM1, "tim1", "pclk2", 0, CLK_IGNORE_UNUSED),
+	PCLK(APB2, TIM8, "tim8", "pclk2", 1, CLK_IGNORE_UNUSED),
+	PCLK(APB2, TIM15, "tim15", "pclk2", 2, CLK_IGNORE_UNUSED),
+	PCLK(APB2, TIM16, "tim16", "pclk2", 3, CLK_IGNORE_UNUSED),
+	PCLK(APB2, TIM17, "tim17", "pclk2", 4, CLK_IGNORE_UNUSED),
+	PCLK(APB2, SPI1, "spi1", "pclk2", 8, CLK_IGNORE_UNUSED),
+	PCLK(APB2, SPI4, "spi4", "pclk2", 9, CLK_IGNORE_UNUSED),
+	PCLK(APB2, SPI5, "spi5", "pclk2", 10, CLK_IGNORE_UNUSED),
+	PCLK(APB2, USART6, "usart6", "pclk2", 13, CLK_IGNORE_UNUSED),
+	PCLK(APB2, SAI1, "sai1", "pclk2", 16, CLK_IGNORE_UNUSED),
+	PCLK(APB2, SAI2, "sai2", "pclk2", 17, CLK_IGNORE_UNUSED),
+	PCLK(APB2, SAI3, "sai3", "pclk2", 18, CLK_IGNORE_UNUSED),
+	PCLK(APB2, DFSDM, "dfsdm", "pclk2", 20, CLK_IGNORE_UNUSED),
+	PCLK(APB2, FDCAN, "fdcan", "pclk2", 24, CLK_IGNORE_UNUSED),
+	PCLK(APB3, LPTIM2, "lptim2", "pclk3", 0, CLK_IGNORE_UNUSED),
+	PCLK(APB3, LPTIM3, "lptim3", "pclk3", 1, CLK_IGNORE_UNUSED),
+	PCLK(APB3, LPTIM4, "lptim4", "pclk3", 2, CLK_IGNORE_UNUSED),
+	PCLK(APB3, LPTIM5, "lptim5", "pclk3", 3, CLK_IGNORE_UNUSED),
+	PCLK(APB3, SAI4, "sai4", "pclk3", 8, CLK_IGNORE_UNUSED),
+	PCLK(APB3, SYSCFG, "syscfg", "pclk3", 11, 0),
+	PCLK(APB3, VREF, "vref", "pclk3", 13, 0),
+	PCLK(APB3, TMPSENS, "tmpsens", "pclk3", 16, 0),
+	PCLK(APB3, PMBCTRL, "pmbctrl", "pclk3", 17, 0),
+	PCLK(APB3, HDP, "hdp", "pclk3", 20, 0),
+	PCLK(APB4, LTDC, "ltdc", "pclk4", 0, CLK_IGNORE_UNUSED),
+	PCLK(APB4, DSI, "dsi", "pclk4", 4, CLK_IGNORE_UNUSED),
+	PCLK(APB4, IWDG2, "iwdg2", "pclk4", 15, 0),
+	PCLK(APB4, USBPHY, "usbphy", "pclk4", 16, CLK_IGNORE_UNUSED),
+	PCLK(APB4, STGENRO, "stgenro", "pclk4", 20, 0),
+	PCLK(APB5, SPI6, "spi6", "pclk5", 0, CLK_IGNORE_UNUSED),
+	PCLK(APB5, I2C4, "i2c4", "pclk5", 2, CLK_IGNORE_UNUSED),
+	PCLK(APB5, I2C6, "i2c6", "pclk5", 3, CLK_IGNORE_UNUSED),
+	PCLK(APB5, USART1, "usart1", "pclk5", 4, CLK_IGNORE_UNUSED),
+	PCLK(APB5, RTCAPB, "rtcapb", "pclk5", 8, CLK_IGNORE_UNUSED |
+	     CLK_IS_CRITICAL),
+	PCLK(APB5, TZC, "tzc", "pclk5", 12, CLK_IGNORE_UNUSED),
+	PCLK(APB5, TZPC, "tzpc", "pclk5", 13, CLK_IGNORE_UNUSED),
+	PCLK(APB5, IWDG1, "iwdg1", "pclk5", 15, 0),
+	PCLK(APB5, BSEC, "bsec", "pclk5", 16, CLK_IGNORE_UNUSED),
+	PCLK(APB5, STGEN, "stgen", "pclk5", 20, CLK_IGNORE_UNUSED),
+	PCLK(AHB2, DMA1, "dma1", "ck_mcu", 0, 0),
+	PCLK(AHB2, DMA2, "dma2", "ck_mcu",  1, 0),
+	PCLK(AHB2, DMAMUX, "dmamux", "ck_mcu", 2, 0),
+	PCLK(AHB2, ADC12, "adc12", "ck_mcu", 5, CLK_IGNORE_UNUSED),
+	PCLK(AHB2, USBO, "usbo", "ck_mcu", 8, CLK_IGNORE_UNUSED),
+	PCLK(AHB2, SDMMC3, "sdmmc3", "ck_mcu", 16, CLK_IGNORE_UNUSED),
+	PCLK(AHB3, DCMI, "dcmi", "ck_mcu", 0, 0),
+	PCLK(AHB3, CRYP2, "cryp2", "ck_mcu", 4, 0),
+	PCLK(AHB3, HASH2, "hash2", "ck_mcu", 5, 0),
+	PCLK(AHB3, RNG2, "rng2", "ck_mcu", 6, CLK_IGNORE_UNUSED),
+	PCLK(AHB3, CRC2, "crc2", "ck_mcu", 7, 0),
+	PCLK(AHB3, HSEM, "hsem", "ck_mcu", 11, 0),
+	PCLK(AHB3, IPCC, "ipcc", "ck_mcu", 12, 0),
+	PCLK(AHB4, GPIOA, "gpioa", "ck_mcu", 0, 0),
+	PCLK(AHB4, GPIOB, "gpiob", "ck_mcu", 1, 0),
+	PCLK(AHB4, GPIOC, "gpioc", "ck_mcu", 2, 0),
+	PCLK(AHB4, GPIOD, "gpiod", "ck_mcu", 3, 0),
+	PCLK(AHB4, GPIOE, "gpioe", "ck_mcu", 4, 0),
+	PCLK(AHB4, GPIOF, "gpiof", "ck_mcu", 5, 0),
+	PCLK(AHB4, GPIOG, "gpiog", "ck_mcu", 6, 0),
+	PCLK(AHB4, GPIOH, "gpioh", "ck_mcu", 7, 0),
+	PCLK(AHB4, GPIOI, "gpioi", "ck_mcu", 8, 0),
+	PCLK(AHB4, GPIOJ, "gpioj", "ck_mcu", 9, 0),
+	PCLK(AHB4, GPIOK, "gpiok", "ck_mcu", 10, 0),
+	PCLK(AHB5, GPIOZ, "gpioz", "ck_axi", 0, CLK_IGNORE_UNUSED),
+	PCLK(AHB5, CRYP1, "cryp1", "ck_axi", 4, CLK_IGNORE_UNUSED),
+	PCLK(AHB5, HASH1, "hash1", "ck_axi", 5, CLK_IGNORE_UNUSED),
+	PCLK(AHB5, RNG1, "rng1", "ck_axi",  6, CLK_IGNORE_UNUSED),
+	PCLK(AHB5, BKPSRAM, "bkpsram", "ck_axi", 8, CLK_IGNORE_UNUSED),
+	PCLK(AHB6, MDMA, "mdma", "ck_axi", 0, 0),
+	PCLK(AHB6, GPU, "gpu", "ck_axi", 5, CLK_IGNORE_UNUSED),
+	PCLK(AHB6, ETHCK, "ethck", "ck_axi", 7, 0),
+	PCLK(AHB6, ETHTX, "ethtx", "ck_axi", 8, 0),
+	PCLK(AHB6, ETHRX, "ethrx", "ck_axi", 9, 0),
+	PCLK(AHB6, ETHMAC, "ethmac", "ck_axi", 10, CLK_IGNORE_UNUSED),
+	PCLK(AHB6, FMC, "fmc", "ck_axi", 12, CLK_IGNORE_UNUSED),
+	PCLK(AHB6, QSPI, "qspi", "ck_axi", 14, CLK_IGNORE_UNUSED),
+	PCLK(AHB6, SDMMC1, "sdmmc1", "ck_axi", 16, CLK_IGNORE_UNUSED),
+	PCLK(AHB6, SDMMC2, "sdmmc2", "ck_axi", 17, CLK_IGNORE_UNUSED),
+	PCLK(AHB6, CRC1, "crc1", "ck_axi", 20, 0),
+	PCLK(AHB6, USBH, "usbh", "ck_axi", 24, 0),
+	PCLK(AHB6LP, ETHSTP, "ethstp", "ck_axi", 11, 0),
 };
 
 struct stm32_clock_match_data {
-- 
1.9.1
