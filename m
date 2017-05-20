From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 21 May 2017 03:42:10 +0900
Subject: [PATCH] ASoC: remove NULL pointer check for clk_disable_unprepare
In-Reply-To: <20170520180403.mqwfrcjsyukv3phr@kozik-lap>
References: <1495302158-30951-1-git-send-email-yamada.masahiro@socionext.com>
 <20170520180403.mqwfrcjsyukv3phr@kozik-lap>
Message-ID: <CAK7LNAR22B6EHnF=JtJ+9Veq9exgW+BB_T4zLwccFP_6C3j7xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,


2017-05-21 3:04 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
> On Sun, May 21, 2017 at 02:42:38AM +0900, Masahiro Yamada wrote:
>> After long term efforts of fixing non-common clock implementations,
>> clk_disable() is a no-op for a NULL pointer input, and this is now
>> tree-wide consistent.
>>
>> All clock consumers can safely call clk_disable(_unprepare) without
>> NULL pointer check.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  sound/soc/codecs/adau17x1.c                | 3 +--
>>  sound/soc/codecs/da7213.c                  | 3 +--
>>  sound/soc/codecs/da7218.c                  | 3 +--
>>  sound/soc/codecs/da7219-aad.c              | 5 ++---
>>  sound/soc/codecs/da7219.c                  | 3 +--
>>  sound/soc/codecs/es8328.c                  | 3 +--
>>  sound/soc/codecs/wm8731.c                  | 3 +--
>>  sound/soc/davinci/davinci-evm.c            | 3 +--
>>  sound/soc/fsl/imx-audmux.c                 | 6 ++----
>>  sound/soc/intel/boards/bytcr_rt5640.c      | 2 +-
>>  sound/soc/intel/boards/cht_bsw_rt5645.c    | 3 +--
>>  sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 6 ++----
>>  sound/soc/samsung/i2s.c                    | 3 +--
>>  13 files changed, 16 insertions(+), 30 deletions(-)
>>
>
> (...)
>
>> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
>> index af3ba4d..3a06acd 100644
>> --- a/sound/soc/samsung/i2s.c
>> +++ b/sound/soc/samsung/i2s.c
>> @@ -1122,8 +1122,7 @@ static int i2s_runtime_suspend(struct device *dev)
>>       i2s->suspend_i2scon = readl(i2s->addr + I2SCON);
>>       i2s->suspend_i2spsr = readl(i2s->addr + I2SPSR);
>>
>> -     if (i2s->op_clk)
>> -             clk_disable_unprepare(i2s->op_clk);
>> +     clk_disable_unprepare(i2s->op_clk);
>>       clk_disable_unprepare(i2s->clk);
>
> I think the check in i2s_runtime_resume() should be removed then as well
> to keep it symmetrical. Otherwise it looks suspicious.


Hmm, you have a point.  We will lose the symmetry.

If samsung/i2s.c is only used with the common clock framework,
we can omit the NULL pointer check for clk_prepare_enable()
because it is also a no-op for NULL clk input
(it returns 0).

At this moment, this is not consistent for non-common clock implementations,
though.



-- 
Best Regards
Masahiro Yamada
