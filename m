From: acourbot@nvidia.com (Alex Courbot)
Date: Wed, 6 Feb 2013 13:33:21 +0900
Subject: [PATCH v8 03/12] gpio: find gpio base by ascend order
In-Reply-To: <CAD6h2NRVem_yeizXzt1r2L4_WXAdqw9p_P3vMysskOYdJUkDzQ@mail.gmail.com>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
 <1359825953-15663-4-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdZbC8nrDnQEZes9XJTJ6uSfpx-DjuSs3Q6GA0=eauhdYg@mail.gmail.com>
 <CAD6h2NRVem_yeizXzt1r2L4_WXAdqw9p_P3vMysskOYdJUkDzQ@mail.gmail.com>
Message-ID: <5111DD11.5@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2013 10:59 AM, Haojian Zhuang wrote:
> On 6 February 2013 01:14, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Sat, Feb 2, 2013 at 6:25 PM, Haojian Zhuang
>> <haojian.zhuang@linaro.org> wrote:
>>
>>> gpiochip_find_base() always tries to find valid gpio with descend order.
>>> It's inconvient if gpio information is passing from DTS. Now try to find
>>> valid gpio with ascend order.

GPIOs in the device tree are typically referenced by a phandle which 
include the controller and relative HW number. Are there cases where we 
must use absolute GPIO numbers in the DT?

>>>
>>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>>
>> This is more scary stuff.
>>
>> As you know GPIO numbers are exposed to userspace.
>>
>> Systems with this change risk having their dynamically added
>> GPIO controller enumerated in a different fashion. And
>> userspace clients may be relying on these numbers.
>>
>> And we do not break userspace.
>>
>> I know this is not elegant but I'm afraid the descending search
>> needs to be kept for compatibibility reasons.
>>
>> BTW: please CC Grant likely on all patches.
>>
>> Yours,
>> Linus Walleij
>
> But descending search isn't good for reading.
>
> I try to allocate all gpio numbers in Hi3620 from gpiochip_find_base().
> If it's descending search, GPIO0~7 is mapped to gpio248~255;
> GPIO8~GPIO15 is mapped to gpio240~gpio247. It's not easy to read,
> and it breaks the knowledge of gpio number on schematic & datasheet.
>
> Unless we don't use allocating gpio numbers dynamically and add
> a common property to parse gpio base of each chip in DTS file.
> It's also OK to me add a common property.

There is also one more problem with this reordering: if a GPIO chip with 
a base GPIO set gets probed *after* a bunch of chips without a proper 
base, its range in the number space is likely to have been stolen by one 
of the "dynamic" chips.

Ideally all chips would come with a base GPIO, but we cannot rule out 
hotplugable interfaces. Even more ideally the integer numberspace would 
go away altogether with the new gpiod interface and the sysfs interface 
would be replaced with one where exported GPIOs would be under their 
chip node, and referenced by their hw number. But that would break 
userspace even more. Or maybe there could be a config option to choose 
between the "legacy" integer-space user interface and this new scheme. 
Eventually, the number space could be deprecated.

Alex.
