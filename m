From: kernel@martin.sperl.org (Martin Sperl)
Date: Thu, 28 Apr 2016 22:56:29 +0200
Subject: [PATCH V3] clk: bcm2835: mark enabled clocks with
 CLK_ENABLE_HAND_OFF
In-Reply-To: <87d1p9v5z5.fsf@eliezer.anholt.net>
References: <1461770664-29384-1-git-send-email-kernel@martin.sperl.org>
 <87d1p9v5z5.fsf@eliezer.anholt.net>
Message-ID: <66DC3759-FEAB-4B65-BAB4-94D0C2BD70F8@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 28.04.2016, at 22:22, Eric Anholt <eric@anholt.net> wrote:
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
>> So during probing we check if the clock is enabled
>> and if it is then mark that clock with CLK_ENABLE_HAND_OFF.
>> As a consequence this will also enable the corresponding
>> parent plls and pll-divs.
>> 
>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>> 
>> --
> 
>> ---
>> drivers/clk/bcm/clk-bcm2835.c | 8 ++++++++
>> 1 file changed, 8 insertions(+)
>> 
>> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
>> index 35f8de7..65d62c2 100644
>> --- a/drivers/clk/bcm/clk-bcm2835.c
>> +++ b/drivers/clk/bcm/clk-bcm2835.c
>> @@ -1251,7 +1251,14 @@ static struct clk *bcm2835_register_clock(struct bcm2835_cprman *cprman,
>>        init.flags |= CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
>>    }
>> 
>> +    /* if the clock is running then enable HAND_OFF */
>> +    if (cprman_read(cprman, data->ctl_reg) & CM_ENABLE) {
>> +        dev_info(cprman->dev,
>> +             "found enabled clock %s - enabling hand off\n",
>> +             data->name);
>> +        init.flags |= CLK_ENABLE_HAND_OFF;
>> +    }
>> +
> 
> The debug shouldn't be at dev_info() level, but other than that this
> seems like a good plan once CLK_ENABLE_HAND_OFF lands.

Until that point in time we can make those clocks critical.

I could split it into a 2 part patch first with critical and when we
have hand off then we can apply the second part that moves to
hand-off.

That way the current issue is solved - even if in a sub-optimal way.
But the path forward is shown.

Should I do this?

Martin
