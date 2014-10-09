From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 9 Oct 2014 19:23:53 +0800
Subject: [PATCH] gpio: pl061: hook request if gpio-ranges avaiable
In-Reply-To: <54366E68.5050804@hisilicon.com>
References: <1412847735-498-1-git-send-email-haojian.zhuang@linaro.org>
 <543665A4.6000404@hisilicon.com>
 <CAD6h2NRNCwFsQBF6z3ZrP4X6_F9cjBES4X_kYi-6Oa0vwYsp2w@mail.gmail.com>
 <54366E68.5050804@hisilicon.com>
Message-ID: <CAD6h2NT03wbxqjeCytNHYgvh3D4HCJGJ-8XZcDpUQpQr9V2XWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's good. But it's similar the one that I sent in last year. You can
check this link in below.

http://marc.info/?l=linux-gpio&m=138300092720593&w=2

My patch is used to fix this issue according to the comments.

Best Regards
Haojian

On 9 October 2014 19:15, k00278426 <kong.kongxinwei@hisilicon.com> wrote:
> hi jian
>
>      In the afternoon,we submit a patch about gpio-ranges item,we slove this issue by setting the .request pointer which is null. before coming true the
>
> pl061_gpio_request function, we slove the issue.you can study it.
>
> Best Regards
> xinwei
>
>
> On 2014/10/9 18:56, Haojian Zhuang wrote:
>> Hi Xinwei,
>>
>> Do I miss anything? At here, .request pointer isn't null. It always
>> points to pl061_gpio_request().
>>
>> Best Regards
>> Haojian
>>
>> On 9 October 2014 18:38, k00278426 <kong.kongxinwei@hisilicon.com> wrote:
>>> On 2014/10/9 17:42, Haojian Zhuang wrote:
>>>
>>> gpio-ranges property could binds gpio to pinctrl. But there may be some
>>> gpios without pinctrl operation. So check whether gpio-ranges property
>>> exists in device node first.
>>>
>>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>>> ---
>>>  drivers/gpio/gpio-pl061.c | 21 +++++++++++++++------
>>>  1 file changed, 15 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
>>> index 84b49cf..d1813f0 100644
>>> --- a/drivers/gpio/gpio-pl061.c
>>> +++ b/drivers/gpio/gpio-pl061.c
>>> @@ -52,28 +52,34 @@ struct pl061_gpio {
>>>
>>>   void __iomem *base;
>>>   struct gpio_chip gc;
>>> + int uses_pinctrl;
>>>
>>>  #ifdef CONFIG_PM
>>>   struct pl061_context_save_regs csave_regs;
>>>  #endif
>>>  };
>>>
>>> -static int pl061_gpio_request(struct gpio_chip *chip, unsigned offset)
>>> +static int pl061_gpio_request(struct gpio_chip *gc, unsigned offset)
>>>  {
>>>   /*
>>>   * Map back to global GPIO space and request muxing, the direction
>>>   * parameter does not matter for this controller.
>>>   */
>>> - int gpio = chip->base + offset;
>>> + struct pl061_gpio *chip = container_of(gc, struct pl061_gpio, gc);
>>> + int gpio = gc->base + offset;
>>>
>>> - return pinctrl_request_gpio(gpio);
>>> + if (chip->uses_pinctrl)
>>> + return pinctrl_request_gpio(gpio);
>>> + return 0;
>>>  }
>>>
>>>        In the request_gpio process,if the .request point is null,the  return
>>> of request_gpio process will value 0. the request_gpio process will not
>>> enter the pintrcl system.
>>>   so the request_gpio have deal with the "if" branch.
>>>
>>>
>>> -static void pl061_gpio_free(struct gpio_chip *chip, unsigned offset)
>>> +static void pl061_gpio_free(struct gpio_chip *gc, unsigned offset)
>>>  {
>>> - int gpio = chip->base + offset;
>>> + struct pl061_gpio *chip = container_of(gc, struct pl061_gpio, gc);
>>> + int gpio = gc->base + offset;
>>>
>>> - pinctrl_free_gpio(gpio);
>>> + if (chip->uses_pinctrl)
>>> + pinctrl_free_gpio(gpio);
>>>  }
>>>
>>>  static int pl061_direction_input(struct gpio_chip *gc, unsigned offset)
>>> @@ -264,6 +270,9 @@ static int pl061_probe(struct amba_device *adev, const
>>> struct amba_id *id)
>>>
>>>   spin_lock_init(&chip->lock);
>>>
>>> + /* Hook the request()/free() for pinctrl operation */
>>> + if (of_property_read_bool(dev->of_node, "gpio-ranges"))
>>> + chip->uses_pinctrl = true;
>>>   chip->gc.request = pl061_gpio_request;
>>>   chip->gc.free = pl061_gpio_free;
>>>   chip->gc.direction_input = pl061_direction_input;
>>>
>>>
>> .
>>
>
>
