From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 12 Feb 2014 19:41:35 -0800
Subject: [PATCH] input: sirfsoc-onkey - report onkey untouch event by
 detecting pin status
In-Reply-To: <CAGsJ_4wzQYmNkd421vzau5BiTyewRX=vzEiy=BiSnttb+rEC8Q@mail.gmail.com>
References: <1392026859-4977-1-git-send-email-21cnbao@gmail.com>
 <20140212231131.GA29769@core.coreip.homeip.net>
 <CAGsJ_4wzQYmNkd421vzau5BiTyewRX=vzEiy=BiSnttb+rEC8Q@mail.gmail.com>
Message-ID: <892ec8be-638e-48d6-9e7d-5175694a7eaf@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On February 12, 2014 6:32:03 PM PST, Barry Song <21cnbao@gmail.com> wrote:
>2014-02-13 7:11 GMT+08:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>> Hi Barry,
>>
>> On Mon, Feb 10, 2014 at 06:07:39PM +0800, Barry Song wrote:
>>>
>>>  static int sirfsoc_pwrc_remove(struct platform_device *pdev)
>>>  {
>>> +     struct sirfsoc_pwrc_drvdata *pwrcdrv =
>dev_get_drvdata(&pdev->dev);
>>> +
>>>       device_init_wakeup(&pdev->dev, 0);
>>>
>>> +     cancel_delayed_work_sync(&pwrcdrv->work);
>>> +
>>
>> This is racy: interrupt is freed later and can schedule work again.
>
>thanks, Dmitry. i will do a manual devm_free_irq() before cancelling
>the work and before devres removes the resources.

Another option would be to use devm custom action to ensure that work is canceled after freeing IRQ.


-- 
Dmitry
