From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 5 Dec 2016 10:07:46 +0100
Subject: [PATCH v2 3/3] ARM: da850: fix da850_set_pll0rate()
In-Reply-To: <130825f1-5c8f-f6bc-1f27-929ff591a9c3@ti.com>
References: <1480693134-31324-1-git-send-email-bgolaszewski@baylibre.com>
 <1480693134-31324-4-git-send-email-bgolaszewski@baylibre.com>
 <130825f1-5c8f-f6bc-1f27-929ff591a9c3@ti.com>
Message-ID: <CAMpxmJWCmhKvM=Dgn+bnFfnuO9NGghPURVXuzxW2Vym0Y-akOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-12-05 9:45 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
> On Friday 02 December 2016 09:08 PM, Bartosz Golaszewski wrote:
>> This function is broken - its second argument is an index to the freq
>> table, not the requested clock rate in Hz. It leads to an oops when
>> called from clk_set_rate() since this argument isn't bounds checked
>> either.
>>
>> Fix it by iterating over the array of supported frequencies and
>> selecting a one that matches or returning -EINVAL for unsupported
>> rates.
>>
>> Also: update the davinci cpufreq driver. It's the only user of this
>> clock and currently it passes the cpufreq table index to
>> clk_set_rate(), which is confusing. Make it pass the requested clock
>> rate in Hz.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  arch/arm/mach-davinci/da850.c     | 22 ++++++++++++++++++----
>>  drivers/cpufreq/davinci-cpufreq.c |  2 +-
>>  2 files changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
>> index a55101c..92e3303 100644
>> --- a/arch/arm/mach-davinci/da850.c
>> +++ b/arch/arm/mach-davinci/da850.c
>> @@ -1179,14 +1179,28 @@ static int da850_set_armrate(struct clk *clk, unsigned long index)
>>       return clk_set_rate(pllclk, index);
>>  }
>>
>> -static int da850_set_pll0rate(struct clk *clk, unsigned long index)
>> +static int da850_set_pll0rate(struct clk *clk, unsigned long rate)
>>  {
>> -     unsigned int prediv, mult, postdiv;
>> -     struct da850_opp *opp;
>>       struct pll_data *pll = clk->pll_data;
>> +     struct cpufreq_frequency_table *freq;
>> +     unsigned int prediv, mult, postdiv;
>> +     struct da850_opp *opp = NULL;
>>       int ret;
>>
>> -     opp = (struct da850_opp *) cpufreq_info.freq_table[index].driver_data;
>> +     for (freq = da850_freq_table;
>> +          freq->frequency != CPUFREQ_TABLE_END; freq++) {
>> +             /* requested_rate is in Hz, freq->frequency is in KHz */
>> +             unsigned long freq_rate = freq->frequency * 1000;
>
> A small optimization here. Instead of multiplying potentially every
> frequency in the table by 1000, you could divide the incoming rate down
> to KHz. This will also avoid the need for 'freq_rate'. Should have
> noticed this earlier. Sorry about that.
>
> Thanks,
> Sekhar

I thought about it, but figured the multiplication would be safer. I
will change it if you prefer this version.

Best regards,
Bartosz Golaszewski
