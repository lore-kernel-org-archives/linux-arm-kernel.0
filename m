From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 17 Oct 2018 11:10:57 +0200
Subject: [PATCH 3/3] drivers: use probe_err function in obvious cases
In-Reply-To: <CAHp75VeZEtG7f3WmgvLrirReSwgbOQDp1qiBZ47652poMw8BUQ@mail.gmail.com>
References: <CGME20181016072250eucas1p1a763670c8509d20a6e6847eadb246817@eucas1p1.samsung.com>
 <20181016072244.1216-1-a.hajda@samsung.com>
 <20181016072244.1216-4-a.hajda@samsung.com>
 <CAHp75VeZEtG7f3WmgvLrirReSwgbOQDp1qiBZ47652poMw8BUQ@mail.gmail.com>
Message-ID: <20181017091059eucas1p2919e8b5984d4b8998438251a26987068~eWli2LsTV3025130251eucas1p2r@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.10.2018 15:51, Andy Shevchenko wrote:
> On Tue, Oct 16, 2018 at 10:22 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>> The patch replaces obviously matching code with probe_err function.
>> There are many more places where probe_err could be used.
>> The patch shows how the new function should be used, and how it
>> improves the code.
>> --- a/drivers/gpio/gpio-pca953x.c
>> +++ b/drivers/gpio/gpio-pca953x.c
>> @@ -824,9 +824,7 @@ static int pca953x_probe(struct i2c_client *client,
>>         reg = devm_regulator_get(&client->dev, "vcc");
>>         if (IS_ERR(reg)) {
>>                 ret = PTR_ERR(reg);
>> -               if (ret != -EPROBE_DEFER)
>> -                       dev_err(&client->dev, "reg get err: %d\n", ret);
>> -               return ret;
>> +               return probe_err(&client->dev, ret, "reg get err: %d\n", ret);
> No need to assign ret above.
> As I mentioned, better to print a value for everyone.

OK.

Thanks for all reviews. I have posted v2 of patches 1 and 2 as replies
in this thread.
As patch 3 requires splitting, adjusting arguments of probe_err (remove
err and newline), and depends on patch 1 I will prepare it and post
later, probably next cycle as suggested Javier.

Regards
Andrzej


>
>>         }
> Please, split it at least one patch per subsystem.
>
