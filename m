From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 26 Apr 2012 10:48:38 +0800
Subject: [PATCH 33/33] ARM: i.MX6: implement clocks using common clock
 framework
In-Reply-To: <1335367703-19929-34-git-send-email-s.hauer@pengutronix.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
 <1335367703-19929-34-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120426024837.GD28063@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The below code is removed from mx6q_clocks_init implicitly.
Why? If it's reasonable, it needs to be on a separate patch too.

/* only keep necessary clocks on */
writel_relaxed(0x3 << CG0  | 0x3 << CG1  | 0x3 << CG2,  CCGR0);
writel_relaxed(0x3 << CG8  | 0x3 << CG9  | 0x3 << CG10, CCGR2);
writel_relaxed(0x3 << CG10 | 0x3 << CG12,               CCGR3);
writel_relaxed(0x3 << CG4  | 0x3 << CG6  | 0x3 << CG7,  CCGR4);
writel_relaxed(0x3 << CG0,                              CCGR5);
writel_relaxed(0,                                       CCGR6);
writel_relaxed(0,                                       CCGR7);

clk_enable(&uart_clk);
clk_enable(&mmdc_ch0_axi_clk);

clk_set_rate(&pll4_audio, FREQ_650M);
clk_set_rate(&pll5_video, FREQ_650M);
clk_set_parent(&ipu1_di0_clk, &ipu1_di0_pre_clk);
clk_set_parent(&ipu1_di0_pre_clk, &pll5_video);
clk_set_parent(&gpu3d_shader_clk, &pll2_pfd_594m);
clk_set_rate(&gpu3d_shader_clk, FREQ_594M);
clk_set_parent(&gpu3d_core_clk, &mmdc_ch0_axi_clk);
clk_set_rate(&gpu3d_core_clk, FREQ_528M);
clk_set_parent(&asrc_serial_clk, &pll3_usb_otg);
clk_set_rate(&asrc_serial_clk, 1500000);
clk_set_rate(&enfc_clk, 11000000);

/*
 * Before pinctrl API is available, we have to rely on the pad
 * configuration set up by bootloader.  For usdhc example here,
 * u-boot sets up the pads for 49.5 MHz case, and we have to lower
 * the usdhc clock from 198 to 49.5 MHz to match the pad configuration.
 *
 * FIXME: This is should be removed after pinctrl API is available.
 * At that time, usdhc driver can call pinctrl API to change pad
 * configuration dynamically per different usdhc clock settings.
 */
clk_set_rate(&usdhc1_clk, 49500000);
clk_set_rate(&usdhc2_clk, 49500000);
clk_set_rate(&usdhc3_clk, 49500000);
clk_set_rate(&usdhc4_clk, 49500000);

clk_set_parent(&cko1_clk, &ahb_clk);


Thanks
Richard
