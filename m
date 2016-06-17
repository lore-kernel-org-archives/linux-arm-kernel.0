From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 17 Jun 2016 10:05:51 +0200
Subject: [PATCH] Revert "gpio: bail out silently on NULL descriptors"
In-Reply-To: <CACRpkdbvhobvSvqifqKQFvsDqALVFUhj_8rtaAWbEFYJrug6yg@mail.gmail.com>
References: <1466014954-17956-1-git-send-email-hdegoede@redhat.com>
 <20160615184628.GA5144@lukather>
 <3a03fc91-b339-3e43-4e95-e1488197a8df@redhat.com> <5762701C.4060409@ti.com>
 <CACRpkdbvhobvSvqifqKQFvsDqALVFUhj_8rtaAWbEFYJrug6yg@mail.gmail.com>
Message-ID: <b8abb402-778b-1c02-dbad-81df966ddf97@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16-06-16 11:53, Linus Walleij wrote:
> On Thu, Jun 16, 2016 at 11:23 AM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>> On 06/15/2016 10:08 PM, Hans de Goede wrote:
>
>>>>> This commit causes the following code to fail:
>>>>>
>>>>> gpio_desc = devm_gpiod_get_optional(dev, ...);
>>
>> May be I missed smth., but in this example gpio_desc may contain err code.
>>
>>>>> gpio_irq  = gpiod_to_irq(gpio_desc);
>> which, most probably will cause gpiod_to_irq() to crash
>>         if (!desc) \
>>                 return 0; \
>>         if (!desc->gdev) { \
>> ^^^^^^^^^^^^^ here
>
> Hm good catch. These optional GPIOs may never have worked properly,
> good that they are so rare :/
>
> I'll send a separate patch making some IS_ERR() checks.

IMHO that is really something which the driver should be doing
(and in the case of phy-sun4i-usb.c where I was hitting the
NULL problem, the driver does contain these checks),
but I guess it cannot hurt.

Regards,

Hans
