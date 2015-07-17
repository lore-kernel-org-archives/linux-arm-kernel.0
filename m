From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri, 17 Jul 2015 10:19:28 +0200
Subject: [PATCH 04/13] pinctrl: tegra: Only set the gpio range if needed
In-Reply-To: <CACRpkdahW+oXpcmyCSEYbUrsz3DPgT+HJ6h=8_J=nYOpghaXAQ@mail.gmail.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
 <1434548543-22949-5-git-send-email-tomeu.vizoso@collabora.com>
 <CACRpkdY1PPTvuF1ntiybGYoN8nHD7dojtuuJkKpUPXNjBpK1nw@mail.gmail.com>
 <CAAObsKBUoMmHOXBmEO4+8H1VVAkEHn_aFvLBOrXS5syLu5p1iA@mail.gmail.com>
 <CACRpkdahW+oXpcmyCSEYbUrsz3DPgT+HJ6h=8_J=nYOpghaXAQ@mail.gmail.com>
Message-ID: <CAAObsKAH4kXdetXoj7fEZP4t09g39E4Y6QZPO4_SBu=BqstqbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 July 2015 at 10:04, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Jul 14, 2015 at 10:34 AM, Tomeu Vizoso
> <tomeu.vizoso@collabora.com> wrote:
>> On 13 July 2015 at 22:14, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> On Wed, Jun 17, 2015 at 3:42 PM, Tomeu Vizoso
>>> <tomeu.vizoso@collabora.com> wrote:
>>>
>>>> If the gpio DT node has the gpio-ranges property, the range will be
>>>> added by the gpio core and doesn't need to be added by the pinctrl
>>>> driver.
>>>>
>>>> By having the gpio-ranges property, we have an explicit dependency from
>>>> the gpio node to the pinctrl node and we can stop using the deprecated
>>>> pinctrl_add_gpio_range() function.
>>>>
>>>> Note that when the GPIO device gets probed before the associated
>>>> princtrl device, the gpio core actually won't register the gpio range.
>>>> Thus, this patch is only safe to be merged after we have in place a way
>>>> to assure that gpio devices are probed after their associated pinctrl
>>>> devices (such as ordered probing).
>>>>
>>>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>>
>>> This doesn't look like it would hurt, but need Stephen's opinion
>>> on it, and I think he's on vacation. Would check with next-in-line
>>> Tegra maintainer, Thierry/Alexandre?
>>
>> Sorry about that, but I have split these changes out into their own
>> series after people complained about it.
>>
>> Have just sent a new version which already has Stephen's ack:
>>
>> https://lkml.kernel.org/g/1436862596-27730-1-git-send-email-tomeu.vizoso at collabora.com
>
> I don't see Stephen's ACK on them, where is it? It's not in the
> patch and I don't see it as response to the patches.

I see it in:

https://lkml.kernel.org/g/1436862596-27730-4-git-send-email-tomeu.vizoso at collabora.com

Which was given in:

https://lkml.kernel.org/g/559D8E36.50209 at wwwdotorg.org

But we still need an ack for patch 1/3 before both 2/3 and 3/3 can be
merged, because if we don't defer the probe when the pinctrl isn't
found and just skip adding the gpio-range, there won't be no
gpio-range set at all if the pinctrl device probes after the gpiochip
device. Merging 2/3 now would be fine as long as we don't merge 3/3
before 1/3.

Thanks,

Tomeu
