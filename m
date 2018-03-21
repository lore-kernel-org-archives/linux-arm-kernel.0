From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 21 Mar 2018 17:03:21 +0200
Subject: [PATCH v2] staging: bcm2835-audio: Release resources on
 module_exit()
In-Reply-To: <1a59a938-0381-49f4-dfd9-c7a52bdb0eae@gmail.com>
References: <63ee611d-9fd7-a67a-45aa-229cc4a83ed2@gmail.com>
 <20180313193414.11535-1-k.marinushkin@gmail.com>
 <CAHp75Ve9MRAgSu74Mzr2defd84umyeKpfvX51-Qhk4SvLx3Qng@mail.gmail.com>
 <1a59a938-0381-49f4-dfd9-c7a52bdb0eae@gmail.com>
Message-ID: <CAHp75Vfwpwcc6_somOcSMYwmBhnkSwR7vn2piAZwA1GFkGAJRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 7:57 AM, Kirill Marinushkin
<k.marinushkin@gmail.com> wrote:
> On 03/13/18 22:23, Andy Shevchenko wrote:
>> On Tue, Mar 13, 2018 at 9:34 PM, Kirill Marinushkin
>> <k.marinushkin@gmail.com> wrote:
>>> In the current implementation, `rmmod snd_bcm2835` does not release
>>> resources properly. It causes an oops when trying to list sound devices.
>>>
>>> This commit fixes it.
>> Nice catch!
>>
>> See my comments below.
>>
>>>  static void snd_devm_unregister_child(struct device *dev, void *res)
>>>  {
>>>         struct device *childdev = *(struct device **)res;
>>> +       struct bcm2835_chip *chip = dev_get_drvdata(childdev);
>>> +       struct snd_card *card = chip->card;
>>> +
>>> +       snd_card_free(card);
>>> +       dev_set_drvdata(childdev, NULL);
>> AFAIU this is done by device core.
>
> Maybe you are right. But I don't know, which function in the device core does it.
> It is safe to have this line. So, I suggest to keep it.

Please, remove.
If you don't know, perhaps you need to spend more time on doing homework?

% git grep -n -w dev_set_drvdata -- drivers/base/dd.c
drivers/base/dd.c:469:          dev_set_drvdata(dev, NULL);
drivers/base/dd.c:499:  dev_set_drvdata(dev, NULL);
drivers/base/dd.c:902:          dev_set_drvdata(dev, NULL);

Last one is the point of your interest.

-- 
With Best Regards,
Andy Shevchenko
