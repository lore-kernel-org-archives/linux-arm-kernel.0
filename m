From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 Aug 2017 10:16:55 +0200
Subject: [PATCH 3/4] mfd: db8500-prcmu: Get rid of cpufreq dependency
In-Reply-To: <20170814070740.eezm4wiilb25w7ze@dell>
References: <20170810125221.25818-1-linus.walleij@linaro.org>
 <20170810125221.25818-4-linus.walleij@linaro.org>
 <20170814070740.eezm4wiilb25w7ze@dell>
Message-ID: <CACRpkdZ=H0NNFcyXvZk2qqRSLqkSHwnUkyfx5EFtKVnPPgRCPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 9:07 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 10 Aug 2017, Linus Walleij wrote:
>
>> The ARMSS clock, also known as the operating point of the
>> CPU, should not cross-depend on cpufreq like this. Move
>> the code to use just frequencies and remove the false
>> frequency (1GHz) and put in the actual frequency provided
>> by the ARMSS clock (998400000 Hz) as part of the process.
>>
>> After this and the related cpufreq patch, the DB8500 will
>> simply use the standard DT cpufreq driver to change the
>> operating points through the common clock framework using
>> the ARMSS clock.
>>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

>>  drivers/mfd/db8500-prcmu.c | 59 +++++++++++++---------------------------------
>>  1 file changed, 17 insertions(+), 42 deletions(-)
>
> Make sure this passes checkpatch.pl.

Sure thing :)
$ scripts/checkpatch.pl
cpufreq/0003-mfd-db8500-prcmu-Get-rid-of-cpufreq-dependency.patch
total: 0 errors, 0 warnings, 112 lines checked

cpufreq/0003-mfd-db8500-prcmu-Get-rid-of-cpufreq-dependency.patch has
no obvious style problems and is ready for submission.

>> +     int i;
>>
>>       /* Find the corresponding arm opp from the cpufreq table. */
>> -     cpufreq_for_each_entry(pos, db8500_cpufreq_table)
>> -             if (pos->frequency == rate)
>> +     for (i = 0; i < ARRAY_SIZE(armss_freqs); i++) {
>> +             freq = armss_freqs[i];
>> +             if (rate == freq)
>>                       break;
>> +     }
>
> Why don't you just call round_armss_rate()?

It's because I need the index of the located frequency (i), and the other
function due to being called from the clock framework has to have
that simple signature.

> Once fixed please apply my:
>
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

OK thanks!

Yours,
Linus Walleij
