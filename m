From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 19 Jul 2018 23:24:37 +0200
Subject: [PATCH 4/5] net: add support for nvmem to
 eth_platform_get_mac_address()
In-Reply-To: <20180719174728.GK6920@n2100.armlinux.org.uk>
References: <20180718161035.7005-1-brgl@bgdev.pl>
 <20180718161035.7005-5-brgl@bgdev.pl>
 <20180719174728.GK6920@n2100.armlinux.org.uk>
Message-ID: <CAMRc=MfYp8Q4KNUMhLqf5jgd+C-_bWnfHworTbaCj0CZgRqMeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-07-19 19:47 GMT+02:00 Russell King - ARM Linux <linux@armlinux.org.uk>:
> On Wed, Jul 18, 2018 at 06:10:34PM +0200, Bartosz Golaszewski wrote:
>> @@ -544,6 +548,31 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>>                       from = "arch callback";
>>       }
>>
>> +     if (!addr) {
>> +             nvmem = nvmem_cell_get(dev, "mac-address");
>> +             if (IS_ERR(nvmem) && PTR_ERR(nvmem) == -EPROBE_DEFER)
>
> This is way too verbose.  To quote Al Viro from earlier today:
>
> <viro> sigh...
> <viro>         if (IS_ERR(link) && PTR_ERR(link) == -EEXIST)
> <viro> what the hell is wrong with if (link == ERR_PTR(-EEXIST))?
>
> I wonder why so many people haven't heard of pointer comparison... ;)
>
> IS_ERR(ERR_PTR(-EPROBE_DEFER)) is always true - if it wasn't, then
> we'd be in for problems.
>
> So, if you're asserting that nvmem is ERR_PTR(-EPROBE_DEFER) then
> there's no need to do the IS_ERR(nvmem) must also be true.  Hence, a
> simple pointer comparison is sufficient:
>
>                 if (nvmem == ERR_PTR(-EPROBE_DEFER))
>                         return -EPROBE_DEFER;
>

Hi Russell,

this issue is gone now in v3 but thanks for the example - I somehow
never thought about it.

Bart
