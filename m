From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 18 Oct 2009 02:43:38 -0400
Subject: [PATCH] pxa: extend gpio pins from 128 to 256
In-Reply-To: <f17812d70910172303l6cf6693bxabb2fed121cd33f4@mail.gmail.com>
References: <771cded00909250339g1b894557v6cabf978fa11e470@mail.gmail.com>
	<f17812d70910150401q425b47e2hb4da64bb203dc770@mail.gmail.com>
	<771cded00910172201k6cf7c8c7ue7485c4c876e8123@mail.gmail.com>
	<f17812d70910172303l6cf6693bxabb2fed121cd33f4@mail.gmail.com>
Message-ID: <771cded00910172343s525e527flc4e06582b9951e47@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 18, 2009 at 2:03 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Sun, Oct 18, 2009 at 1:01 PM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>> On Thu, Oct 15, 2009 at 7:01 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
>>> Haojian,
>>>
>>> Sorry for late reply. See my comments below:
>>>
>>>> Subject: [PATCH] pxa: extend gpio pins from 128 to 256
>>>>
>>>> GPIO pins exceeds 128 pins. So extend the maximum GPIO pins to 256.
>>>> And extend MFP pins also.
>>>>
>>>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>>>> ---
>>>> diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach-pxa/mfp-pxa2xx.c
>>>> index cf6b720..767db92 100644
>>>> --- a/arch/arm/mach-pxa/mfp-pxa2xx.c
>>>> +++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
>>>> @@ -41,7 +41,7 @@ struct gpio_desc {
>>>> ???? unsigned long??? config;
>>>> ?};
>>>>
>>>> -static struct gpio_desc gpio_desc[MFP_PIN_GPIO127 + 1];
>>>> +static struct gpio_desc gpio_desc[MFP_PIN_GPIO255 + 1];
>>>>
>>>
>>> I'm not sure if this is really necessary since mfp-pxa2xx.c is pxa2xx specific,
>>> and extending the array by double means wasting of space?
>>>
>>>> ?static unsigned long gpdr_lpm[4];
>>>>
>>>> @@ -117,7 +117,7 @@ static inline int __mfp_validate(int mfp)
>>>> ?{
>>>> ???? int gpio = mfp_to_gpio(mfp);
>>>>
>>>> -??? if ((mfp > MFP_PIN_GPIO127) || !gpio_desc[gpio].valid) {
>>>> +??? if ((mfp > MFP_PIN_GPIO255) || !gpio_desc[gpio].valid) {
>>>> ???? ??? pr_warning("%s: GPIO%d is invalid pin\n", __func__, gpio);
>>>> ???? ??? return -1;
>>>> ???? }
>>>
>>> Same here, pxa2xx specific.
>>>
>>
>> Up to now, mfp driver is shared between pxa2xx, pxa3xx and so on. It
>> seems that extending mfp io is easier.
>>
>
> Actually, they are not. There are two separate mfp drivers for pxa2xx
> and pxa3xx if you look closely. And mfp-pxa2xx.c is used by pxa2xx
> solely, and the special binding of gpio_desc[] with pxa2xx MFP is
> very specific to pxa2xx only. Please help double check.
>

I think that mfp_to_gpio() macro is also a part of mfp driver. This
macro is used widely
in platform driver in order to allocate platform irq resource.
NR_BUILTIN_GPIO is similar
to this macro.

Because they're used in structure initialization, we can't use
detecting CPU method to
distinguish how much mfp/gpio pins can be applied on current CPU.
Since we couldn't
import variable or function into structure intialization code. Current
patch is the easiest
modification.

If there's a better solution, I'm glad to adopt it. :)

Thanks
Haojian
