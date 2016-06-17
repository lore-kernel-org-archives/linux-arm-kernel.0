From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 17 Jun 2016 10:07:34 +0200
Subject: [PATCH] Revert "gpio: bail out silently on NULL descriptors"
In-Reply-To: <CACRpkdaYscNgwVaxJVD=m8e+yMrwvRHxhAHM4LPvBtrPKxXCSA@mail.gmail.com>
References: <1466014954-17956-1-git-send-email-hdegoede@redhat.com>
 <CACRpkdaYscNgwVaxJVD=m8e+yMrwvRHxhAHM4LPvBtrPKxXCSA@mail.gmail.com>
Message-ID: <3e000ebd-6178-6591-cd17-d67aa0421d57@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 15-06-16 23:04, Linus Walleij wrote:
> On Wed, Jun 15, 2016 at 8:22 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>
>> This reverts commit 54d77198fdfb("gpio: bail out silently on NULL
>> descriptors").
>>
>> This commit causes the following code to fail:
>>
>> gpio_desc = devm_gpiod_get_optional(dev, ...);
>> gpio_irq  = gpiod_to_irq(gpio_desc);
>> if (gpio_irq >= 0) {
>>         ret = devm_request_irq(dev, gpio_irq, ...);
>>
>> And now ret is an error causing the probe function in question to bail.
>>
>> The problem here is that gpiod_to_irq now returns 0 for a NULL
>> gpio_desc while 0 is a valid irq-nr. Also see:
>> commit 4c37ce8608a8("gpio: make gpiod_to_irq() return negative for NO_IRQ")
>> which specifically avoids returning 0.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> The first commit was done to fix another regression so if I revert it I get
> back the first regression.

Ok.

> I guess what we need to do is simply make gpiod_to_irq() a
> special case and have it behave the way expected for now?

That is fine with me.

> Hans: I sent a patch like that if it works for you could you give
> me your Tested-by?

I've just checked the code and code-wise it looks good. I'll test
it on actual hw later today.

Regards,

Hans
