From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 22 Jul 2018 12:10:08 +0200
Subject: [PATCH] ARM: dts: rmobile: Drop MTD partitioning from DT
In-Reply-To: <CAOesGMhAeRLf2fyw-igPBBCzoehcyT9fckVGuY=r8rjmdy-szg@mail.gmail.com>
References: <20180530101130.3566-1-marek.vasut+renesas@gmail.com>
 <CAOesGMjmz41p5sF_xnC7gdSRNLaowXPW7Sk8HBZww_QSTvXV7g@mail.gmail.com>
 <3b6f71da-8d63-1a63-dc61-05c12d52a2db@gmail.com>
 <CAOesGMhVbSGmkkF-Va6zwOB4xXxj=HpccKeFYgVLO4D86Vo4ow@mail.gmail.com>
 <5842740e-e652-aa51-ec2b-51f37a011a07@gmail.com>
 <CAOesGMhAeRLf2fyw-igPBBCzoehcyT9fckVGuY=r8rjmdy-szg@mail.gmail.com>
Message-ID: <9c77d8ae-637f-9713-83e3-3b40288b4b58@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2018 12:23 AM, Olof Johansson wrote:
[...]
>>>>> You end up with user space tools trying to parse the kernel command
>>>>> line to figure out what's on the flash, and other really bad habits.
>>>>> :(
>>>>
>>>> You should just read /proc/mtd , see
>>>> http://www.linux-mtd.infradead.org/doc/general.html
>>>
>>> Sure, I know that but not everybody does, and they do it in bad ways
>>> if given the opportunity.
>>
>> That's what the documentation is for. I assume whoever is using MTD is
>> also capable of reading the documentation and thus avoiding such basic
>> mistakes.
> 
> Why read the docs when the information obviously is there when you grep it?

To do things correctly of course.

> I'm agreeing with you -- I've just seen it done wrong so many times.
> Making it harder to make mistakes is always a good thing.

If you follow this argument through, you could say we should start
plucking out random files from /proc because someone might cluelessly
misuse them. This might lead to a system that's hard to misuse indeed,
but likely also quite useless.

>>>>> I'd strongly advice you to keep this in the board files, unless you
>>>>> have an actual real motivation for changing it. This patch does not
>>>>> provide one.
>>>>
>>>> Partitioning is not hardware description, it should not be in DT.
>>>
>>> Read my reply again. It's part of _platform_ description, and belongs in DT.
>>
>> I can repartition the flash whichever way I want for my purposes, just
>> like I can repartition a harddrive. We don't have harddrive partitioning
>> in the DT, why should we have flash partitioning there ? How do those
>> differ ?
> 
> A drive can be auto-probed. We have partition tables on the disk that
> self-describes the contents.
> 
> That doesn't exist on flashes, at least not usually. This is really
> unfortunate, I wish we could change _that_ instead of argue here.

Technically it does. Consider the fact that those flashes have between
4-64 MiB in size and sector size of 256 kiB . If you waste one sector on
the 4 MiB flash for some sort of partition table, you waste 1/16th of
the flash, which is a lot.

The bootloader needs to know the flash layout and it must be in sync
with the kernel, so there has to be some sort of communication channel
between those two. I don't want to add handler for every possible
bootloader that can be used on those platforms into the kernel though.

> If you repartition your disk, you need to change the command line
> arguments to the kernel too. It's definitely not an argument to
> keeping it on the command line instead.

How so ? /dev/sdxy remains /dev/sdxy . Sure, you can use UUID and change
it, but that's a specific case.

> Also, you now have a dependencies between hardware description, probe
> order and stable naming in the kernel, and the command line. With DT,
> you have it all in one place, right next to the flash part. It doesn't
> matter what name it gets probed at, and nobody needs to know the
> mapping to get it right.

In this case it doesn't matter either, since you have only one flash device.

-- 
Best regards,
Marek Vasut
