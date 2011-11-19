From: 21cnbao@gmail.com (Barry Song)
Date: Sat, 19 Nov 2011 19:17:20 +0800
Subject: [linux-pm] [PATCH] PM: HIBERNATION: skip the swap size check if
 the snapshot image size is anticipative
In-Reply-To: <20111118190233.GA16136@elf.ucw.cz>
References: <1320392176-3906-1-git-send-email-Barry.Song@csr.com>
 <20111105182244.GB6772@elf.ucw.cz>
 <CAGsJ_4xU28APFEcALAzuB2jAACa8FbOR6iSvOaEeGZa=JyjNeA@mail.gmail.com>
 <CAGsJ_4xm05N4UZ94kvUtUGLGkcDnxesojV0fL9hQQnZBOFvohg@mail.gmail.com>
 <20111118190233.GA16136@elf.ucw.cz>
Message-ID: <CAGsJ_4zDNH-a==E=OcGaaKmMzMwRCxJk9SVW0=bzScvisNGPsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/11/19 Pavel Machek <pavel@ucw.cz>:
> On Mon 2011-11-07 09:31:10, Barry Song wrote:
>> 2011/11/6 Barry Song <21cnbao@gmail.com>:
>> > 2011/11/6 Pavel Machek <pavel@ucw.cz>:
>> >> Hi!
>> >>
>> >>> From: Barry Song <Baohua.Song@csr.com>
>> >>>
>> >>> Current swsusp requires swap partitions even larger than real saved pages
>> >>> due to the worst compress ratio:
>> >>> but for an embedded system, which has limited storage space, then it might
>> >>> can't give the big size partition to save snapshot.
>> >>> In the another way, some embedded systems can definitely know the most size
>> >>> needed for snapshot since they run some specific application lists.
>> >>> So this patch provides the possibility for bootloader to tell kernel even
>> >>> the system has a little snapshot partition, but it is still enough.
>> >>> For example, if the system need to save 120MB memory, origin swsusp will require
>> >>> a 130MB partition to save snapshot. but if users know 30MB is enough for them(
>> >>> compressed image will be less than 30MB), they just make a 30MB
>> >>> partition.
>> >>
>> >> Would it be better to have /sys/power/... entry which would allow
>> >> configuring expected compression ratio at runtime?
>> >
>> > i think it is better to have a sys node than add another kernel param.
>> > but the point is i only care about the final image size but not
>> > compression ratio. i don't care how well lzo will do for me since i
>> > only have limited disk space and know how many pages want to be saved.
>> > there has been a image_size node, will we have a expected_image_size node?
>>
>> or will we have just a node named /sys/power/check_size, if
>> 1(default), check, otherwise(0 set by users), skip checking?
>
> Or just avoid the check at all, since it no longer makes sense with
> compression?

current early check just makes the failure happen earier. in the
check, it requires more space than uncompressed data due to the worst
compress ratio. some users might have big space and complex scenerios,
they might want the earlier check. but it is really a big waste
considering text, data sections of programs are actually data which
can be compressed in a big ratio.

but for some other embedded system users, they have limited storage
and known sw list, then they know their little space is enough for
compressed image.

i think we can make the function as a option for users. provide a node
/sys/power/check_swap_size, if users set it to 0, ignore the check.
otherwise, check by the worst compress ratio.

>
> What is the failure scenario? Hibernation still fails, but it takes
> longer to fail?

it will fail some later. but i still expect the system can restore to
be normal even it fails in the saving stage. i can give a test.

>
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?Pavel
> --
-barry
