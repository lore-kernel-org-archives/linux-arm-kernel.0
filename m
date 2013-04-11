From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 11 Apr 2013 10:22:48 +0200
Subject: [PATCH v7] clk: add si5351 i2c common clock driver
In-Reply-To: <11205025.2MA5VbIUoF@ganymedes>
References: <1365439617-18816-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <14854575.YAd2OMKOy9@ganymedes> <5165A0FD.5030308@gmail.com>
 <11205025.2MA5VbIUoF@ganymedes>
Message-ID: <CABJ1b_S_Tz9WBuO1==7ZU-fuAnYRwRZUcLCM=Zq+6tLCZyEevw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 9:44 AM, Michal Bachraty
<michal.bachraty@streamunlimited.com> wrote:
> On Wednesday, April 10, 2013 19:27:25 Sebastian Hesselbarth wrote:
>> Hmm, is there any driver using the clock output? Does it
>> clk_prepare_enable() the clock? I tend not to mess with anything the
>> bootloader or eeprom config left disabled. It works for me, but here the
>> driver will prepare/enable the clock prior use.
>
> For my case, disabled clock outputs in bootloader are correct. I'm working on
> module board with lot of purposes. For one I need to tune frequncy, for other
> not. In some cases I can use  clk_prepare_enable. For now, I need to tune clk,
> so I can't use clk_prepare_enable. Si5351 chip has no problem with enabling
> clock output multiple times, when calling clk_set_rate. So if this feature
> will not be in driver, I need to stay with patch upon driver.

Michal,

after thinking about it, I will re-add the power-on on rate change.
Not because I
want to have a workaround for not using clk_prepare_enable() before
clk_set_rate(),
but clkout will remain disabled if you set clock-frequency by DT.
There will be no
superfluous writes to i2c resisters anyway, because clk-si5351 is
using regmap-i2c
that takes care of caching.

Sebastian
