From: jorge.ramirez-ortiz@linaro.org (Jorge Ramirez)
Date: Thu, 7 Jul 2016 08:31:22 +0200
Subject: [PATCH v2 2/2] clk: hi6220: initialize UART1 clock to 150MHz
In-Reply-To: <146784139106.73491.6417383579004254897@resonance>
References: <1467189955-21694-1-git-send-email-guodong.xu@linaro.org>
 <1467189955-21694-2-git-send-email-guodong.xu@linaro.org>
 <146784139106.73491.6417383579004254897@resonance>
Message-ID: <577DF73A.1030701@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2016 11:43 PM, Michael Turquette wrote:
> Quoting Guodong Xu (2016-06-29 01:45:55)
>> >From: Jorge Ramirez-Ortiz<jorge.ramirez-ortiz@linaro.org>
>> >
>> >Early at boot, during the sys_clk initialization, make sure UART1 uses
>> >the higher frequency clock, 150MHz.
>> >
>> >This enables support for higher baud rates (up to 3Mbps) in UART1, which
>> >is required by faster bluetooth transfers.
>> >
>> >v2: use clk_set_rate() to propergate clock settings.
>> >
>> >Signed-off-by: Jorge Ramirez-Ortiz<jorge.ramirez-ortiz@linaro.org>
>> >Signed-off-by: Guodong Xu<guodong.xu@linaro.org>
>> >---
>> >  drivers/clk/hisilicon/clk-hi6220.c | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> >diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
>> >index a36ffcb..631c56f 100644
>> >--- a/drivers/clk/hisilicon/clk-hi6220.c
>> >+++ b/drivers/clk/hisilicon/clk-hi6220.c
>> >@@ -12,6 +12,7 @@
>> >  
>> >  #include <linux/kernel.h>
>> >  #include <linux/clk-provider.h>
>> >+#include <linux/clk.h>
>> >  #include <linux/clkdev.h>
>> >  #include <linux/io.h>
>> >  #include <linux/of.h>
>> >@@ -192,6 +193,9 @@ static void __init hi6220_clk_sys_init(struct device_node *np)
>> >  
>> >         hi6220_clk_register_divider(hi6220_div_clks_sys,
>> >                         ARRAY_SIZE(hi6220_div_clks_sys), clk_data);
>> >+
>> >+       if (clk_set_rate(clk_data->clk_data.clks[HI6220_UART1_SRC], 150000000))
>> >+               pr_err("failed to set uart1 clock rate\n");
> Why doesn't the UART driver call clk_get and then clk_set_rate on this
> clock? Why do it in the clk provider driver?

yes that was my initial choice as well; in the end I opted to do it in 
the clock driver because of it being a value that will not have to ever 
change for the SoC and - maybe more importantly- because of not having a 
DT property available for the primecell pl011 uart where to  specify the 
value (so I thought this was a less intrusive implementation).
