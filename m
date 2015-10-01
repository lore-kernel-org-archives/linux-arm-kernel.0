From: lkp@intel.com (kbuild test robot)
Date: Thu, 1 Oct 2015 23:12:20 +0800
Subject: [PATCH v3 2/2] power: reset: at91-shdwc: add new shutdown
 controller driver
In-Reply-To: <1443630121-13912-3-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <201510012359.ozifhFxJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

[auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]

config: ia64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c2df3a7df512b1d640247d7c9b7542217bfb9ab1
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/io.h:25:0,
                    from drivers/power/reset/at91-shdwc.c:22:
   drivers/power/reset/at91-shdwc.c: In function 'at91_poweroff':
   arch/ia64/include/asm/io.h:394:30: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define writel(v,a) __writel((v), (a))
                                 ^
>> drivers/power/reset/at91-shdwc.c:107:2: note: in expansion of macro 'writel'
     writel(AT91_SHDW_KEY | AT91_SHDW_SHDW,
     ^

vim +/writel +107 drivers/power/reset/at91-shdwc.c

    16	 * - Analog Comparator wake-up alarm
    17	 * - Serial RX wake-up alarm
    18	 * - low power debouncer
    19	 */
    20	
    21	#include <linux/clk.h>
  > 22	#include <linux/io.h>
    23	#include <linux/module.h>
    24	#include <linux/of.h>
    25	#include <linux/platform_device.h>
    26	#include <linux/printk.h>
    27	
    28	#define SLOW_CLOCK_FREQ	32768
    29	
    30	#define AT91_SHDW_CR	0x00		/* Shut Down Control Register */
    31	#define AT91_SHDW_SHDW		BIT(0)			/* Shut Down command */
    32	#define AT91_SHDW_KEY		(0xa5 << 24)		/* KEY Password */
    33	
    34	#define AT91_SHDW_MR	0x04		/* Shut Down Mode Register */
    35	#define AT91_SHDW_WKUPDBC_SHIFT	24
    36	#define AT91_SHDW_WKUPDBC_MASK	GENMASK(31, 16)
    37	#define AT91_SHDW_WKUPDBC(x)	(((x) << AT91_SHDW_WKUPDBC_SHIFT) \
    38							& AT91_SHDW_WKUPDBC_MASK)
    39	
    40	#define AT91_SHDW_SR	0x08		/* Shut Down Status Register */
    41	#define AT91_SHDW_WKUPIS_SHIFT	16
    42	#define AT91_SHDW_WKUPIS_MASK	GENMASK(31, 16)
    43	#define AT91_SHDW_WKUPIS(x)	((1 << (x)) << AT91_SHDW_WKUPIS_SHIFT \
    44							& AT91_SHDW_WKUPIS_MASK)
    45	
    46	#define AT91_SHDW_WUIR	0x0c		/* Shutdown Wake-up Inputs Register */
    47	#define AT91_SHDW_WKUPEN_MASK	GENMASK(15, 0)
    48	#define AT91_SHDW_WKUPEN(x)	((1 << (x)) & AT91_SHDW_WKUPEN_MASK)
    49	#define AT91_SHDW_WKUPT_SHIFT	16
    50	#define AT91_SHDW_WKUPT_MASK	GENMASK(31, 16)
    51	#define AT91_SHDW_WKUPT(x)	((1 << (x)) << AT91_SHDW_WKUPT_SHIFT \
    52							& AT91_SHDW_WKUPT_MASK)
    53	
    54	#define SHDW_WK_PIN(reg, cfg)	((reg) & AT91_SHDW_WKUPIS((cfg)->wkup_pin_input))
    55	#define SHDW_RTCWK(reg, cfg)	(((reg) >> ((cfg)->sr_rtcwk_shift)) & 0x1)
    56	#define SHDW_RTCWKEN(cfg)	(1 << ((cfg)->mr_rtcwk_shift))
    57	
    58	#define DBC_PERIOD_US(x)	DIV_ROUND_UP_ULL((1000000 * (x)), \
    59								SLOW_CLOCK_FREQ)
    60	
    61	struct shdwc_config {
    62		u8 wkup_pin_input;
    63		u8 mr_rtcwk_shift;
    64		u8 sr_rtcwk_shift;
    65	};
    66	
    67	struct shdwc {
    68		struct shdwc_config *cfg;
    69		void __iomem *at91_shdwc_base;
    70	};
    71	
    72	/*
    73	 * Hold configuration here, cannot be more than one instance of the driver
    74	 * since pm_power_off itself is global.
    75	 */
    76	static struct shdwc *at91_shdwc;
    77	static struct clk *sclk;
    78	
    79	static const unsigned long long sdwc_dbc_period[] = {
    80		0, 3, 32, 512, 4096, 32768,
    81	};
    82	
    83	static void __init at91_wakeup_status(struct platform_device *pdev)
    84	{
    85		struct shdwc *shdw = platform_get_drvdata(pdev);
    86		u32 reg;
    87		char *reason = "unknown";
    88	
    89		reg = readl(shdw->at91_shdwc_base + AT91_SHDW_SR);
    90	
    91		dev_dbg(&pdev->dev, "%s: status = %#x\n", __func__, reg);
    92	
    93		/* Simple power-on, just bail out */
    94		if (!reg)
    95			return;
    96	
    97		if (SHDW_WK_PIN(reg, shdw->cfg))
    98			reason = "WKUP pin";
    99		else if (SHDW_RTCWK(reg, shdw->cfg))
   100			reason = "RTC";
   101	
   102		pr_info("AT91: Wake-Up source: %s\n", reason);
   103	}
   104	
   105	static void at91_poweroff(void)
   106	{
 > 107		writel(AT91_SHDW_KEY | AT91_SHDW_SHDW,
   108				at91_shdwc->at91_shdwc_base + AT91_SHDW_CR);
   109	}
   110	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 41024 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151001/efa7d3a8/attachment-0001.obj>
