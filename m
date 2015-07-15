From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 15 Jul 2015 10:13:40 +0200
Subject: [PATCH 04/13] pinctrl: tegra: Only set the gpio range if needed
In-Reply-To: <CAAVeFu+L+Qrja4gWEA=FnnbtBFkX43zpmJLJq0PSWLx5m4w6kA@mail.gmail.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
 <1434548543-22949-5-git-send-email-tomeu.vizoso@collabora.com>
 <CACRpkdY1PPTvuF1ntiybGYoN8nHD7dojtuuJkKpUPXNjBpK1nw@mail.gmail.com>
 <CAAObsKBUoMmHOXBmEO4+8H1VVAkEHn_aFvLBOrXS5syLu5p1iA@mail.gmail.com>
 <CAAVeFu+L+Qrja4gWEA=FnnbtBFkX43zpmJLJq0PSWLx5m4w6kA@mail.gmail.com>
Message-ID: <CAAObsKC15XrBhDLb08_dBxPhcX+4i9YxqT963c0LDvziZVQhZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 July 2015 at 05:17, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Tue, Jul 14, 2015 at 5:34 PM, Tomeu Vizoso
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
> The change looks ok, but why limit it to Tegra? It seems like it could
> apply to any driver that supports gpio-range. Or is it because this
> will only work with drivers that use ordered probing?

It has to be SoC specific because we need to find out if a node
representing the in-SoC gpio controller is present, and has the
gpio-ranges property.

I guess we could move the code to the pinctrl core and parametrize the
property name but given that pinctrl_add_gpio_range is deprecated and
that we are doing this only for DT compatibility, I'm not sure it
would be a good idea.

Regards,

Tomeu
