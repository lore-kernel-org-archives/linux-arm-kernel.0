From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 19 Jul 2018 10:14:29 +0200
Subject: [PATCH 5/5] net: add MTD support to eth_platform_get_mac_address()
In-Reply-To: <20180718170352.GF12477@lunn.ch>
References: <20180718161035.7005-1-brgl@bgdev.pl>
 <20180718161035.7005-6-brgl@bgdev.pl>
 <20180718164737.GE12477@lunn.ch>
 <CAMRc=MeRv3_C8_R-Awfr1zjLa3G_CVAACc-2t_ihB+1v+BCTGw@mail.gmail.com>
 <20180718170352.GF12477@lunn.ch>
Message-ID: <CAMRc=Md3oeEktzrA9UZyNPX6pB4bG+Gv0o6cjbs0UUKb3sYTsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-07-18 19:03 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
>> >> +#ifdef CONFIG_MTD
>> >> +     /* NOTE: this should go away as soon as MTD gets nvmem support. */
>> >> +     if (!addr) {
>> >> +             struct mtd_info *mtd;
>> >> +             int rv;
>> >> +
>> >> +             mtd = get_mtd_device_nm("MAC-Address");
>> >
>> > In order for this to go away, you need to keep backwards
>> > compatibility. When using nvmem, you look for a cell called
>> > "mac-address". Here you are looking for "MAC-Address". That is going
>> > to make backwards compatibility harder. How do you plan to do it?
>> >
>> >    Andrew
>>
>> I'm trying to adjust to already existing users. The only user of
>> get_mtd_device_nm() who calls it to read the MAC address registers a
>> partition called "MAC-Address". We can't change it since it's visible
>> from user space. In the future we'd just have to have a list of
>> supported string that we'd use to do the nvmem lookup.
>
> Why not have the nvmem cell called "MAC-Address"? When you add nvmem
> support to MTD, i assume you are going to map each MTD partition to an
> nvmem cell?

Because all existing users of nvmem use "mac-address" as the name of
this cell already. I guess we will need to live with both in this
particular function.

Bart
