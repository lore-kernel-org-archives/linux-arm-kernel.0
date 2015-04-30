From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 30 Apr 2015 20:44:03 +0200
Subject: [PATCH 3/4] clk: si5351: Do not pass struct clk in platform_data
In-Reply-To: <20150430183043.GA21890@deathray>
References: <1430415954-29517-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1430415954-29517-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <CAOMZO5BYnE2epGrWbnNnaqEt1r6+xoPYWKtjc8w-Ze22aitgXA@mail.gmail.com>
 <20150430183043.GA21890@deathray>
Message-ID: <554277F3.7060500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.04.2015 20:30, Michael Welling wrote:
> On Thu, Apr 30, 2015 at 03:20:38PM -0300, Fabio Estevam wrote:
>> On Thu, Apr 30, 2015 at 2:45 PM, Sebastian Hesselbarth
>> <sebastian.hesselbarth@gmail.com> wrote:
>>> @@ -1328,8 +1321,17 @@ static int si5351_i2c_probe(struct i2c_client *client,
>>>          i2c_set_clientdata(client, drvdata);
>>>          drvdata->client = client;
>>>          drvdata->variant = variant;
>>> -       drvdata->pxtal = pdata->clk_xtal;
>>> -       drvdata->pclkin = pdata->clk_clkin;
>>> +       drvdata->pxtal = devm_clk_get(&client->dev, "xtal");
>>> +       drvdata->pclkin = devm_clk_get(&client->dev, "clkin");
>>> +
>>> +       if (PTR_ERR(drvdata->pxtal) == -EPROBE_DEFER ||
>>> +           PTR_ERR(drvdata->pclkin) == -EPROBE_DEFER)
>>> +               return -EPROBE_DEFER;
>>> +
>>> +       if (IS_ERR(drvdata->pxtal) && IS_ERR(drvdata->pclkin)) {
>>
>> Don't you want || instead?
>
> I doubt it. He is checking if both are not available.
>
> The driver could work with only one of them.
>
> If you use || then you assume to need both.

Fabio,

Michael is right, the check is for bailing out if none of the parent
clocks is available.

But thanks for looking at it and I appreciate the review.

Sebastian
