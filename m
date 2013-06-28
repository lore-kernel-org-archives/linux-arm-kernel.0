From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 28 Jun 2013 10:55:19 +0800
Subject: [PATCH 1/2] serial: imx: remove the uart_console() check
In-Reply-To: <51CCF24D.1060007@freescale.com>
References: <1372239359-4054-1-git-send-email-b32955@freescale.com>
 <20130627141535.GD2695@S2101-09.ap.freescale.net>
 <51CCF24D.1060007@freescale.com>
Message-ID: <20130628025517.GA11043@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 10:17:49AM +0800, Huang Shijie wrote:
> We need to set the imx_setUp_ufcr() in our imx_console_setup(),
> so we need to enable the clocks, aren't we?

Ah, yes, I missed that.  But register access only needs ipg clock and
per clock still does not need to be enabled here, right?

> In the probe's uart_add_one_port(), we will register the console and
> call the setup() hook,
> so it's ok to disable the clocks in the end of the probe.

Look, here is what you do in .probe().

	clk_prepare_enable(sport->clk_per);
	clk_prepare_enable(sport->clk_ipg); 
	...
	uart_add_one_port(&imx_reg, &sport->port);
	...
	clk_disable_unprepare(sport->clk_per);
	clk_disable_unprepare(sport->clk_ipg);

Since imx_console_setup() will be called in uart_add_one_port() and
clocks are already being taken care of in imx_console_setup(), why do
you need all these clock operations here at all?

Shawn
