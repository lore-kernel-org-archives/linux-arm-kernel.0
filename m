From: padma.kvr@gmail.com (Padma Venkat)
Date: Tue, 7 May 2013 16:42:40 +0530
Subject: [PATCH] ASoC: Samsung: i2s: Fix crash in i2s driver
In-Reply-To: <2286960.PxJxnETVLS@amdc1227>
References: <1367897941-18439-1-git-send-email-padma.v@samsung.com>
 <2286960.PxJxnETVLS@amdc1227>
Message-ID: <CAAgF-BcgtjKPoSy8SPsk3WnS8T3P9f=5U2tt3WHb0fFM=M61+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Tue, May 7, 2013 at 3:20 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Padmavathi,
>
> On Tuesday 07 of May 2013 09:09:01 Padmavathi Venna wrote:
>> This patch fixes a null pointer deference in i2s driver in DT
>> case
>>
>> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
>> ---
>>
>> This patch is dependent on below patch posted by Thomas Abraham.
>> https://patchwork.kernel.org/patch/2224801/
>>
>>  sound/soc/samsung/i2s.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
>> index 7ce7c50..eaf6439 100644
>> --- a/sound/soc/samsung/i2s.c
>> +++ b/sound/soc/samsung/i2s.c
>> @@ -1182,7 +1182,7 @@ static int samsung_i2s_probe(struct platform_device
>> *pdev) pri_dai->sec_dai = sec_dai;
>>       }
>>
>> -     if (i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
>> +     if (i2s_pdata && i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
>
> This is a problem that needs to be fixed indeed. However the same problem
> exists in samsung_i2s_remove() as well (at least in latest linux-next).

This will go off once Thomas "ASoC: samsung: let device core setup the
default pin configuration"
patch get merged.

>
> This makes me wonder what happens with i2s_pdata in DT case. Most of drivers
> allocate a pdata struct anyway and fill it with data parsed from device tree.
> This allows rest of the code to remain unmodified and consider DT and non-DT
> cases equal.

This driver doesn't allocate the i2s_pdata in DT case. It directly
parse the information form DT file
and assign that information to i2s_dai.

Thanks
Padma

>
> Best regards,
> --
> Tomasz Figa
> Samsung Poland R&D Center
> SW Solution Development, Kernel and System Framework
>
