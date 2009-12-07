From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 7 Dec 2009 02:34:58 -0500
Subject: [PATCH 02/10] support 88pm8606 in 860x driver
In-Reply-To: <20091130101943.GA3696@sortiz.org>
References: <771cded00911130054p2ef293ebse84b1de3cf4fa9fd@mail.gmail.com>
	<20091120150215.GF3733@sortiz.org>
	<771cded00911211625g74601e5die59a680f36903cb3@mail.gmail.com>
	<20091127145820.GA3640@sortiz.org>
	<771cded00911291743u76688d24ja40a30472ebd6af8@mail.gmail.com>
	<20091130101943.GA3696@sortiz.org>
Message-ID: <771cded00912062334q7f92bf25hb9e7a10f8720812@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2009 at 5:19 AM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Hi Haojian,
>
> On Sun, Nov 29, 2009 at 08:43:45PM -0500, Haojian Zhuang wrote:
>> > On the other hand if it is impossible from a HW point of view to have a
>> > platform design where you'd have either a single 8806 or a single 8807, then 2
>> > things:
>> > - Your driver design would be ok.
>> [Haojian]: Great Thanks :)
>> > - Those chip designs are really bad as it should be one and only one single
>> > (and in particular only use one single i2c address space and id)
>> [Haojian]: I agree this opinion that the same functionality logic
>> should be placed into one chip and using single i2c address. If same
>> functionality logic can be in one chip, the driver could be simpler
>> without glue logic.
>> >
>> > Cheers,
>> > Samuel.
>> >
>> >
>> Hi Samuel,
>>
>> I tried to add some comments of the chip's background. Up to now, I
>> can't find a better idea to handle this driver without mixed structure
>> since usb charger linkes them tightly. If there's a better prototype
>> to handle this, I'll adopt it.
> Thanks for the explanations, I appreciate.
> Only the board definition can describe what's the relationship between your
> 8806 and 8807, so here is what I propose: Add an i2c address to your 880x
> platform data, and have only a 8806 definition on your board specific file.
> Then from the 880x driver, you check for the platform data i2c address. If
> it's a valid one, that means we are expecting a 8807 to be present on the
> board and thus we can instantiate this i2c device by calling i2c_new_device().
> That will give you a link to your 8807 i2c client from your 8806. The
> advantage of that solution is to keep the 880x driver board and design
> neutral while avoiding any static definitions.
> Waiting for your feedback.
>
Hi Samuel,

Excuse me to response late. If I implement i2c_new_device(), I should
have to create adapter, algorithm and so on. It means that I have to
implement i2c-pxa.c duplicately in mfd driver. Is it right?

And you want to us i2c_new_device(). Does it mean that there's only
8607 device and address in platform driver and mfd driver
distinguishing 8606 from platform data?

Thanks
Haojian
