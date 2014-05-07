From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 7 May 2014 10:32:35 +0200
Subject: mx6qsabresd hangs on linux-next
In-Reply-To: <20140507033223.GB2798@dragon>
References: <CAOMZO5DMEqs=zzNGqgKjK7wTJdiNPgEqxsX=TtqKrnpLMzpbDw@mail.gmail.com>
 <20140506141310.GA2794@dragon>
 <CAOMZO5DH5d_L-deVu=XmBo9ekq+-g704p7cyayLvp=43bnEccQ@mail.gmail.com>
 <CAOMZO5Dx0JMj3dZ7BSgaYSZZ=ZKRqQHEYWj5sb6z_9jc+cpsEw@mail.gmail.com>
 <5369081D.5030400@st.com> <20140506200029.GD5858@pengutronix.de>
 <20140507020950.GB2794@dragon> <20140507033223.GB2798@dragon>
Message-ID: <5369EFA3.8070908@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 05/07/2014 05:32 AM, Shawn Guo wrote:
...
>>>
>>> Here when a table entry matches the input div this function will return
>>> exactly the input div. This means _next_div() will always return the
>>> same value and clk_divider_bestdiv() has an infinite loop:
>>>
>>> 	for (i = 1; i <= maxdiv; i = _next_div(divider, i)) {
>>> 		...
>>> 	}
>>
>> Hmmm, isn't the first thing that _next_div() does to increment the input
>> div?
>
> I think the infinite loop happens in this case because "i" will never
> exceed maxdiv for a table divider.

You are right. Sorry for the regression.

I thought I tested it, as I had some table-based dividers in my test setup.
After checking again, it appears that I didn't had the 
CLK_SET_RATE_PARENT flag set on these clocks, so I didn't entered the 
for loop...

Could the fix be to initialize "up" variable to INT_MAX in 
_round_up_table (see below)?

I can send the patch if you are fine with it.
I have no hardware to test on this week, I only have compiled this 
patch, not tested it.

Thanks,
Maxime

>
> Shawn
>


diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index b3c8396..cf9114a 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -158,7 +158,7 @@ static bool _is_valid_div(struct clk_divider 
*divider, unsigned int div)
  static int _round_up_table(const struct clk_div_table *table, int div)
  {
         const struct clk_div_table *clkt;
-       int up = _get_table_maxdiv(table);
+       int up = INT_MAX;

         for (clkt = table; clkt->div; clkt++) {
                 if (clkt->div == div)
