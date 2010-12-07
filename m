From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 7 Dec 2010 15:16:15 -0200
Subject: [PATCH v2] watchdog: imx: use clk_get to acquire the watchdogclock
In-Reply-To: <20101207164905.GD6017@pengutronix.de>
References: <1291738564-10374-1-git-send-email-fabio.estevam@freescale.com>
	<20101207164905.GD6017@pengutronix.de>
Message-ID: <4CFE6BDF.9030706@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On 12/7/2010 2:49 PM, Sascha Hauer wrote:
...
> I should have seen this happen. This breaks i.MX1 reset which uses
> imx-wdt.0.

I think it doesn?t break current mx1 reset mechanism. Please see the 
code below (arcm/arm/plat-mxc/system.c):

	if (cpu_is_mx1()) {
		wcr_enable = (1 << 0);
	} else {
		struct clk *clk;

		clk = clk_get_sys("imx2-wdt.0", NULL);
		if (!IS_ERR(clk))
			clk_enable(clk);
		wcr_enable = (1 << 2);
	}

For mx1 the clk_get_sys function is not called.

Regards,

Fabio Estevam
