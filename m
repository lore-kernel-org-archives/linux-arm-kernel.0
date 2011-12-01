From: khilman@ti.com (Kevin Hilman)
Date: Thu, 01 Dec 2011 07:10:03 -0800
Subject: [PATCH-V4 0/3] Introducing TI's New SoC/board AM335XEVM
In-Reply-To: <79CD15C6BA57404B839C016229A409A80474FD@DBDE01.ent.ti.com>
 (Vaibhav Hiremath's message of "Thu, 1 Dec 2011 11:07:18 +0000")
References: <1320946837-32507-1-git-send-email-hvaibhav@ti.com>
 <878vmxxjrv.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A80474FD@DBDE01.ent.ti.com>
Message-ID: <878vmws4z8.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

>> -----Original Message-----
>> From: Hilman, Kevin
>> Sent: Thursday, December 01, 2011 5:09 AM
>> To: Hiremath, Vaibhav; Russell King
>> Cc: linux-omap at vger.kernel.org; tony at atomide.com; linux-arm-
>> kernel at lists.infradead.org; paul at pwsan.com
>> Subject: Re: [PATCH-V4 0/3] Introducing TI's New SoC/board AM335XEVM
>> 
>> Vaibhav Hiremath <hvaibhav@ti.com> writes:
>> 
>> > This patch set adds support for AM335x device having
>> > Cortex-A8 MPU.
>> >
>> > Official website - http://www.ti.com/product/am3359
>> >
>> > AM335X is treated as another OMAP3 variant, where,
>> > along with existing cpu class OMAP34XX, new cpu class AM33XX is created
>> > and the respective type is AM335X, which is newly added device in
>> > the family.
>> > This means, cpu_is_omap34xx(), cpu_is_am33xx() and
>> > cpu_is_am335x() checks return success for AM335X.
>> >
>> > Also, I have validated OMAP3 boot test with this patch-series on
>> OMAP3EVM.
>> 
>> After fixing the minor comment on patch 3/3, feel free to add:
>> 
>> Reviewed-by: Kevin Hilman <khilman@ti.com>
>> 
> Thanks Kevin, for the review.
>
>
>> Also, I was surprised to discover that this booted on my (recently
>> arrived) BeagleBone.  It seems that u-boot (from Angstrom) is passing
>> the machine ID of the AM335x EVM[1], even though there is another
>> machine ID for the BeagleBone[2].  Is that expected?
>
> We can detect the board using on-board EEPROM, so same mach-id
> should work for both EVM and Beagle. 

> And also going forward with device tree approach we may
> not need different id's, right?

Right, which is why I'm wondering why are there sevral new AM33x
mach-types when only one of them is being used:

3684    TI AM335X IA EVM        am335xiaevm     Afzal Mohammed
3589    TI AM335X EVM           am335xevm       Vaibhav Bedia
3808    Beaglebone Board        beaglebone      Steven Kipisz

Russell has been trying to cleanup athe mach-types, so if these others
are not going to be used, I suggest they be deleted.

> But I am surprised to see that beaglebone is booting fine for you,
> did you get Linux console?

Oh, sorry for the confusion.  No, it didn't boot to console.  It just
booted far enought to see that your this series was working and it was
getting started, but it eventually hangs because of missing MPU hwmod:

[...]
[    0.000000] omap_hwmod: timer1: cannot setup_one: MPU initiator hwmod mpu not yet registered                                                               
[    0.000000] ------------[ cut here ]------------                           
[    0.000000] kernel BUG at /work/kernel/omap/dev/arch/arm/mach-omap2/timer.c: 214!

Kevin
