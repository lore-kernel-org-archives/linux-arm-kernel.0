From: kernel@martin.sperl.org (Martin Sperl)
Date: Thu, 5 May 2016 22:29:07 +0200
Subject: [PATCH V5] clk: bcm2835: mark enabled clocks and pll with
 CLK_ENABLE_HAND_OFF
In-Reply-To: <87oa8ks49s.fsf@eliezer.anholt.net>
References: <1462348385-16167-1-git-send-email-kernel@martin.sperl.org>
 <87oa8ks49s.fsf@eliezer.anholt.net>
Message-ID: <13F43ACC-85CA-4F5F-800D-E547BBA4CC73@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 05.05.2016, at 21:17, Eric Anholt <eric@anholt.net> wrote:
> 
> kernel at martin.sperl.org writes:
> 
>> From: Martin Sperl <kernel@martin.sperl.org>
>> 
>> The bcm2835 firmware enables several clocks and plls before
>> booting the linux kernel.
>> 
>> These plls should never get disabled as it may result in a
>> stopped system clock and more.
>> 
>> So during probing we check if the clock and plls are enabled
>> and if it is then mark that clock/pll with CLK_ENABLE_HAND_OFF.
>> 
>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>> ---
>> drivers/clk/bcm/clk-bcm2835.c | 17 +++++++++++++++++
>> 1 file changed, 17 insertions(+)
>> 
>> Note: This requires the CLK_ENABLE_HAND_OFF patch to be applied.
>> 
>> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
>> index 0fc71cb..0663b6c 100644
>> --- a/drivers/clk/bcm/clk-bcm2835.c
>> +++ b/drivers/clk/bcm/clk-bcm2835.c
>> @@ -1211,6 +1211,15 @@ bcm2835_register_pll_divider(struct bcm2835_cprman *cprman,
>>    divider->cprman = cprman;
>>    divider->data = data;
>> 
>> +    /* if the pll-divider is running, then enable CLK_ENABLE_HAND_OFF */
>> +    if ((cprman_read(cprman, data->a2w_reg) &
>> +         A2W_PLL_CHANNEL_DISABLE) == 0) {
>> +        dev_dbg(cprman->dev,
>> +            "found firmware enabled pll_div %s - enabling hand off\n",
>> +            data->name);
>> +        init.flags |= CLK_ENABLE_HAND_OFF;
>> +    }
> 
> I don't think we want this on dividers.  There are very few cases where
> a divider will be grabbed and prepare/enabled on its own, rather than as
> a side effect of a downstream clock being needed.  So, I think the
> dividers need to stay as being enabled/disabled automatically by the
> downstream clocks, like in the v3 patch you had sent.

With dividers not handled the rmmod amba_pl011 will crash the
machine (see my other email with all those issues I have reported) - 
that is why I had to add the pll_divs as well...

There may be other scenarios that can also trigger this
kind of crash.

Only other approach might be that the firmware driver would
claim those relevant plls to keep the system stable. But the 
question is: which ones would be needed?
