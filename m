From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 22 Nov 2015 22:41:43 +0200
Subject: [PATCH V6 2/3] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <565bdce834ba1cf4a73029b5c027856e.squirrel@www.codeaurora.org>
References: <1448210257-4768-1-git-send-email-okaya@codeaurora.org>
 <1448210257-4768-3-git-send-email-okaya@codeaurora.org>
 <CAHp75Vc72HLbNdPKXzm=RqsFZS1cmAVuH3Nd6yO+TJidLeuExg@mail.gmail.com>
 <565bdce834ba1cf4a73029b5c027856e.squirrel@www.codeaurora.org>
Message-ID: <CAHp75VdAdrbQv1EY+KDsoAbyGURxfr+3c5f=-w=OR4MhBoWDHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 22, 2015 at 9:52 PM,  <okaya@codeaurora.org> wrote:
>> On Sun, Nov 22, 2015 at 6:37 PM, Sinan Kaya <okaya@codeaurora.org> wrote:

[]

>>> +       if (!is_power_of_2(mgmtdev->max_write_request) ||
>>> +               (mgmtdev->max_write_request < 128) ||
>>
>> Someone likes parens.
>
> yes, I do. I don't trust compilers and also don't like to open holes for
> people making quick changes to code while ignoring the operator precedence for
> maintenance reasons.

Btw in the other patch you did something like

var xyz;

? == (xyz)

which has nothing to do with operator precedence.

And if a compiler or static analyzer is in doubt it issues a warning / error.

>> I might agree with these cases, but below in assignments and combined
>> operations the parens are indeed redundant.
>>
>
> OK. I think we are already in personal style of code zone now.

Yes and no.

> I have already
> broken another review because you don't like for loops but rather have a while
> loop.

In that case (IIRC) the for-loop use to be too verbose instead of
simple (--i >= 0). For sake of readability and maintenance.

> I'll leave ifs and change the assignments only. I'll need your reviewed-by
> once you are happy.

OK.

>>> +       pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
>>> +       pm_runtime_use_autosuspend(&pdev->dev);
>>> +       pm_runtime_set_active(&pdev->dev);
>>> +       pm_runtime_enable(&pdev->dev);
>>> +       pm_runtime_get_sync(&pdev->dev);
>>
>> +empty line
>
> added a new line for you. I don't know why.

Readability and logical break of the blocks: a) runtime PM, b)
platform resource management.
Do you agree?

>>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +       virtaddr = devm_ioremap_resource(&pdev->dev, res);
>>> +       if (IS_ERR(virtaddr)) {
>>> +               rc = -ENOMEM;
>>> +               goto out;
>>> +       }

[]

>>> +       unsigned int i;
>>> +       int rc;
>>> +
>>> +       for (i = 0; i < ARRAY_SIZE(files); i++) {
>>> +               rc = create_sysfs_entry(dev, files[i].name, files[i].mode);
>>> +               if (rc)
>>> +                       return rc;
>>> +       }
>>> +
>>
>> Can it be like
>>
>> /sys/?/DEVICExx/
>>  channelYY/
>>  attr1
>>  attr2
>>  ?
>>
>> ?
>
> I'll work on it. I didn't know that you are allowed to create subdirectories
> in sysfs. I was just creating attributes to keep it simple. But, your
> suggestion is cleaner.
>
>>
>> I think it will be easier to handle in code and from user. (Similar
>> way DMAEngine API does for slave DMA devices)
>
> Now, the good stuff. Can you clarify your comment? I didn't understand it.

I meant that DMAEngine uses
/sys/class/dma
 dmaYchannelX/
  attr1
  attr2
  ?

layout.

-- 
With Best Regards,
Andy Shevchenko
