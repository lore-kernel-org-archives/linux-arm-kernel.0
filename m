From: sedat.dilek@gmail.com (Sedat Dilek)
Date: Tue, 17 Jul 2012 12:39:07 +0200
Subject: linux-next: Tree for July 17 (mfd: AB3100 - ab3100_probe:
 undefined reference to `rand_initialize_irq')
In-Reply-To: <CA+icZUW4gNqspcJ1sjBD-3GCVee2VWVV5NPAr6Eo-aZHjp3y+Q@mail.gmail.com>
References: <CA+icZUXjc+13YjoJ6FjDFboX20j3mqHNtvV2Av2-H0My8V2Mgg@mail.gmail.com>
 <CA+icZUW4gNqspcJ1sjBD-3GCVee2VWVV5NPAr6Eo-aZHjp3y+Q@mail.gmail.com>
Message-ID: <CA+icZUW+Gp9HK-6dzHjtTwSc9RaLD3sV+WPMM-vO3A6fj6frwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 12:21 PM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Tue, Jul 17, 2012 at 11:47 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>> On Tue, Jul 17, 2012 at 7:41 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>> Hi all,
>>>
>>> Changes since 20120716:
>>>
>>> The vfs tree lost its build failure.
>>>
>>> The l2-mtd tree gained a conflict against the mtd tree.
>>>
>>> The battery tree tree lost its build failure.
>>>
>>> The regulator tree gained conflicts against the mfd tree.
>>>
>>> The tty tree lost its build failure but gained another, so I used the
>>> version from next-20120712.
>>>
>>> I have still reverted 3 commits from the signal tree at the request of the
>>> arm maintainer.
>>>
>>> The akpm tree lost a few patches that turned up elsewhere.
>>>
>>
>> From my today's build-log on a Ubuntu/precise AMD64 host:
>> [...]
>>   LD      drivers/video/built-in.o
>>   LD      drivers/built-in.o
>>   LINK    vmlinux
>>   LD      vmlinux.o
>>   MODPOST vmlinux.o
>>   GEN     .version
>>   CHK     include/generated/compile.h
>>   UPD     include/generated/compile.h
>>   CC      init/version.o
>>   LD      init/built-in.o
>> drivers/built-in.o: In function `ab3100_probe':
>> ab3100-core.c:(.devinit.text+0xbf97): undefined reference to
>> `rand_initialize_irq'
>> make[2]: *** [vmlinux] Error 1
>> make[1]: *** [deb-pkg] Error 2
>> make: *** [deb-pkg] Error 2
>>
>> MFD / AB3100 kernel-config settings:
>>
>> CONFIG_AB3100_CORE=y
>> CONFIG_AB3100_OTP=m
>> CONFIG_REGULATOR_AB3100=m
>> CONFIG_RTC_DRV_AB3100=m
>>
>> If you need further informations, please let me know.
>>
>> - Sedat -
>
> [ CC Ted (new random maintainer) ]
>
> Is this due to this change?
>
> From 946672f548682905d8ecdab33bb6e2c705418505 Mon Sep 17 00:00:00 2001
> From: Theodore Ts'o <tytso@mit.edu>
> Date: Sat, 14 Jul 2012 20:27:52 -0400
> Subject: [PATCH] random: remove rand_initialize_irq()
>
> With the new interrupt sampling system, we are no longer using the
> timer_rand_state structure in the irq descriptor, so we can stop
> initializing it now.
>
> Signed-off-by: "Theodore Ts'o" <tytso@mit.edu
>
> ...looks like AB3100 is the *only* driver still using rand_initialize_irq()...
>
> drivers/mfd/ab3100-core.c:939:  rand_initialize_irq(client->irq);
>
> ...but why has random.h still this...?
>
> include/linux/random.h:51:extern void rand_initialize_irq(int irq);
>
> Just thinking "loud"...
>
> - Sedat -

Is this attached patch OK, Ted?

- Sedat -
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-random-remove-remaining-relicts-of-rand_initialize_i.patch
Type: application/octet-stream
Size: 2213 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120717/b9b6a87b/attachment-0001.obj>
