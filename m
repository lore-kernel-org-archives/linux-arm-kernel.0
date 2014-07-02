From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 2 Jul 2014 13:52:56 -0300
Subject: [PATCH 4/5] ARM: imx: clk-gate2: Use post decrement for
 share_count
In-Reply-To: <20140702152942.12768.85270@quantum>
References: <1404194129-25543-1-git-send-email-festevam@gmail.com>
 <1404194129-25543-4-git-send-email-festevam@gmail.com>
 <20140701115252.GM14471@dragon>
 <CAOMZO5BmJFmjYP9=rfR5eRKWPioPoW=UjE_h=Q3kbEAJGRixAQ@mail.gmail.com>
 <20140702152942.12768.85270@quantum>
Message-ID: <CAOMZO5B=Jwodc+2hVhjXrCvERxuyKKviM+zYgH=ynvOSHLWBTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Wed, Jul 2, 2014 at 12:29 PM, Mike Turquette <mturquette@linaro.org> wrote:

>> If share_count is 1 it means that someone else is using the clock and
>> we can't disable it.
>
> Why do you keep track of share_count at all? Is the enable_count
> bookkeeping within the clock framework insufficient for your needs?

What we are trying to handle here is the case when two clocks share
the same clock gating bit.

Let's say clocks clk1 and clk2 share the same clock gating bit.

What we want to achieve are:

Scenario 1:

clk2 is disabled
clk1 is enabled --> clock gate bit is set to 1
clk1 is disabled --> clock gate bit is set to 0. As clk2 is disabled,
it is OK to gate off the clock here

Scenario 2:

clk1 is enabled -> clock gate bit is set to 1
clk2 is disabled -> clock gate bit cannot be set to 0 because clk1 is enabled

We currently have arch/arm/mach-imx/clk-gate2.c and we are trying to
fix it because the scenario 2 is not working.

I am wondering if we should just extend drivers/clk/clk-gate.c to
handle shared clock instead of doing this in arch/arm/mach-imx?

What do you think?

Thanks,

Fabio Estevam
