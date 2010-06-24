From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 24 Jun 2010 19:16:29 +0900
Subject: [PATCH v4] S5PV210 Correct clock register properties
In-Reply-To: <1277356687-9500-1-git-send-email-myungjoo.ham@samsung.com>
References: <1277356687-9500-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <010d01cb1386$554cc0f0$ffe642d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
Hi,

Thanks for your re-submitting.

But there are some comments.

It would be helpful to apply if you could keep some kind of rule about title
like following:
'ARM: S5PV210: Correct clock blahblah...'

> 1. Corrected shift values of I2S and UART clocks (CLK_GATE_IP3), which
were
> defined incorrectly.
> 
> 2. Corrected shift values of sclk_audio, uclk1, sclk_fimd, sclk_mmc,
> sclk_spi, sclk_pwm, which had duplicated .enable/.ctrlbit with their
> twins defined in struct clk init_clocks_disable[] and struct clk
> init_clocks[]. We've changed their .enable/.ctrlbit to use CLK_SRC_MASK
> register to avoid the duplicated clock problem described below.
> 
> --- Duplicated Clock Problem ---

Actually, above '---' means end of git commit message.
So should not be used in here.

> Please note that each clock definition should access different control
> register; otherwise, the system may suffer lockups. For example, if we
> have two clock definitions "a" and "b" which access the same register
> (and the shift value). Then, when we do:
> 
> 	module A
> 	clk = clk_get("a");
> 	clk->clk_enable(clk);
> 
> 	module B (context switch)
> 	clk = clk_get("b");
> 	clk->clk_enable(clk);
> 	do something with clk.
> 	clk->clk_disable(clk);
> 
> 	module A (context switch)
> 	do something with clk
> 	* At this point, the system may hang.
> 
> Therefore, there should be no clock definitions with the same contol
> register/shift. If we need to create "aliases", then, creating child
> clocks sharing the clock should be fine.
> 
> 3. Corrected other sclk_* shift values and access registers.
> 
> 
> Note that becuase UART clocks are properly disabled at boot time with
> this patch, UART drivers or somebody else should turn on the clock
> to read the console; otherwise, JIG willl not show any message.
> 
I don't think so. Because the uart clocks are still under init_clocks array.
So it will be enabled at boot time.

> 
> Note that this patch revises and merges the two previous patches:
> [PATCH] S5PV210 Correct clock register properties
> [PATCH] S5PV210 Correct clock source control register properties
> And follows the previous patch
> [PATCH v2] S5PV210 Correct clock register properties
> [PATCH v3] S5PV210 Correct clock register properties
> 
As Joonyoung Shim's comments, above messages like just history should be
moved under '---'.

> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv210/clock.c |  115
++++++++++++++++++++++-------------------
>  1 files changed, 62 insertions(+), 53 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
> index 154bca4..b3d156c 100644
> --- a/arch/arm/mach-s5pv210/clock.c
> +++ b/arch/arm/mach-s5pv210/clock.c

(snip)

Looks good but as I commented, need to modify commit title and message.

So will apply with modifying them.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
