From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Mon, 16 Dec 2013 17:55:55 -0300
Subject: [PATCHv6 2/5] clk: socfpga: Add a clock type for the SD/MMC driver
In-Reply-To: <20131215045116.23538.4@quantum>
References: <1386880245-10192-1-git-send-email-dinguyen@altera.com>
 <1386880245-10192-3-git-send-email-dinguyen@altera.com>
 <201312142233.27143.arnd@arndb.de> <52AD1185.6090501@linaro.org>
 <20131215045116.23538.4@quantum>
Message-ID: <52AF68DB.7090105@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike et al,

El 15/12/13 01:51, Mike Turquette escribi?:
> clk_set_phase has been proposed before and now may be the time to add
> it. There are two things that need to be addressed:
>
> 1) what are the values for the phase? This needs to work for others that
> must set clk phase, so we need to consider all those requirements before
> making a new function declaration in clk.h
>
> 2) is setting a clock's phase something done dynamically? Put another
> way, does the same clock has it's phase set multiple times while the
> system is running? For static configuration that only happens during
> initialization we do not need a new API. The clock driver can handle it
> privately. For dynamic operations though we likely need a new API.

We on sunxi also need this for our (not yet merged) MMC driver; we 
currently have it implemented as an exported

void clk_sunxi_mmc_phase_control(struct clk_hw *hw, u8 sample, u8 output)

that takes the MMC clock (and only the MMC clock) and does the setup 
(it's basically configuring two values, "sample" and "output", into the 
clock register). I really don't know what does this do/why is it 
required/when is it used; I'm cc'ing Hans and David who can hopefully 
explain that part.

I also saw a similar requirement from the gmac people (on cc too), who 
needed to set the phy type (or something like that) on one of the clock 
registers; so I'm thinking maybe a generic "tune something" approach 
that lets users configure some clock-dependent, arbitrary aspect of the 
clock is the way forward. Otherwise, we're going to end up bloating the 
clock framework with a lot of callback pointers that are going to be 
used in one or two clocks out of potentially hundreds on the whole system.

Cheers,

Emilio
