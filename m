From: olof@lixom.net (Olof Johansson)
Date: Sat, 21 Jul 2018 15:23:39 -0700
Subject: [PATCH] ARM: dts: rmobile: Drop MTD partitioning from DT
In-Reply-To: <5842740e-e652-aa51-ec2b-51f37a011a07@gmail.com>
References: <20180530101130.3566-1-marek.vasut+renesas@gmail.com>
 <CAOesGMjmz41p5sF_xnC7gdSRNLaowXPW7Sk8HBZww_QSTvXV7g@mail.gmail.com>
 <3b6f71da-8d63-1a63-dc61-05c12d52a2db@gmail.com>
 <CAOesGMhVbSGmkkF-Va6zwOB4xXxj=HpccKeFYgVLO4D86Vo4ow@mail.gmail.com>
 <5842740e-e652-aa51-ec2b-51f37a011a07@gmail.com>
Message-ID: <CAOesGMhAeRLf2fyw-igPBBCzoehcyT9fckVGuY=r8rjmdy-szg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 21, 2018 at 3:11 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On 07/22/2018 12:01 AM, Olof Johansson wrote:
>> On Sat, Jul 21, 2018 at 2:54 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>> On 07/21/2018 11:47 PM, Olof Johansson wrote:
>>>> Hi,
>>>
>>> Hi,
>>>
>>>> On Wed, May 30, 2018 at 3:11 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>>>> Drop the MTD partitioning from DT, since it does not describe HW
>>>>> and to give way to a more flexible kernel command line partition
>>>>> passing.
>>>>>
>>>>> To retain the original partitioning, assure you have enabled
>>>>> CONFIG_MTD_CMDLINE_PARTS in your kernel config and add the
>>>>> following to your kernel command line:
>>>>>
>>>>> lager:   mtdparts=spi0.0:256k(loader),4m(user),-(flash)
>>>>> stout:   mtdparts=spi0.0:512k(loader),256k(uboot),256k(uboot-env),-(flash)
>>>>> koelsch: mtdparts=spi0.0:512k(loader),5632k(user),-(flash)
>>>>> porter:  mtdparts=spi0.0:256k(loader_prg),4m(user_prg),-(flash_fs)
>>>>> wheat:   mtdparts=spi0.0:256k(loader),4m(user),-(flash)
>>>>> gose:    mtdparts=spi0.0:256k(loader),4m(user),-(flash)
>>>>> alt:     mtdparts=spi0.0:256k(loader),256k(system),-(user)
>>>>> silk:    mtdparts=spi0.0:256k(loader),4m(user),-(flash)
>>>>
>>>> Having to specify on command line is such a nasty hack. I wish we
>>>> could remove that, and at the very least not add it for anything new.
>>>
>>> Do you have a better suggestion ?
>>
>> Yes, keep it in DT.
>
> See below
>
>>>> You end up with user space tools trying to parse the kernel command
>>>> line to figure out what's on the flash, and other really bad habits.
>>>> :(
>>>
>>> You should just read /proc/mtd , see
>>> http://www.linux-mtd.infradead.org/doc/general.html
>>
>> Sure, I know that but not everybody does, and they do it in bad ways
>> if given the opportunity.
>
> That's what the documentation is for. I assume whoever is using MTD is
> also capable of reading the documentation and thus avoiding such basic
> mistakes.

Why read the docs when the information obviously is there when you grep it?

I'm agreeing with you -- I've just seen it done wrong so many times.
Making it harder to make mistakes is always a good thing.

>>>> I'd strongly advice you to keep this in the board files, unless you
>>>> have an actual real motivation for changing it. This patch does not
>>>> provide one.
>>>
>>> Partitioning is not hardware description, it should not be in DT.
>>
>> Read my reply again. It's part of _platform_ description, and belongs in DT.
>
> I can repartition the flash whichever way I want for my purposes, just
> like I can repartition a harddrive. We don't have harddrive partitioning
> in the DT, why should we have flash partitioning there ? How do those
> differ ?

A drive can be auto-probed. We have partition tables on the disk that
self-describes the contents.

That doesn't exist on flashes, at least not usually. This is really
unfortunate, I wish we could change _that_ instead of argue here.

If you repartition your disk, you need to change the command line
arguments to the kernel too. It's definitely not an argument to
keeping it on the command line instead.

Also, you now have a dependencies between hardware description, probe
order and stable naming in the kernel, and the command line. With DT,
you have it all in one place, right next to the flash part. It doesn't
matter what name it gets probed at, and nobody needs to know the
mapping to get it right.




-Olof
