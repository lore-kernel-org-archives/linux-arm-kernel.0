From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 22 Nov 2009 08:25:48 +0800
Subject: [PATCH 02/10] support 88pm8606 in 860x driver
In-Reply-To: <20091120150215.GF3733@sortiz.org>
References: <771cded00911130054p2ef293ebse84b1de3cf4fa9fd@mail.gmail.com>
	<20091120150215.GF3733@sortiz.org>
Message-ID: <771cded00911211625g74601e5die59a680f36903cb3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2009 at 11:02 PM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Hi Haojian,
>
> On Fri, Nov 13, 2009 at 03:54:52AM -0500, Haojian Zhuang wrote:
>> From 52a43fa137c45e62ced134b240c387b600f4ac0e Mon Sep 17 00:00:00 2001
>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Date: Fri, 6 Nov 2009 09:22:52 -0500
>> Subject: [PATCH] mfd: support 88pm8606 in 860x driver
>>
>> 88PM8606 and 88PM8607 are always used together. Although they're two discrete
>> chips, the logic function is tightly linked. For example, USB charger driver
>> is based on these two devices.
>>
>> Now share one driver to these two devices. Create a logical chip structure
>> that contains both 8606 device and 8607 device.
> I think it's a really good idea to have one driver for those 2 devices.
> However, I dont see much point in having the mixed_88pm860x common structure.
> That forces you in having a static structure there for no real benefit. In
> fact, by having it you're restricting yourself to the current HW
> configuration, i.e. at most 1 8806 and 1 8807.
Yes, I just want to restrict at most 1 8806 and 1 8807 in system. Or
we should have 1 8806 or 1 8807 in system.
Although I defined mixed_88pm860x common structure, I didn't use it
directly. I used pm860x_reg_read() to make use of this structure. In
all I2C operations, there's a descriptor indicator. This indicator is
used call 8807 operation in 8806 client. Since USB charger is the
device of 8806, it also need to access 8807 register. Otherwise, I
have to assert two i2c clients in 8806 device driver.
The only benefit of mixed_88pm860x is linking 8806 and 8807 together.
So 8806 device could directly fetch registers of 8807 device.
>
> You could just have a struct pm860x_chip with buck3_double field (should be a
> bool, by the way), a mutex, and be fine with it.
Yes, only one mutex is enough. In the 0002 patch, I defined mutex in
8806, 8807 and mixed_88pm860x. It's over-designed. I removed mutex in
8806 and 8807 in the followed patches. So there's only one mutex in
mixed_88pm860x structure.
>
> Besides this, the patch looks good to me.
>
> Cheers,
> Samuel.
>
>> All I2C operations are accessed by 860x-i2c driver. In order to support both
>> I2C client address, the read/write API is changed in below.
>>
>> reg_read(chip, descriptor, offset)
>> reg_write(chip, descriptor, offset, data)
>>
>> At here, descriptor is DESC_8606 or DESC_8607 that means operation on which
>> real device.
>>
>> The benefit is that client drivers only need one kind of read/write API. I2C
>> and MFD driver can be shared in both 8606 and 8607.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> ---
