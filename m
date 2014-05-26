From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Mon, 26 May 2014 09:31:56 +0200
Subject: [PATCH] clk: divider: Fix table round up function
In-Reply-To: <20140523213915.23136.16939@quantum>
References: <1399481332-9550-1-git-send-email-maxime.coquelin@st.com>
 <20140523213915.23136.16939@quantum>
Message-ID: <5382EDEC.9040503@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/23/2014 11:39 PM, Mike Turquette wrote:
> Quoting Maxime COQUELIN (2014-05-07 09:48:52)
>> Commit 1d9fe6b97 ("clk: divider: Fix best div calculation for power-of-two and
>> table dividers") introduces a regression in its _table_round_up function.
>>
>> When the divider passed to this function is greater than the max divider
>> available in the table, this function returns table's max divider.
>> Problem is that it causes an infinite loop in clk_divider_bestdiv() because
>> _next_div() will never return a value greater than maxdiv.
>>
>> Instead of returning table's max divider, this patch returns INT_MAX.
>>
>> Reported-by: Fabio Estevam <festevam@gmail.com>
>> Reported-by: Shawn Guo <shawn.guo@freescale.com>
>> Tested-by: Fabio Estevam <festevam@gmail.com>
>> Cc: Mike Turquette <mike.turquette@linaro.org>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
>
> Pulled into clk-fixes for -rc7.

Thanks Mike.

Regards,
Maxime

>
> Regards,
> Mike
>
>> ---
>>   drivers/clk/clk-divider.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
>> index b3c8396..cf9114a 100644
>> --- a/drivers/clk/clk-divider.c
>> +++ b/drivers/clk/clk-divider.c
>> @@ -158,7 +158,7 @@ static bool _is_valid_div(struct clk_divider *divider, unsigned int div)
>>   static int _round_up_table(const struct clk_div_table *table, int div)
>>   {
>>          const struct clk_div_table *clkt;
>> -       int up = _get_table_maxdiv(table);
>> +       int up = INT_MAX;
>>
>>          for (clkt = table; clkt->div; clkt++) {
>>                  if (clkt->div == div)
>> --
>> 1.9.1
>>
