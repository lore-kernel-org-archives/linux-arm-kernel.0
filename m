From: kernel@martin.sperl.org (Martin Sperl)
Date: Tue, 26 Apr 2016 09:48:47 +0200
Subject: [PATCH 3/6] clk: bcm2835: enable clocks that have been enabled by
 firmware
In-Reply-To: <87bn6dt13o.fsf@eliezer.anholt.net>
References: <1456745963-2403-1-git-send-email-kernel@martin.sperl.org>
 <1456745963-2403-4-git-send-email-kernel@martin.sperl.org>
 <87vb575ld9.fsf@eliezer.anholt.net> <87poutf1gv.fsf@eliezer.anholt.net>
 <19B78DCB-23E2-4600-ABF6-177AFACF159D@martin.sperl.org>
 <87bn6dt13o.fsf@eliezer.anholt.net>
Message-ID: <E350B5CE-4324-4DC4-8078-8986A14DF07F@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 17.03.2016, at 19:23, Eric Anholt <eric@anholt.net> wrote:
> 
> Martin Sperl <kernel@martin.sperl.org> writes:
>> 
>> See that separate thread that triggered this:
>>  serial: clk: bcm2835: Strange effects when using aux-uart in console
>> and this patch fixes this issue.
>> 
>> To summarize the situation figured in the thread:
>> * you load the module
>> 
>> * you start using the tty (say by using "stty -F /dev/ttyAMA0")
>> * this opens the device
>> * this prepare the relevant clock (usage = 1)
>> * this prepares the parent pll-divider (usage = 1)
>> * this prepares the parent pll (usage = 1)
>> 
>> * you stop using the tty (stty closes the device)
>> * this release the clock
>> *   usage count drops to 0, so disable the clock
>> * this releases the parent pll-divider
>> *   usage count drops to 0, so disable the pll-div
>> * this releases the parent pll (and disables it as usage = 0)
>> *   usage count drops to 0, so disable the pll-div
>> 
>> * system crashes (with a bit of delay)
>> 
>> The prepare should just increase the usage so it never gets to a count of 0.
>> 
>> Maybe we need to use those "CLK_IS_CRITICAL? ?HANDS_OFF? flags instead?
>> (when/if they become available)
>> 
>> How do you want to solve that - I have not got a DSI display, 
>> but HDMI continues to work...
> 
> We should just prepare the necessary divider, not the leaf clocks that
> we actually want to control at runtime.

So how are we continuing here?
The reason why I am asking is that switching downstream to use the clock
driver result in the lockups also when using i2s/pcm.

I have seen that CLK_IS_CRITICAL has made it into the clk-next tree.
Should we use that for plls (or pll_dividers) that are running?

Something like this:
diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 35f8de7..c17019f 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1200,6 +1200,15 @@ bcm2835_register_pll_divider(struct bcm2835_cprman *cprman,
        divider->cprman = cprman;
        divider->data = data;

+       /* if the pll-divider is running, then mark is as critical */
+       if ((cprman_read(cprman, data->a2w_reg) &
+            A2W_PLL_CHANNEL_DISABLE) == 0) {
+               dev_info(cprman->dev,
+                        "found enabled pll_div %s - marking it as critical\n",
+                        data->name);
+               init.flags |= CLK_IS_CRITICAL;
+       }
+
        clk = devm_clk_register(cprman->dev, &divider->div.hw);
        if (IS_ERR(clk))
                return clk;

At least for downstream this does work and gives the following messages:
[    2.861321] bcm2835-clk 20101000.cprman: found enabled pll_div plla_core - marking it as critical
[    2.875917] bcm2835-clk 20101000.cprman: found enabled pll_div pllb_arm - marking it as critical
[    2.961250] bcm2835-clk 20101000.cprman: found enabled pll_div pllc_core0 - marking it as critical
[    2.977317] bcm2835-clk 20101000.cprman: found enabled pll_div pllc_per - marking it as critical
[    2.993226] bcm2835-clk 20101000.cprman: found enabled pll_div plld_core - marking it as critical
[    3.010189] bcm2835-clk 20101000.cprman: found enabled pll_div plld_per - marking it as critical
[    3.024993] bcm2835-clk 20101000.cprman: found enabled pll_div pllh_pix - marking it as critical

Martin
