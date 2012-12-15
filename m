From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 16 Dec 2012 00:41:29 +0800
Subject: [PATCH] clk: factor: calculate rate by do_div
In-Reply-To: <CAN1soZze6Ogn_zi7JJN0JNzoMFkHLJyKyjTV7rSWUmQhwRU0NQ@mail.gmail.com>
References: <1354522477-11991-1-git-send-email-haojian.zhuang@gmail.com>
 <CAN1soZze6Ogn_zi7JJN0JNzoMFkHLJyKyjTV7rSWUmQhwRU0NQ@mail.gmail.com>
Message-ID: <CAN1soZxJ_JCEVV5v99tFi22fq5AEOCBj1D5PY=vmGGW_gDWuJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 4, 2012 at 9:32 AM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> On Mon, Dec 3, 2012 at 4:14 PM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
>> clk->rate = parent->rate / div * mult
>>
>> The formula is OK. But it may overflow while we do operate with
>> unsigned long. So use do_div instead.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
>> ---
>>  drivers/clk/clk-fixed-factor.c |    5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
>> index a489985..1ef271e 100644
>> --- a/drivers/clk/clk-fixed-factor.c
>> +++ b/drivers/clk/clk-fixed-factor.c
>> @@ -28,8 +28,11 @@ static unsigned long clk_factor_recalc_rate(struct clk_hw *hw,
>>                 unsigned long parent_rate)
>>  {
>>         struct clk_fixed_factor *fix = to_clk_fixed_factor(hw);
>> +       unsigned long long int rate;
>>
>> -       return parent_rate * fix->mult / fix->div;
>> +       rate = (unsigned long long int)parent_rate * fix->mult;
>> +       do_div(rate, fix->div);
>> +       return (unsigned long)rate;
>>  }
>>
>>  static long clk_factor_round_rate(struct clk_hw *hw, unsigned long rate,
>> --
>> 1.7.10.4
>>
>
> Correct Mike's email address.

Any comments? Does it mean that nobody want to fix the bug?
