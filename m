From: mturquette@linaro.org (Michael Turquette)
Date: Tue, 09 Jun 2015 19:13:15 -0700
Subject: [PATCH v4 3/5] clk: add lpc18xx ccu clk driver
In-Reply-To: <1432845107-12458-4-git-send-email-manabian@gmail.com>
References: <1432845107-12458-1-git-send-email-manabian@gmail.com>
 <1432845107-12458-4-git-send-email-manabian@gmail.com>
Message-ID: <20150610021315.6017.58085@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Joachim Eastwood (2015-05-28 13:31:45)
> +static struct lpc18xx_clk_branch clk_branches[] = {
> +       {"base_apb3_clk", "apb3_bus",           CLK_APB3_BUS,           CCU_BRANCH_IS_BUS},
> +       {"base_apb3_clk", "apb3_i2c1",          CLK_APB3_I2C1,          0},
> +       {"base_apb3_clk", "apb3_dac",           CLK_APB3_DAC,           0},
> +       {"base_apb3_clk", "apb3_adc0",          CLK_APB3_ADC0,          0},
> +       {"base_apb3_clk", "apb3_adc1",          CLK_APB3_ADC1,          0},
> +       {"base_apb3_clk", "apb3_can0",          CLK_APB3_CAN0,          0},
> +
> +       {"base_apb1_clk", "apb1_bus",           CLK_APB1_BUS,           CCU_BRANCH_IS_BUS},
> +       {"base_apb1_clk", "apb1_mc_pwm",        CLK_APB1_MOTOCON_PWM,   0},
> +       {"base_apb1_clk", "apb1_i2c0",          CLK_APB1_I2C0,          0},
> +       {"base_apb1_clk", "apb1_i2s",           CLK_APB1_I2S,           0},
> +       {"base_apb1_clk", "apb1_can1",          CLK_APB1_CAN1,          0},
> +
> +       {"base_spifi_clk", "spifi",             CLK_SPIFI,              0},
> +
> +       {"base_cpu_clk", "cpu_bus",             CLK_CPU_BUS,            CCU_BRANCH_IS_BUS},
> +       {"base_cpu_clk", "cpu_spifi",           CLK_CPU_SPIFI,          0},
> +       {"base_cpu_clk", "cpu_gpio",            CLK_CPU_GPIO,           0},
> +       {"base_cpu_clk", "cpu_lcd",             CLK_CPU_LCD,            0},
> +       {"base_cpu_clk", "cpu_ethernet",        CLK_CPU_ETHERNET,       0},
> +       {"base_cpu_clk", "cpu_usb0",            CLK_CPU_USB0,           0},
> +       {"base_cpu_clk", "cpu_emc",             CLK_CPU_EMC,            0},
> +       {"base_cpu_clk", "cpu_sdio",            CLK_CPU_SDIO,           0},
> +       {"base_cpu_clk", "cpu_dma",             CLK_CPU_DMA,            0},
> +       {"base_cpu_clk", "cpu_core",            CLK_CPU_CORE,           0},
> +       {"base_cpu_clk", "cpu_sct",             CLK_CPU_SCT,            0},
> +       {"base_cpu_clk", "cpu_usb1",            CLK_CPU_USB1,           0},
> +       {"base_cpu_clk", "cpu_emcdiv",          CLK_CPU_EMCDIV,         CCU_BRANCH_HAVE_DIV2},
> +       {"base_cpu_clk", "cpu_flasha",          CLK_CPU_FLASHA,         CCU_BRANCH_HAVE_DIV2},
> +       {"base_cpu_clk", "cpu_flashb",          CLK_CPU_FLASHB,         CCU_BRANCH_HAVE_DIV2},
> +       {"base_cpu_clk", "cpu_m0app",           CLK_CPU_M0APP,          CCU_BRANCH_HAVE_DIV2},
> +       {"base_cpu_clk", "cpu_adchs",           CLK_CPU_ADCHS,          CCU_BRANCH_HAVE_DIV2},
> +       {"base_cpu_clk", "cpu_eeprom",          CLK_CPU_EEPROM,         CCU_BRANCH_HAVE_DIV2},
> +       {"base_cpu_clk", "cpu_wwdt",            CLK_CPU_WWDT,           0},
> +       {"base_cpu_clk", "cpu_uart0",           CLK_CPU_UART0,          0},
> +       {"base_cpu_clk", "cpu_uart1",           CLK_CPU_UART1,          0},
> +       {"base_cpu_clk", "cpu_ssp0",            CLK_CPU_SSP0,           0},
> +       {"base_cpu_clk", "cpu_timer0",          CLK_CPU_TIMER0,         0},
> +       {"base_cpu_clk", "cpu_timer1",          CLK_CPU_TIMER1,         0},
> +       {"base_cpu_clk", "cpu_scu",             CLK_CPU_SCU,            0},
> +       {"base_cpu_clk", "cpu_creg",            CLK_CPU_CREG,           0},
> +       {"base_cpu_clk", "cpu_ritimer",         CLK_CPU_RITIMER,        0},
> +       {"base_cpu_clk", "cpu_uart2",           CLK_CPU_UART2,          0},
> +       {"base_cpu_clk", "cpu_uart3",           CLK_CPU_UART3,          0},
> +       {"base_cpu_clk", "cpu_timer2",          CLK_CPU_TIMER2,         0},
> +       {"base_cpu_clk", "cpu_timer3",          CLK_CPU_TIMER3,         0},
> +       {"base_cpu_clk", "cpu_ssp1",            CLK_CPU_SSP1,           0},
> +       {"base_cpu_clk", "cpu_qei",             CLK_CPU_QEI,            0},
> +
> +       {"base_periph_clk", "periph_bus",       CLK_PERIPH_BUS,         CCU_BRANCH_IS_BUS},
> +       {"base_periph_clk", "periph_core",      CLK_PERIPH_CORE,        0},
> +       {"base_periph_clk", "periph_sgpio",     CLK_PERIPH_SGPIO,       0},
> +
> +       {"base_usb0_clk",  "usb0",              CLK_USB0,               0},
> +       {"base_usb1_clk",  "usb1",              CLK_USB1,               0},
> +       {"base_spi_clk",   "spi",               CLK_SPI,                0},
> +       {"base_adchs_clk", "adchs",             CLK_ADCHS,              0},
> +
> +       {"base_audio_clk", "audio",             CLK_AUDIO,              0},
> +       {"base_uart3_clk", "apb2_uart3",        CLK_APB2_UART3,         0},
> +       {"base_uart2_clk", "apb2_uart2",        CLK_APB2_UART2,         0},
> +       {"base_uart1_clk", "apb0_uart1",        CLK_APB0_UART1,         0},
> +       {"base_uart0_clk", "apb0_uart0",        CLK_APB0_UART0,         0},
> +       {"base_ssp1_clk",  "apb2_ssp1",         CLK_APB2_SSP1,          0},
> +       {"base_ssp0_clk",  "apb0_ssp0",         CLK_APB0_SSP0,          0},
> +       {"base_sdio_clk",  "sdio",              CLK_SDIO,               0},
> +};

Hi Joachim,

If it were me, I would have broken this up into two tables, one for each
CCU. In general I would structure the code to reflect the fact that two
different IP blocks are being accessed. This isn't a deal breaker but I
thought I would mention it in case you want to make the change.

Otherwise this series looks good to me. Let me know if you plan a V5
submission.

I can take patches #1-4 into the clk tree. Please add my Acked-by to
patch #5. I will create an immutable branch to share with the arm-soc
tree so that they can take #5 and have access to the dt-bindings
headers.

Regards,
Mike
