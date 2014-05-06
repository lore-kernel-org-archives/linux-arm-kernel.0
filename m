From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 6 May 2014 18:04:45 +0200
Subject: mx6qsabresd hangs on linux-next
In-Reply-To: <CAOMZO5Dx0JMj3dZ7BSgaYSZZ=ZKRqQHEYWj5sb6z_9jc+cpsEw@mail.gmail.com>
References: <CAOMZO5DMEqs=zzNGqgKjK7wTJdiNPgEqxsX=TtqKrnpLMzpbDw@mail.gmail.com>	<20140506141310.GA2794@dragon>	<CAOMZO5DH5d_L-deVu=XmBo9ekq+-g704p7cyayLvp=43bnEccQ@mail.gmail.com>
 <CAOMZO5Dx0JMj3dZ7BSgaYSZZ=ZKRqQHEYWj5sb6z_9jc+cpsEw@mail.gmail.com>
Message-ID: <5369081D.5030400@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 05/06/2014 05:49 PM, Fabio Estevam wrote:
> On Tue, May 6, 2014 at 12:36 PM, Fabio Estevam <festevam@gmail.com> wrote:
>
>> Indeed, if I revert:
>>
>> commit e7489693b3a853ab6dfad52f7e6af553ae8d3f28
>> Author: Maxime COQUELIN <maxime.coquelin@st.com>
>> Date:   Wed Jan 29 17:24:08 2014 +0100
>>
>>      clk: divider: Optimize clk_divider_bestdiv loop
>>
>>      Currently, the for-loop used to try all the different dividers to find the
>>      one that best fit tries all the values from 1 to max_div,
>> incrementing by one.
>>      In case of power-of-two, or table based divider, the loop isn't optimal.
>>
>>      Instead of incrementing by one, this patch provides directly the
>> next divider.
>>
>>      Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
>>      Signed-off-by: Mike Turquette <mturquette@linaro.org>
>>
>> Then the board does not hang.
>
> Isn't the increment of i missing?

i is incremented in _next_div():

+static int _next_div(struct clk_divider *divider, int div)
+{
+	div++;
+
+	if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
+		return __roundup_pow_of_two(div);
+	if (divider->table)
+		return _round_up_table(divider->table, div);
+
+	return div;
+}

Could you tell me which kind of divider it is? pow2, table, linear?

>
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -279,7 +279,7 @@ static int clk_divider_bestdiv(struct clk_hw *hw,
> unsigned long rate,
>           */
>          maxdiv = min(ULONG_MAX / rate, maxdiv);
>
> -       for (i = 1; i <= maxdiv; i = _next_div(divider, i)) {
> +       for (i = 1; i <= maxdiv; i +=_next_div(divider, i)) {
This would break power-of-two, and table based dividers.

>                  if (!_is_valid_div(divider, i))
>                          continue;
>                  if (rate * i == parent_rate_saved) {
>

Regards,
Maxime
