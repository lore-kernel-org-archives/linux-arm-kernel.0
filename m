From: yadi.brar01@gmail.com (Yadwinder Singh Brar)
Date: Thu, 30 May 2013 12:25:40 +0530
Subject: [PATCH v2 2/5] clk: samsung: Add support to register rate_table
 for PLL3xxx
In-Reply-To: <CAD=FV=VDi+SfebiFnPNp8qR__9L=o9TJ+WSPRfRQLX+p+TMmJw@mail.gmail.com>
References: <1369834677-20312-1-git-send-email-vikas.sajjan@linaro.org>
 <1369834677-20312-3-git-send-email-vikas.sajjan@linaro.org>
 <CAD=FV=VDi+SfebiFnPNp8qR__9L=o9TJ+WSPRfRQLX+p+TMmJw@mail.gmail.com>
Message-ID: <CAKew6eVGnHNN7Fk=sqzE1iV+SFtJ1z4k1freeWdbGaYPXqpUvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On Thu, May 30, 2013 at 5:14 AM, Doug Anderson <dianders@chromium.org> wrote:
> Vikas / Yadwinder,
>
> On Wed, May 29, 2013 at 6:37 AM, Vikas Sajjan <vikas.sajjan@linaro.org> wrote:
>> From: Yadwinder Singh Brar <yadi.brar@samsung.com>
>>
>> This patch defines a common rate_table which will contain recommended p, m, s,
>> k values for supported rates that needs to be changed for changing
>> corresponding PLL's rate.
>>
>> Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
>> ---
>>  drivers/clk/samsung/clk-exynos4.c    |    8 ++++----
>>  drivers/clk/samsung/clk-exynos5250.c |   14 +++++++-------
>>  drivers/clk/samsung/clk-pll.c        |   14 ++++++++++++--
>>  drivers/clk/samsung/clk-pll.h        |   33 +++++++++++++++++++++++++++++++--
>>  4 files changed, 54 insertions(+), 15 deletions(-)
>
> I also reviewed this in our gerrit
> <https://gerrit.chromium.org/gerrit/#/c/56742/>, but I'll summarize
> here for the list...
>
>>  struct clk * __init samsung_clk_register_pll35xx(const char *name,
>> -                       const char *pname, const void __iomem *base)
>> +                       const char *pname, const void __iomem *base,
>> +                       const struct samsung_pll_rate_table *rate_table,
>> +                       const unsigned int rate_count)
>
> Feels like you should document here that rate_table needs to be sorted
> and the sort order.
>

sure,  we will add comment  to sort the table in descending order.

>> +struct samsung_pll_rate_table {
>> +       unsigned  int rate;
>
> nit: extra space before "int" should be removed.
>

ok

> Also: you can include rate here if you need a convenient place to
> store it (which sadly means that this structure can't be const).
> ...but I do like Tomasz's idea of actually calculating it.  You can't
> know it at compile time since the parent rate comes from the device
> tree.
>
> compatible = "samsung,clock-xxti";
> clock-frequency = <24000000>;
>

Actually this table should contain the recommended values
and if we see the user manual, the input(parent) rate is also a part
of recommended
table of different output rate for a particular PLL for that SoC.

So as Tomasz said input(parent) rate may change with board,
then, do those corresponding recommended p, m, s, k will be valid?

In case, input(parent) rate changes then we may need different set of p, m ,s, k
values recommended for new input rate to get required(recommended to
use) output rate.

So, we think its better that the p, m, s and k along with the parent
is known at the compile time ( or DT ?),
as these p, m, s, k values are very much coupled with the parent rate
to achieve the
 required(recommended to use) output rate.

Also, since the sorted table is required (sorted based on "rate"),
its better to have the rate in a const rate table.

And the whole set of recommended values should come from same place(DT
or static table),
to keep the things simple and consistent.

Moreover, practically for a particular SoC , we use the recommended
input(parent) rate only for a PLL.
So we should keep the things simple here presently.

>> +       unsigned int pdiv;
>> +       unsigned int mdiv;
>> +       unsigned int sdiv;
>> +       unsigned int kdiv;
>
> I think kdiv is signed.
>

No, as these values should be the recommended values to be written in
corresponding  register bits. So it should remain unsigned.

K value should be considered as negative only while recalculating rate.

As per exynos5250 user manual's section 7.3.2 :
" K value description "Postive value (Negative value)":
Postive values is that you should write EPLLCON/VPLLCON register.
Negative value is that you can calculate PLL output frequency with it."

> -Doug

Regards,
Yadwinder & Vikas.
