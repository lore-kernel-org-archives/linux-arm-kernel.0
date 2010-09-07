From: avictor.za@gmail.com (avictor.za at gmail.com)
Date: Tue, 7 Sep 2010 21:42:56 +0200
Subject: [PATCH] AT91: SAM9G45 - add a separate clock entry for every
	single TC block
In-Reply-To: <1283772201-15453-1-git-send-email-nicolas.ferre@atmel.com>
References: <201009060548.18521.fg@emlix.com>
	<1283772201-15453-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <AANLkTin+vCsG3FUvX6DTUfFe7ZJpbkYyqw_TLvH9ujrJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

> +/* One additional fake clock for second TC block */
> +static struct clk tcb1_clk = {
> + ? ? ? .name ? ? ? ? ? = "tcb1_clk",
> + ? ? ? .pmc_mask ? ? ? = 0,
> + ? ? ? .type ? ? ? ? ? = CLK_TYPE_PERIPHERAL,
> + ? ? ? .parent ? ? ? ? = &tcb0_clk,
> +};
> +

Looking at this again...  since type is CLK_TYPE_PERIPHERAL, when you
call clk_register() the "parent" is changed to the master clock.

Which means, then later you call clk_enable() the "pmc_mask" is still
0, so 0 gets written (in pmc_periph_mode) to AT91_PMC_PCER.  So the
TCB clock won't be enabled.

Or am I missing something?


Regards,
  Andrew Victor
