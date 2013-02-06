From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 6 Feb 2013 17:15:54 +0800
Subject: [PATCH v8 03/12] gpio: find gpio base by ascend order
In-Reply-To: <CACRpkdZO-=pcPx0pddhKibheAn7r6nJ5Cdh4ee4H+zUe8D+2hg@mail.gmail.com>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
 <1359825953-15663-4-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdZbC8nrDnQEZes9XJTJ6uSfpx-DjuSs3Q6GA0=eauhdYg@mail.gmail.com>
 <CAD6h2NRVem_yeizXzt1r2L4_WXAdqw9p_P3vMysskOYdJUkDzQ@mail.gmail.com>
 <CACRpkdZO-=pcPx0pddhKibheAn7r6nJ5Cdh4ee4H+zUe8D+2hg@mail.gmail.com>
Message-ID: <CAD6h2NQ6DNHwWqKXRa57-v8xgyuTqFtk38vdY3UzfXTYoRBOhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 February 2013 16:44, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Feb 6, 2013 at 2:59 AM, Haojian Zhuang
> <haojian.zhuang@linaro.org> wrote:
>> On 6 February 2013 01:14, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>>> This is more scary stuff.
>>>
>>> As you know GPIO numbers are exposed to userspace.
>>>
>>> Systems with this change risk having their dynamically added
>>> GPIO controller enumerated in a different fashion. And
>>> userspace clients may be relying on these numbers.
>>>
>>> And we do not break userspace.
>>>
>>> I know this is not elegant but I'm afraid the descending search
>>> needs to be kept for compatibibility reasons.
>>>
>>> BTW: please CC Grant likely on all patches.
>>>
>>> Yours,
>>> Linus Walleij
>>
>> But descending search isn't good for reading.
>
> But you may be breaking userspace.
>
> When I, as a subsystem maintainer merge a patch that break
> userspace interfaces, things like this happen:
>
> https://lkml.org/lkml/2012/12/23/75
> http://developers.slashdot.org/story/12/12/29/018234/linus-chews-up-kernel-maintainer-for-introducing-userspace-bug
>
> You can argue all you want about wanting to change things
> that affect userspace for internal kernel refactoring or fit
> with device tree or whatever, it's just not going to happen,
> because the Big Penguin has installed a culture of fear
> around breaking userspace.
>
> If you want the policy changed you can talk to Torvalds.
>
>> I try to allocate all gpio numbers in Hi3620 from gpiochip_find_base().
>> If it's descending search, GPIO0~7 is mapped to gpio248~255;
>> GPIO8~GPIO15 is mapped to gpio240~gpio247. It's not easy to read,
>> and it breaks the knowledge of gpio number on schematic & datasheet.
>
> It may make things elegant and nice on your (new) system but
> break everyone else's, and they were first in the kernel, they may
> have userspace clients and so, we cannot change this.
>
>> Unless we don't use allocating gpio numbers dynamically and add
>> a common property to parse gpio base of each chip in DTS file.
>> It's also OK to me add a common property.
>
> As explained elsewhere, global GPIO numbers don't belong
> in the device tree, as it is a Linux-specific pecularity.
> If this approach was chosen anyway, it would be named
> something like linux,gpio-base-offset
>
> One compromise would be to add global setting like
> gpio_add_dynamic_gpios_ascendingly() that will change
> the behaviour on a *specific* system, or maybe on all
> device tree systems, and keep both code paths.
> Yes, it is ugly and unelegant, but with the userspace
> contract, what can we do? We do all sort of ugliness
> for userspace.
>
> After reading this you may be on the clear why I am so
> hesitant about Roland Stigge's blocked GPIOs as well,
> that will become one more userspace ABI set in stone
> FOREVER.
>
> I'd like Grant's input on this... he has the big view on
> GPIO plus device tree.
>
> Yours,
> Linus Walleij

Since it may break the userspace ABI, I agree that we shouldn't
change current solution. Thanks for your kindly illustration.

In this patch series, I'll initialize pdata->gpio_base first and use
aux structure in machine driver.

Then I'll try to something like "linux,gpio-base-offset" in GPIO
system, and drop aux structure from machine driver. Since I'm
expecting GPIO/PINCTRL could be similar as IRQ that everything
could be parsed from DT, it could make driver simpler.

Best Regards
Haojian
