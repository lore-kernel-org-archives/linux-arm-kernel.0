From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 9 Dec 2009 08:07:33 -0500
Subject: [PATCH 02/10] support 88pm8606 in 860x driver
In-Reply-To: <20091207135911.GC7279@sortiz.org>
References: <20091120150215.GF3733@sortiz.org>
	<20091127145820.GA3640@sortiz.org>
	<771cded00911291743u76688d24ja40a30472ebd6af8@mail.gmail.com>
	<20091130101943.GA3696@sortiz.org>
	<771cded00912062334q7f92bf25hb9e7a10f8720812@mail.gmail.com>
	<20091207113927.GB7279@sortiz.org>
	<20091207131508.3ed89841@hyperion.delvare>
	<771cded00912070447t1b1b5105m4ade492b2bc7e70d@mail.gmail.com>
	<20091207143832.68db35c7@hyperion.delvare>
	<20091207135911.GC7279@sortiz.org>
Message-ID: <771cded00912090507t4423a4d3ucae22457fb3f4fe4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 7, 2009 at 8:59 AM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Hi Jean,
>
> On Mon, Dec 07, 2009 at 02:38:32PM +0100, Jean Delvare wrote:
>> On Mon, 7 Dec 2009 07:47:44 -0500, Haojian Zhuang wrote:
>> > >
>> > > Some more background would be welcome, yes. In particular on how the
>> > > 8806 and 8807 relate to each other, and what kind of chips they are.
>> > > And what problem you are trying to solve in the first place ;)
>> >
>> > These two chips can be used together for power management. 8807 is
>> > focus on regulator, RTC, touch, vibrator. 8806 is focus on backlight,
>> > led, charger, and so on. When charger is in use, it also need to
>> > access registers in 8807. In original implementation, one static mixed
>> > structure is defined to link these two chips together. One i2c driver
>> > was serviced for both 8806 and 8807 by i2c id table. Now Samuel is
>> > help me to remove the static mixed structure.
>>
>> I agree that a static structure is not a good idea and it's better to
>> avoid it if possible.
>>
>> > User can use them together or use only one.
>>
>> By "user" you mean hardware designer? Or end-user?
> I think he means hardware designer.
>
>
>> > > In any case, you never get to duplicate the i2c-pxa driver code
>> > > anywhere. If you have several I2C bus segments controlled by PXA-like
>> > > hardware, then you instantiate that many i2c_adapters, all driven by
>> > > the same driver (i2c-pxa.)
>> > >
>> > > Calling i2c_new_device() from an i2c client's probe() routine is rather
>> > > unusual. I can't really think of a good reason to do this. If the first
>> > > client was declared as part of platform init data, I'd expect the
>> > > second to be declared there as well.
>> > >
>> > > There's one which is somewhat similar though: chips which reply to more
>> > > than one I2C address. The extra addresses are reserved using
>> > > i2c_new_dummy(). This gives you an i2c_client handle for easy register
>> > > access. This might be suitable for the problem at hand, but I can't
>> > > tell for sure without knowing the details.
>> > >
>> >
>> > Does it mean that i2c_new_dummy()/i2c_new_device() is doing the same
>> > thing like declaring of i2c chip in platform init data?
>>
>> i2c_new_device() is indeed very similar to declaring the i2c chip in
>> platform init data. The key difference is that you need an i2c_adapter
>> handle for i2c_new_device(), while the adapter is referenced by its
>> number in the platform init data.
>>
>> i2c_new_dummy() is a little different, it doesn't create a real device,
>> no probe/remove method will be called. It only reserves a given I2C
>> address (on the specified adapter) for your own use.
>>
>> Now that I understand better what problem you are trying to solve, here
>> are a few hints.
>>
>> As suggested by Samuel, you can have a single device declared in the
>> platform init data. Attach custom data to this device, where you
>> declare if the other chip is present and at which address it lives.
>> Then in the probe() function of the driver, check the data and call
>> i2c_new_dummy() on the address in question if present.
>>
>> There are constraints and requirements to this approach: both chips
>> must be connected to the same I2C adapter, the same driver must handle
>> both devices, and your driver must be ready to deal with the main device
>> being either a 8807 or a 8806, and the secondary chip being present or
>> not. Shouldn't be overly difficult though.
> Yes, the driver fits all those requirements, so it shouldnt be too difficult.
>
>> An alternative approach is to declare both devices as part of the
>> platform init data, and let them be registered separately. Then have a
>> dedicated registration/removal calls at the end of the probe() method /
>> beginning of the remove() method. The registration function would track
>> which devices are up and operational, and when it spots two devices
>> which would work together, it adds the respective information to each
>> device so that it can reach its sibling. The removal function would
>> clean up the links when either sibling is removed.
> I thought about that solution as well, but couldnt see how we could cleanly
> tell how 2 devices relate to each other. Now, as you're saying below, we could
> assume that both devices are on the same i2c adapter, that sounds like a
> fair requirement.
> Personally, I'd prefer to use the i2c_new_dummy() method, but it's Haojian's
> call to decide which one he prefers.
>
>
>> This also has limitations, as you need a way to decide which devices go
>> by pair. But assuming that both devices are always on the same I2C
>> adapter, it shouldn't be too difficult. It is probably cleaner than the
>> other options, as it is symmetrical, but it might be overkill depending
>> on the cases you really must handle in practice.
> Jean, thanks a lot spending your time on this long and detailed explanation, I
> appreciate.
>

Hi Jean & Samuel,

Thanks for your great help. Now I update these patches with
i2c_new_device(). I'll paste it in a new thread.

Best Regards
Haojian
